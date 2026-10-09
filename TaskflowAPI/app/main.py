import logging
from contextlib import asynccontextmanager
from time import perf_counter
from uuid import UUID, uuid4

from fastapi import Depends, FastAPI, HTTPException, Query, Request, status
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import JSONResponse
from sqlalchemy import select, text
from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import Session

from .config import get_settings
from .database import Base, engine, get_db
from .models import Task, User
from .schemas import TaskCreate, TaskRead, UserCreate, UserRead
from .security import hash_password

logger = logging.getLogger("taskflow.api")
settings = get_settings()


@asynccontextmanager
async def lifespan(_: FastAPI):
    Base.metadata.create_all(bind=engine)
    yield


app = FastAPI(
    title=settings.app_name,
    version="1.0.0",
    description="A production-ready task management API.",
    lifespan=lifespan,
)
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.allowed_origins,
    allow_credentials=bool(settings.allowed_origins),
    allow_methods=["GET", "POST"],
    allow_headers=["*"],
)


@app.middleware("http")
async def request_context(request: Request, call_next):
    request_id = request.headers.get("X-Request-ID", str(uuid4()))
    started = perf_counter()
    try:
        response = await call_next(request)
    except Exception:
        logger.exception("Unhandled request error", extra={"request_id": request_id})
        raise
    response.headers["X-Request-ID"] = request_id
    response.headers["X-Process-Time"] = f"{perf_counter() - started:.6f}"
    return response


@app.get("/", tags=["system"])
def welcome() -> dict[str, str]:
    return {"message": "Welcome to TaskFlow API"}


@app.get("/health", tags=["system"])
def health(db: Session = Depends(get_db)) -> dict[str, str]:
    try:
        db.execute(text("SELECT 1"))
    except Exception:
        logger.exception("Health check database probe failed")
        return JSONResponse(status_code=503, content={"status": "unhealthy"})
    return {"status": "healthy"}


@app.post("/users", response_model=UserRead, status_code=status.HTTP_201_CREATED, tags=["users"])
def create_user(payload: UserCreate, db: Session = Depends(get_db)) -> User:
    user = User(
        email=payload.email.lower(),
        username=payload.username,
        full_name=payload.full_name,
        hashed_password=hash_password(payload.password),
    )
    db.add(user)
    try:
        db.commit()
    except IntegrityError:
        db.rollback()
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="A user with that email or username already exists.",
        ) from None
    db.refresh(user)
    return user


@app.get("/users", response_model=list[UserRead], tags=["users"])
def list_users(
    limit: int = Query(default=settings.default_page_size, ge=1, le=100),
    offset: int = Query(default=0, ge=0),
    db: Session = Depends(get_db),
) -> list[User]:
    return list(db.scalars(select(User).order_by(User.created_at, User.id).offset(offset).limit(limit)))


@app.get("/users/{user_id}", response_model=UserRead, tags=["users"])
def get_user(user_id: UUID, db: Session = Depends(get_db)) -> User:
    user = db.get(User, str(user_id))
    if user is None:
        raise HTTPException(status_code=404, detail="User not found.")
    return user


@app.post("/tasks", response_model=TaskRead, status_code=status.HTTP_201_CREATED, tags=["tasks"])
def create_task(payload: TaskCreate, db: Session = Depends(get_db)) -> Task:
    if payload.assignee_id is not None and db.get(User, str(payload.assignee_id)) is None:
        raise HTTPException(status_code=404, detail="Assignee not found.")
    task = Task(
        title=payload.title,
        description=payload.description,
        status=payload.status.value,
        priority=payload.priority.value,
        assignee_id=str(payload.assignee_id) if payload.assignee_id else None,
    )
    db.add(task)
    db.commit()
    db.refresh(task)
    return task


@app.get("/tasks", response_model=list[TaskRead], tags=["tasks"])
def list_tasks(
    status_filter: str | None = Query(default=None, alias="status", pattern=r"^(todo|in_progress|done|blocked)$"),
    priority: str | None = Query(default=None, pattern=r"^(low|medium|high|urgent)$"),
    limit: int = Query(default=settings.default_page_size, ge=1, le=100),
    offset: int = Query(default=0, ge=0),
    db: Session = Depends(get_db),
) -> list[Task]:
    filters = []
    if status_filter is not None:
        filters.append(Task.status == status_filter)
    if priority is not None:
        filters.append(Task.priority == priority)
    query = select(Task).where(*filters).order_by(Task.created_at, Task.id)
    return list(db.scalars(query.offset(offset).limit(limit)))


@app.get("/tasks/{task_id}", response_model=TaskRead, tags=["tasks"])
def get_task(task_id: UUID, db: Session = Depends(get_db)) -> Task:
    task = db.get(Task, str(task_id))
    if task is None:
        raise HTTPException(status_code=404, detail="Task not found.")
    return task

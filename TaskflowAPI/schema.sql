---

# 🚀 FastAPI Mastery: 10-Day Course

## Project Overview: **TaskFlow API**
A production-grade task management & team collaboration platform with:
- User authentication & role-based access (OAuth2 + JWT)
- Task CRUD with file attachments
- Real-time notifications via WebSockets
- Background email processing
- Full test coverage & Docker deployment

---

## 📅 Day 1: Python Types, Async Basics & Your First API
**Duration:** ~4 hours

### Morning (2 hrs): Python Types & Concurrency Foundations
- **Python Types Intro**: Type hints, `typing` module, `Optional`, `List`, `Dict`, `Union`
- **Concurrency and async/await**: Event loops, `asyncio`, `async`/`await` syntax, difference between sync and async functions

### Afternoon (2 hrs): First Steps with FastAPI
- Installing FastAPI and Uvicorn
- Creating your first FastAPI application
- Understanding ASGI and why FastAPI is fast
- Auto-generated docs: Swagger UI (`/docs`) and ReDoc (`/redoc`)
- **Project Setup**: Initialize TaskFlow API project structure

> **Project Milestone**: Running `GET /health` endpoint with app metadata

---

## 📅 Day 2: Routing, Parameters & Request Handling
**Duration:** ~4 hours

### Morning (2 hrs): URL Parameters & Basic Validation
- **Path Parameters**: Route parameters, type conversion, path order matters
- **Query Parameters**: Optional vs required, default values, multiple values
- **Query Parameters and String Validations**: `min_length`, `max_length`, `regex`, `Query()` class
- **Path Parameters and Numeric Validations**: `ge`, `le`, `gt`, `lt` constraints

### Afternoon (2 hrs): Request Bodies & Advanced Input
- **Request Body**: Pydantic models as request bodies, multiple body parameters
- **Body - Multiple Parameters**: Mixing path, query, and body parameters
- **Body - Fields**: Field-level validation with `Field()`
- **Body - Nested Models**: Complex nested Pydantic models
- **Declare Request Example Data**: Adding example values to schema documentation

> **Project Milestone**: `POST /tasks` with full request validation, nested task metadata, and example data in docs

---

## 📅 Day 3: Advanced Data Handling & Input Models
**Duration:** ~4 hours

### Morning (2 hrs): Specialized Parameter Types
- **Extra Data Types**: `UUID`, `datetime`, `Enum`, `set`, `bytes`, `Decimal`
- **Cookie Parameters**: Reading and validating cookies
- **Header Parameters**: Custom headers, automatic header conversion
- **Cookie Parameter Models**: Pydantic models for cookie validation
- **Header Parameter Models**: Pydantic models for header validation

### Afternoon (2 hrs): Structured Input Patterns
- **Query Parameter Models**: Using Pydantic models to group query parameters
- **Form Data**: `Form()` fields, form-encoded submissions
- **Form Models**: Pydantic models for form data
- **Request Files**: `UploadFile`, file metadata, handling multipart uploads
- **Request Forms and Files**: Combining forms and file uploads

> **Project Milestone**: Task creation with file attachments (cover images), form-based task updates, and header-based API versioning

---

## 📅 Day 4: Responses, Errors & Configuration
**Duration:** ~4 hours

### Morning (2 hrs): Response Handling
- **Response Model - Return Type**: Controlling output with `response_model`
- **Extra Models**: Multiple response models, inheritance patterns
- **Response Status Code**: Explicit status codes per endpoint
- **JSON Compatible Encoder**: Custom JSON serialization

### Afternoon (2 hrs): Error Handling & App Configuration
- **Handling Errors**: `HTTPException`, custom exception classes
- **Path Operation Configuration**: `tags`, `summary`, `description`, `deprecated`, `operation_id`
- **Body - Updates**: `PUT` vs `PATCH`, partial updates with `exclude_unset`

> **Project Milestone**: Full CRUD for tasks with proper HTTP status codes, custom error responses for "task not found", and descriptive OpenAPI metadata

---

## 📅 Day 5: Dependency Injection Deep Dive
**Duration:** ~4 hours

### Morning (2 hrs): Core Dependency Patterns
- **Dependencies**: `Depends()`, dependency functions, caching with `use_cache`
- **Classes as Dependencies**: Dependency classes with `__call__`
- **Sub-dependencies**: Dependency chains and nesting
- **Dependencies in path operation decorators**: Router-level and endpoint-level dependencies

### Afternoon (2 hrs): Advanced Dependency Patterns
- **Global Dependencies**: App-level dependencies
- **Dependencies with yield**: Database sessions, cleanup patterns, context managers
- **Advanced Dependencies**: Parameterized dependencies, dependency overrides for testing

> **Project Milestone**: Database session injection via `yield`, reusable `get_current_user` dependency, and task ownership validation

---

## 📅 Day 6: Security & Authentication
**Duration:** ~4 hours

### Morning (2 hrs): Security Foundations
- **Security - First Steps**: Security schemes in OpenAPI
- **Get Current User**: Dependency-based user retrieval
- **Simple OAuth2 with Password and Bearer**: Password flow basics
- **OAuth2 with Password (and hashing), Bearer with JWT tokens**: Full JWT implementation with password hashing

### Afternoon (2 hrs): Advanced Security
- **Advanced Security**: Token refresh, secure cookie handling
- **OAuth2 scopes**: Role-based access control (RBAC) with scopes
- **HTTP Basic Auth**: Basic authentication patterns

> **Project Milestone**: Complete JWT auth system — registration, login, protected routes, admin/user role scopes, and secure password hashing

---

## 📅 Day 7: Middleware, CORS & Background Processing
**Duration:** ~4 hours

### Morning (2 hrs): Middleware & Cross-Origin Handling
- **Middleware**: Custom middleware, request/response modification
- **CORS (Cross-Origin Resource Sharing)**: Configuring allowed origins, methods, headers
- **Advanced Middleware**: Middleware ordering, conditional middleware

### Afternoon (2 hrs): Background & Async Tasks
- **Background Tasks**: `BackgroundTasks` for email sending, notifications
- **SQL (Relational) Databases**: SQLAlchemy 2.0 async integration, models, sessions
- **Stream JSON Lines**: Streaming large datasets line-by-line

> **Project Milestone**: CORS configured for frontend, middleware for request logging/timing, background email on task assignment, async database operations

---

## 📅 Day 8: Real-Time, WebSockets & Advanced Features
**Duration:** ~4 hours

### Morning (2 hrs): Real-Time Communication
- **WebSockets**: Full-duplex connections, connection management
- **Server-Sent Events (SSE)**: One-way server push for live updates
- **Stream Data**: Streaming responses for large files/logs

### Afternoon (2 hrs): Application Structure & Static Content
- **Bigger Applications - Multiple Files**: Router organization, module splitting
- **Static Files**: Serving uploaded files, static assets
- **Templates**: Jinja2 integration for HTML responses (optional admin panel)
- **Metadata and Docs URLs**: Customizing docs paths, favicon, OpenAPI metadata

> **Project Milestone**: Real-time task comment notifications via WebSockets, SSE for activity feeds, modular router structure

---

## 📅 Day 9: Testing, Debugging & Advanced Patterns
**Duration:** ~4 hours

### Morning (2 hrs): Testing Fundamentals
- **Testing**: `TestClient`, sync testing patterns
- **Async Tests**: `pytest-asyncio`, async test fixtures
- **Testing WebSockets**: WebSocket client testing
- **Testing Events: lifespan and startup-shutdown**: Lifespan event testing

### Afternoon (2 hrs): Advanced Testing & Debugging
- **Testing Dependencies with Overrides**: Mocking dependencies for isolated tests
- **Debugging**: Debug mode, traceback handling, logging configuration
- **Using the Request Directly**: Raw `Request` object access when needed
- **Using Dataclasses**: Pydantic alternatives with dataclasses
- **Settings and Environment Variables**: `pydantic-settings`, `.env` files, environment-based config

> **Project Milestone**: Comprehensive test suite — unit tests for services, integration tests for API endpoints, WebSocket tests, dependency mocking

---

## 📅 Day 10: Deployment, Production & Final Polish
**Duration:** ~4 hours

### Morning (2 hrs): Production Readiness
- **About FastAPI versions**: Version pinning, upgrade strategies
- **About HTTPS**: TLS/SSL, certificate handling
- **Run a Server Manually**: Uvicorn, Gunicorn with Uvicorn workers
- **Server Workers - Uvicorn with Workers**: Multi-process deployment
- **FastAPI in Containers - Docker**: Multi-stage Dockerfile, docker-compose

### Afternoon (2 hrs): Cloud Deployment & Final Integration
- **Deployments Concepts**: Production checklist, health checks
- **Deploy FastAPI on Cloud Providers**: Render, Railway, AWS, GCP patterns
- **FastAPI CLI**: `fastapi dev`, `fastapi run` commands
- **Editor Support**: VS Code/PyCharm extensions, type checking

> **Project Milestone**: Dockerized application, multi-stage build, production-ready `docker-compose.yml`, deployed with health checks and environment configuration

---

## 📋 Bonus Topics (Self-Paced Extensions)

| Topic | Relevance to Project |
|-------|---------------------|
| **Lifespan Events** | Database connection pool startup/shutdown |
| **Sub Applications - Mounts** | Mounting admin dashboard or legacy WSGI apps |
| **Behind a Proxy** | Production deployment behind Nginx/Traefik |
| **OpenAPI Callbacks** | Webhook notifications for external systems |
| **OpenAPI Webhooks** | Async event subscriptions |
| **Including WSGI - Flask, Django** | Gradual migration paths |
| **Generating SDKs** | Auto-generating client libraries from OpenAPI |
| **Advanced Python Types** | `Annotated`, generics, type aliases |
| **JSON with Bytes as Base64** | Binary data in JSON responses |
| **Strict Content-Type Checking** | Security-hardened content validation |
| **Migrate from Pydantic v1 to v2** | Legacy codebase modernization |
| **GraphQL** | Alternative API layer with Strawberry |
| **Custom Request and APIRoute class** | Request/response transformation |
| **Conditional OpenAPI** | Environment-based docs exposure |
| **Extending OpenAPI** | Custom schema extensions |
| **Separate OpenAPI Schemas for Input and Output** | Divergent read/write models |
| **Custom Docs UI Static Assets** | Self-hosted Swagger UI theming |
| **Configure Swagger UI** | OAuth2 redirect, custom branding |
| **Testing a Database** | Test database isolation, rollback patterns |
| **Use Old 403 Authentication Error Status Codes** | Legacy client compatibility |

---

## 🏗️ Final Project Architecture

```
taskflow-api/
├── app/
│   ├── __init__.py
│   ├── main.py                    # FastAPI app, lifespan, middleware
│   ├── core/
│   │   ├── config.py              # Pydantic settings
│   │   ├── security.py            # JWT, password hashing
│   │   └── exceptions.py          # Custom exceptions
│   ├── api/
│   │   ├── deps.py                # Dependencies (DB, current_user)
│   │   └── v1/
│   │       ├── __init__.py
│   │       ├── auth.py            # OAuth2 login/register
│   │       ├── tasks.py           # Task CRUD
│   │       ├── users.py           # User management
│   │       ├── files.py           # File upload/download
│   │       └── ws.py              # WebSocket endpoints
│   ├── models/
│   │   ├── user.py                # SQLAlchemy user model
│   │   └── task.py                # SQLAlchemy task model
│   ├── schemas/
│   │   ├── user.py                # Pydantic user schemas
│   │   ├── task.py                # Pydantic task schemas
│   │   └── token.py               # Token schemas
│   ├── services/
│   │   ├── task_service.py        # Business logic
│   │   ├── email_service.py       # Background email
│   │   └── file_service.py        # File handling
│   ├── db/
│   │   ├── base.py                # Declarative base
│   │   └── session.py             # Async session + engine
│   └── tests/
│       ├── conftest.py            # Pytest fixtures
│       ├── test_auth.py
│       ├── test_tasks.py
│       └── test_ws.py
├── migrations/                    # Alembic migrations
├── uploads/                       # File storage
├── Dockerfile                     # Multi-stage build
├── docker-compose.yml
├── requirements.txt
└── .env.example
```

---

## 🎯 Learning Outcomes

By the end of this 10-day course, you will have built and deployed a **production-ready FastAPI application** covering:

✅ **Type-safe API design** with Pydantic v2  
✅ **Async database operations** with SQLAlchemy 2.0  
✅ **JWT authentication** with OAuth2 and role-based access  
✅ **File handling** with multipart uploads  
✅ **Real-time features** via WebSockets & SSE  
✅ **Background task processing**  
✅ **Comprehensive testing** with pytest  
✅ **Docker containerization**  
✅ **Cloud deployment** strategies  

Each day's content maps directly to the official FastAPI documentation sections, ensuring you're learning from the authoritative source while building something genuinely useful.

Here is the complete **Entity Relationship Diagram (ERD)** for the **TaskFlow API**, designed to align with every day of your 10-day FastAPI course:

---

## 📊 Visual ERD

![TaskFlow API ERD](sandbox:///mnt/agents/output/taskflow_erd.png)

---

## 🗄️ Complete Database Schema

Download the full PostgreSQL DDL: [taskflow_schema.sql](sandbox:///mnt/agents/output/taskflow_schema.sql)

---

## 📋 Schema Overview

| Table | Purpose | Course Day | Relationships |
|-------|---------|-----------|---------------|
| **users** | Authentication & identity | Day 1-2 | Owns teams, assigned tasks, comments, uploads |
| **teams** | Organization containers | Day 2 | Has projects, members, tags, webhooks |
| **team_members** | User-team membership (junction) | Day 5-6 | N:M users ↔ teams with roles |
| **projects** | Task containers within teams | Day 2-3 | Belongs to team, has many tasks |
| **tasks** | Core work items | Day 3-4 | Self-referencing parent/child, has comments, files, tags |
| **task_dependencies** | Task relationship graph (junction) | Day 5 | N:M tasks ↔ tasks (blocks, relates, duplicates) |
| **comments** | Threaded discussions | Day 3 | Self-referencing replies, belongs to task |
| **attachments** | File uploads | Day 3 | Belongs to task, uploaded by user |
| **tags** | Categorization labels | Day 4 | Scoped to team, applied to tasks |
| **task_tags** | Task-tag associations (junction) | Day 4 | N:M tasks ↔ tags |
| **notifications** | User inbox & alerts | Day 7 | Triggered by task events, background processed |
| **activity_log** | Audit trail | Day 7 | Tracks all CRUD actions for compliance |
| **webhooks** | External integrations | Day 8 | Configured per team, event-driven |
| **webhook_deliveries** | Delivery history | Day 8 | Tracks each webhook execution attempt |

---

## 🔗 Key Relationship Patterns

```
┌─────────────────────────────────────────────────────────────────────┐
│  HIERARCHY PATTERN (Self-Referencing)                               │
├─────────────────────────────────────────────────────────────────────┤
│  tasks.parent_task_id → tasks.id                                   │
│  comments.parent_comment_id → comments.id                          │
│                                                                     │
│  Enables: Subtasks, nested comments/replies                         │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  MANY-TO-MANY PATTERN (Junction Tables)                             │
├─────────────────────────────────────────────────────────────────────┤
│  users ↔ teams        via team_members (with role)                   │
│  tasks ↔ tags         via task_tags                                 │
│  tasks ↔ tasks        via task_dependencies (with dependency_type)   │
└─────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────┐
│  OWNERSHIP CHAIN (Authorization Path)                               │
├─────────────────────────────────────────────────────────────────────┤
│  users → owns → teams → has → projects → contains → tasks          │
│                                                                     │
│  Every entity traces back to a team for RLS policies                │
└─────────────────────────────────────────────────────────────────────┘
```

---

## 🎯 Course-to-Schema Mapping

| Day | FastAPI Topic | Schema Tables Added |
|-----|--------------|---------------------|
| **Day 1** | Python Types, First Steps | `users` |
| **Day 2** | Path/Query Parameters, Bigger Apps | `teams`, `projects` |
| **Day 3** | Request Body, Files, Nested Models | `tasks`, `comments`, `attachments` |
| **Day 4** | Extra Data Types, Validation | `tags`, `task_tags` |
| **Day 5** | Dependencies, Sub-dependencies | `task_dependencies`, `team_members` |
| **Day 6** | Security, OAuth2, JWT | RLS policies on all tables |
| **Day 7** | Background Tasks, SQL Databases | `notifications`, `activity_log` |
| **Day 8** | WebSockets, SSE, Advanced | `webhooks`, `webhook_deliveries` |
| **Day 9** | Testing | All tables with test fixtures |
| **Day 10** | Deployment | Full schema with migrations |

---

## 🔒 Security Design (Day 6)

- **Row Level Security (RLS)** enabled on `tasks`, `projects`, `comments`, `attachments`
- Access control via `team_members` junction — users only see data from teams they belong to
- `audit_action` enum tracks every create/update/delete for compliance
- `ip_address` and `user_agent` captured in `activity_log`

---

## 📈 Performance Design

- **30+ indexes** covering all foreign keys, search fields, and filter columns
- **Partial indexes** on `notifications(is_read = false)` and `webhooks(is_active = true)`
- **JSONB** columns (`metadata`, `settings`, `permissions`) for flexible schemas without migrations
- **CHECK constraints** prevent circular dependencies (`task_id != depends_on_task_id`)

 Here is the complete **TaskFlow API Project Specification** — a detailed markdown document covering every aspect of the project:

---

## 📥 Download

**[taskflow_project_spec.md](sandbox:///mnt/agents/output/taskflow_project_spec.md)**  
*(46,946 characters | ~15 pages | 1,156 lines)*

---

## 📋 Document Overview

| Section | Content | Pages |
|---------|---------|-------|
| **1. Project Overview** | Vision, 5 user types, 6 key differentiators | 1 |
| **2. Architecture & Tech Stack** | Full system architecture diagram, 16 technologies | 2 |
| **3. Database Schema** | ASCII ERD, 14 tables with complete field documentation | 3 |
| **4. Core Features** | 7 feature categories mapped to FastAPI documentation topics | 2 |
| **5. API Specification** | 8 endpoint groups, 60+ endpoints, query params, response formats | 4 |
| **6. Authentication & Security** | OAuth2+JWT flow diagram, token payload, headers, rate limits | 2 |
| **7. Real-Time Features** | WebSocket events, presence system, SSE streams | 1 |
| **8. Background Processing** | 8 Celery tasks, 7 email templates | 1 |
| **9. Testing Strategy** | Test pyramid, 6 categories, fixture definitions | 1 |
| **10. Deployment** | Multi-stage Dockerfile, docker-compose, 12-item production checklist | 2 |
| **11. Project Structure** | Complete directory tree with 50+ files explained | 2 |
| **12. Environment Configuration** | 18 required env vars, Pydantic Settings class | 1 |
| **13. Development Roadmap** | 10-day course mapping, post-course enhancement phases | 1 |
| **Appendix A** | OpenAPI security schemes & reusable components | 1 |
| **Appendix B** | Performance targets & SLAs | 1 |

---

## 🎯 Key Statistics

| Metric | Value |
|--------|-------|
| **Total API Endpoints** | 60+ |
| **Database Tables** | 14 (including 3 junction tables) |
| **Self-Referencing Relations** | 2 (tasks parent/child, comments replies) |
| **ENUM Types** | 7 |
| **Environment Variables** | 18 |
| **Middleware Layers** | 6 (CORS → Rate Limit → Auth → Logging → Error → Timing) |
| **Celery Background Tasks** | 8 |
| **Email Templates** | 7 |
| **Test Categories** | 6 |
| **Production Checklist Items** | 12 |

---

## 🔗 FastAPI Documentation Mapping

Every feature in the specification directly maps to a section in the official FastAPI documentation:

| Feature | FastAPI Docs Section |
|---------|---------------------|
| OAuth2 Password Flow | *Security - First Steps* |
| JWT with Bearer tokens | *OAuth2 with Password (and hashing), Bearer with JWT tokens* |
| File uploads with metadata | *Request Files*, *Request Forms and Files* |
| WebSocket real-time updates | *WebSockets* |
| Background email processing | *Background Tasks* |
| SQLAlchemy async integration | *SQL (Relational) Databases* |
| Dependency injection with yield | *Dependencies with yield* |
| OAuth2 scopes for RBAC | *OAuth2 scopes* |
| Custom exception handling | *Handling Errors* |
| Request/response logging | *Middleware* |
| CORS configuration | *CORS (Cross-Origin Resource Sharing)* |
| Testing with overrides | *Testing Dependencies with Overrides* |
| Lifespan events | *Lifespan Events* |
| Streaming responses | *Stream Data*, *Stream JSON Lines* |
| Server-Sent Events | *Server-Sent Events (SSE)* |
| Custom OpenAPI extensions | *Extending OpenAPI* |
| Self-hosted docs | *Custom Docs UI Static Assets* |

---

## 📊 Architecture Preview

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Client    │────►│   FastAPI   │────►│   PostgreSQL│
│  (React)    │     │   /login    │     │   (users)   │
└─────────────┘     └──────┬──────┘     └─────────────┘
                           │
                    ┌──────┴──────┐
                    │  Verify PW    │
                    │  (bcrypt)     │
                    └──────┬──────┘
                           │
                    ┌──────┴──────┐
                    │ Generate JWT  │
                    │ Access: 15m   │
                    │ Refresh: 7d   │
                    └──────┬──────┘
                           │
┌─────────────┐     ┌──────┴──────┐
│   Client    │◄────│ Return Tokens │
│  (stores)   │     └─────────────┘
└─────────────┘
```

---

## 🗄️ Database Tables (14 Total)

| Table | Type | Purpose |
|-------|------|---------|
| `users` | Core | Authentication & identity |
| `teams` | Core | Organization containers |
| `team_members` | Junction | User-team memberships with roles |
| `projects` | Core | Task containers within teams |
| `tasks` | Core | Work items with self-referencing hierarchy |
| `task_dependencies` | Junction | Task-to-task relationships |
| `comments` | Core | Threaded discussions (self-referencing replies) |
| `attachments` | Core | File uploads linked to tasks |
| `tags` | Core | Categorization labels per team |
| `task_tags` | Junction | Task-tag associations |
| `notifications` | Core | User notification inbox |
| `activity_log` | Core | Immutable audit trail |
| `webhooks` | Core | External integration endpoints |
| `webhook_deliveries` | Core | Webhook execution history |

---

## 🚀 API Endpoint Groups (60+ Endpoints)

| Group | Base Path | Endpoints |
|-------|-----------|-----------|
| Authentication | `/api/v1/auth` | 10 (register, login, refresh, logout, etc.) |
| Users | `/api/v1/users` | 6 |
| Teams | `/api/v1/teams` | 13 |
| Projects | `/api/v1/projects` | 10 |
| Tasks | `/api/v1/tasks` | 19 |
| Comments | `/api/v1/comments` | 5 |
| Attachments | `/api/v1/attachments` | 3 |
| Notifications | `/api/v1/notifications` | 7 |
| Webhooks | `/api/v1/webhooks` | 8 |
| Real-Time | `/ws`, `/sse` | 4 |

---

## 🛡️ Security Features

- **OAuth2 Password Bearer** with JWT access/refresh token pair
- **bcrypt/Argon2** password hashing
- **Role-Based Access Control** with OAuth2 scopes
- **Row Level Security (RLS)** on PostgreSQL
- **Rate limiting** by endpoint type (auth: 5/min, API: 1000/min)
- **Security headers** (HSTS, CSP, X-Frame-Options, etc.)
- **Request ID tracing** for audit trails
- **HMAC-SHA256 webhook signatures**

---

## 📦 Deployment Stack

| Service | Technology | Purpose |
|---------|-----------|---------|
| API | FastAPI + Uvicorn + Gunicorn | Application server |
| Database | PostgreSQL 15+ | Primary data store |
| Cache/Queue | Redis 7+ | Sessions, rate limiting, Celery broker |
| Background Workers | Celery | Email, webhooks, file processing |
| File Storage | MinIO / AWS S3 | Attachments and exports |
| Monitoring | Prometheus + Grafana | Metrics and dashboards |
| Error Tracking | Sentry | Exception monitoring |
| Logs | structlog | Structured JSON logging |

---

## 📅 10-Day Course Mapping

| Day | FastAPI Topics | What You Build |
|-----|---------------|---------------|
| **Day 1** | Python Types, Async, First Steps | App setup, health check, basic models |
| **Day 2** | Path/Query Parameters, Request Body | User CRUD, team creation, projects |
| **Day 3** | Validation, Nested Models, Files | Task CRUD, comments, file uploads |
| **Day 4** | Extra Data Types, Cookies, Headers | Tags, filtering, sorting, search |
| **Day 5** | Dependencies, Sub-dependencies | Team membership, task dependencies |
| **Day 6** | Security, OAuth2, JWT | Full auth, RBAC, scopes |
| **Day 7** | Middleware, CORS, Background Tasks | Notifications, email, SQL DB |
| **Day 8** | WebSockets, SSE, Bigger Apps | Real-time updates, modular structure |
| **Day 9** | Testing, Debugging | Full test suite, async tests |
| **Day 10** | Deployment, Docker, Cloud | Containers, production, cloud deploy |



-- ═══════════════════════════════════════════════════════════════════════
-- TASKFLOW API — COMPLETE DATABASE SCHEMA (PostgreSQL)
-- ═══════════════════════════════════════════════════════════════════════

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ═══════════════════════════════════════════════════════════════════════
-- 1. USERS TABLE (Day 1-2: Authentication & First Steps)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE user_role AS ENUM ('admin', 'user', 'guest');

CREATE TABLE users (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email           VARCHAR(255) NOT NULL UNIQUE,
    username        VARCHAR(100) NOT NULL UNIQUE,
    hashed_password VARCHAR(255) NOT NULL,
    full_name       VARCHAR(200),
    avatar_url      VARCHAR(500),
    role            user_role DEFAULT 'user',
    is_active       BOOLEAN DEFAULT true,
    is_verified     BOOLEAN DEFAULT false,
    last_login_at   TIMESTAMP WITH TIME ZONE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_active ON users(is_active);

-- ═══════════════════════════════════════════════════════════════════════
-- 2. TEAMS TABLE (Day 2: Bigger Applications)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE teams (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(150) NOT NULL,
    slug        VARCHAR(150) NOT NULL UNIQUE,
    description TEXT,
    owner_id    UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    avatar_url  VARCHAR(500),
    settings    JSONB DEFAULT '{}',
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_teams_slug ON teams(slug);
CREATE INDEX idx_teams_owner ON teams(owner_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 3. TEAM_MEMBERS (Junction: Users ↔ Teams) (Day 5-6: Dependencies)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE team_member_role AS ENUM ('owner', 'admin', 'member');

CREATE TABLE team_members (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id     UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    user_id     UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role        team_member_role DEFAULT 'member',
    permissions JSONB DEFAULT '{}',
    joined_at   TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(team_id, user_id)
);

CREATE INDEX idx_team_members_team ON team_members(team_id);
CREATE INDEX idx_team_members_user ON team_members(user_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 4. PROJECTS TABLE (Day 2-3: Path Parameters, Query Parameters)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE project_status AS ENUM ('active', 'archived', 'deleted');

CREATE TABLE projects (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(200) NOT NULL,
    slug        VARCHAR(200) NOT NULL,
    description TEXT,
    team_id     UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    owner_id    UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    status      project_status DEFAULT 'active',
    color       VARCHAR(7) DEFAULT '#3b82f6',
    settings    JSONB DEFAULT '{}',
    start_date  DATE,
    end_date    DATE,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(team_id, slug)
);

CREATE INDEX idx_projects_team ON projects(team_id);
CREATE INDEX idx_projects_status ON projects(status);
CREATE INDEX idx_projects_owner ON projects(owner_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 5. TASKS TABLE (Day 3-4: Request Body, Path/Query Validation)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE task_status AS ENUM ('todo', 'in_progress', 'done', 'blocked');
CREATE TYPE task_priority AS ENUM ('low', 'medium', 'high', 'urgent');
CREATE TYPE task_type AS ENUM ('feature', 'bug', 'task', 'epic');

CREATE TABLE tasks (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    title           VARCHAR(300) NOT NULL,
    slug            VARCHAR(300) NOT NULL,
    description     TEXT,
    project_id      UUID NOT NULL REFERENCES projects(id) ON DELETE CASCADE,
    assignee_id     UUID REFERENCES users(id) ON DELETE SET NULL,
    reporter_id     UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    parent_task_id  UUID REFERENCES tasks(id) ON DELETE CASCADE,
    status          task_status DEFAULT 'todo',
    priority        task_priority DEFAULT 'medium',
    task_type       task_type DEFAULT 'task',
    story_points    INTEGER CHECK (story_points >= 0),
    due_date        TIMESTAMP WITH TIME ZONE,
    completed_at    TIMESTAMP WITH TIME ZONE,
    metadata        JSONB DEFAULT '{}',
    position        INTEGER DEFAULT 0,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(project_id, slug)
);

CREATE INDEX idx_tasks_project ON tasks(project_id);
CREATE INDEX idx_tasks_assignee ON tasks(assignee_id);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_priority ON tasks(priority);
CREATE INDEX idx_tasks_due_date ON tasks(due_date);
CREATE INDEX idx_tasks_parent ON tasks(parent_task_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 6. TASK_DEPENDENCIES (Day 5: Sub-dependencies, Advanced Dependencies)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE dependency_type AS ENUM ('blocks', 'relates', 'duplicates');

CREATE TABLE task_dependencies (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    task_id             UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    depends_on_task_id  UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    dependency_type     dependency_type DEFAULT 'relates',
    created_at          TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(task_id, depends_on_task_id),
    CHECK (task_id != depends_on_task_id)
);

CREATE INDEX idx_task_deps_task ON task_dependencies(task_id);
CREATE INDEX idx_task_deps_depends ON task_dependencies(depends_on_task_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 7. COMMENTS TABLE (Day 3: Request Body, Nested Models)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE comments (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    task_id             UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    author_id           UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    parent_comment_id   UUID REFERENCES comments(id) ON DELETE CASCADE,
    content             TEXT NOT NULL,
    is_edited           BOOLEAN DEFAULT false,
    mentions            JSONB DEFAULT '[]',
    reactions           JSONB DEFAULT '{}',
    created_at          TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at          TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_comments_task ON comments(task_id);
CREATE INDEX idx_comments_author ON comments(author_id);
CREATE INDEX idx_comments_parent ON comments(parent_comment_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 8. ATTACHMENTS TABLE (Day 3: Request Files, Form Data)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE attachments (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    task_id         UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    uploader_id     UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    filename        VARCHAR(255) NOT NULL,
    original_name   VARCHAR(255) NOT NULL,
    file_path       VARCHAR(500) NOT NULL,
    file_size       BIGINT NOT NULL,
    mime_type       VARCHAR(100) NOT NULL,
    checksum        VARCHAR(64),
    is_thumbnail    BOOLEAN DEFAULT false,
    metadata        JSONB DEFAULT '{}',
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_attachments_task ON attachments(task_id);
CREATE INDEX idx_attachments_uploader ON attachments(uploader_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 9. TAGS TABLE (Day 4: Extra Data Types)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE tags (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    name        VARCHAR(50) NOT NULL,
    color       VARCHAR(7) DEFAULT '#64748b',
    team_id     UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    usage_count INTEGER DEFAULT 0,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(team_id, name)
);

CREATE INDEX idx_tags_team ON tags(team_id);
CREATE INDEX idx_tags_name ON tags(name);

-- ═══════════════════════════════════════════════════════════════════════
-- 10. TASK_TAGS (Junction: Tasks ↔ Tags)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE task_tags (
    id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    task_id     UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
    tag_id      UUID NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
    created_at  TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(task_id, tag_id)
);

CREATE INDEX idx_task_tags_task ON task_tags(task_id);
CREATE INDEX idx_task_tags_tag ON task_tags(tag_id);

-- ═══════════════════════════════════════════════════════════════════════
-- 11. NOTIFICATIONS TABLE (Day 7: Background Tasks, Middleware)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE notification_type AS ENUM (
    'mention', 'assignment', 'status_change', 'comment', 'due_soon'
);

CREATE TABLE notifications (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    recipient_id        UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    actor_id            UUID REFERENCES users(id) ON DELETE SET NULL,
    task_id             UUID REFERENCES tasks(id) ON DELETE CASCADE,
    notification_type   notification_type NOT NULL,
    title               VARCHAR(200) NOT NULL,
    message             TEXT,
    data                JSONB DEFAULT '{}',
    is_read             BOOLEAN DEFAULT false,
    read_at             TIMESTAMP WITH TIME ZONE,
    email_sent          BOOLEAN DEFAULT false,
    push_sent           BOOLEAN DEFAULT false,
    created_at          TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_notifications_recipient ON notifications(recipient_id);
CREATE INDEX idx_notifications_task ON notifications(task_id);
CREATE INDEX idx_notifications_type ON notifications(notification_type);
CREATE INDEX idx_notifications_unread ON notifications(recipient_id, is_read) WHERE is_read = false;

-- ═══════════════════════════════════════════════════════════════════════
-- 12. ACTIVITY_LOG / AUDIT TABLE (Day 7: Background Tasks)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TYPE audit_action AS ENUM (
    'create', 'update', 'delete', 'comment', 'assign', 'status_change'
);
CREATE TYPE audit_entity_type AS ENUM ('task', 'project', 'comment', 'file');

CREATE TABLE activity_log (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id         UUID REFERENCES users(id) ON DELETE SET NULL,
    task_id         UUID REFERENCES tasks(id) ON DELETE CASCADE,
    project_id      UUID REFERENCES projects(id) ON DELETE CASCADE,
    action          audit_action NOT NULL,
    entity_type     audit_entity_type NOT NULL,
    entity_id       UUID NOT NULL,
    old_values      JSONB,
    new_values      JSONB,
    ip_address      INET,
    user_agent      TEXT,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_activity_user ON activity_log(user_id);
CREATE INDEX idx_activity_task ON activity_log(task_id);
CREATE INDEX idx_activity_project ON activity_log(project_id);
CREATE INDEX idx_activity_action ON activity_log(action);
CREATE INDEX idx_activity_created ON activity_log(created_at);

-- ═══════════════════════════════════════════════════════════════════════
-- 13. WEBHOOKS TABLE (Day 8: Advanced Features)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE webhooks (
    id                  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    team_id             UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
    name                VARCHAR(150) NOT NULL,
    url                 VARCHAR(500) NOT NULL,
    secret              VARCHAR(255),
    events              JSONB NOT NULL DEFAULT '[]',
    is_active           BOOLEAN DEFAULT true,
    last_triggered_at   TIMESTAMP WITH TIME ZONE,
    failure_count       INTEGER DEFAULT 0,
    created_at          TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_webhooks_team ON webhooks(team_id);
CREATE INDEX idx_webhooks_active ON webhooks(team_id, is_active) WHERE is_active = true;

-- ═══════════════════════════════════════════════════════════════════════
-- 14. WEBHOOK_DELIVERIES TABLE (Day 8: Advanced Features)
-- ═══════════════════════════════════════════════════════════════════════
CREATE TABLE webhook_deliveries (
    id              UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    webhook_id      UUID NOT NULL REFERENCES webhooks(id) ON DELETE CASCADE,
    event_type      VARCHAR(50) NOT NULL,
    payload         JSONB NOT NULL,
    response_status INTEGER,
    response_body   TEXT,
    attempt_count   INTEGER DEFAULT 1,
    delivered_at    TIMESTAMP WITH TIME ZONE,
    created_at      TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_webhook_deliveries_webhook ON webhook_deliveries(webhook_id);
CREATE INDEX idx_webhook_deliveries_event ON webhook_deliveries(event_type);

-- ═══════════════════════════════════════════════════════════════════════
-- TRIGGERS FOR updated_at AUTO-UPDATE
-- ═══════════════════════════════════════════════════════════════════════
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_teams_updated_at BEFORE UPDATE ON teams
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_projects_updated_at BEFORE UPDATE ON projects
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_tasks_updated_at BEFORE UPDATE ON tasks
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_comments_updated_at BEFORE UPDATE ON comments
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- ═══════════════════════════════════════════════════════════════════════
-- ROW LEVEL SECURITY (RLS) POLICIES (Day 6: Security, OAuth2 Scopes)
-- ═══════════════════════════════════════════════════════════════════════
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;
ALTER TABLE attachments ENABLE ROW LEVEL SECURITY;

-- Tasks: Users can see tasks in projects they belong to
CREATE POLICY tasks_team_access ON tasks
    FOR ALL USING (
        EXISTS (
            SELECT 1 FROM projects p
            JOIN team_members tm ON p.team_id = tm.team_id
            WHERE p.id = tasks.project_id AND tm.user_id = current_setting('app.current_user_id')::UUID
        )
    );

-- ═══════════════════════════════════════════════════════════════════════
-- SCHEMA STATISTICS
-- ═══════════════════════════════════════════════════════════════════════
-- Total Tables: 14
-- Total Indexes: 30+
-- Total Enums: 7
-- Triggers: 5
-- RLS Policies: 1 (example)
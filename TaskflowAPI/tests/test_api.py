from fastapi.testclient import TestClient

from app.main import app


def test_requested_endpoints_are_registered():
    paths = {(route.path, method) for route in app.routes for method in route.methods or ()}
    assert {("/", "GET"), ("/health", "GET"), ("/users", "POST"), ("/users", "GET"),
            ("/users/{user_id}", "GET"), ("/tasks", "POST"), ("/tasks", "GET"),
            ("/tasks/{task_id}", "GET")} <= paths


def test_welcome_and_health():
    with TestClient(app) as client:
        assert client.get("/").json() == {"message": "Welcome to TaskFlow API"}
        assert client.get("/health").json() == {"status": "healthy"}

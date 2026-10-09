# TaskFlow API — Complete Project Specification

> **Production-Grade Task Management & Team Collaboration Platform**  
> Built with FastAPI | 10-Day Mastery Course | Single Project from Basics to Deployment

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Architecture & Tech Stack](#2-architecture--tech-stack)
3. [Database Schema](#3-database-schema)
4. [Core Features](#4-core-features)
5. [API Specification](#5-api-specification)
6. [Authentication & Security](#6-authentication--security)
7. [Real-Time Features](#7-real-time-features)
8. [Background Processing](#8-background-processing)
9. [Testing Strategy](#9-testing-strategy)
10. [Deployment](#10-deployment)
11. [Project Structure](#11-project-structure)
12. [Environment Configuration](#12-environment-configuration)
13. [Development Roadmap](#13-development-roadmap)

---

## 1. Project Overview

### 1.1 Vision

TaskFlow is a **SaaS-style backend API** for modern team task management. It demonstrates every concept from the FastAPI documentation through a single, cohesive, production-ready application that teams could actually use.

### 1.2 Target Users

| User Type | Role | Permissions |
|-----------|------|-------------|
| **Admin** | System administrator | Full CRUD on all resources, user management |
| **Team Owner** | Created the team | Full team management, billing, webhooks |
| **Team Admin** | Promoted by owner | Manage projects, members, moderate content |
| **Team Member** | Standard user | Create/edit tasks, comment, upload files |
| **Guest** | External collaborator | View assigned tasks, comment only |

### 1.3 Key Differentiators

- **Real-time collaboration** via WebSockets (live cursors, instant updates)
- **Smart notifications** with email + push delivery
- **Full audit trail** for compliance (GDPR, SOC2)
- **Webhook integrations** for external tools (Slack, Discord, custom)
- **Streaming exports** for large datasets (JSON Lines, CSV)
- **File handling** with virus scanning and thumbnail generation

---

## 2. Architecture & Tech Stack

### 2.1 High-Level Architecture

```
+-----------------------------------------------------------------------------+
|                              CLIENT LAYER                                    |
|  +-------------+  +-------------+  +-------------+  +---------------------+ |
|  | Web App     |  | Mobile App  |  | CLI Tool    |  | Third-Party Integr. | |
|  | (React/Vue) |  | (React Nat.)|  | (Python)    |  | (Slack, GitHub)     | |
|  +------+------+  +------+------+  +------+------+  +----------+----------+ |
+--------+----------------+----------------+--------------------+-------------+
         |                |                |                    |
         +----------------+----------------+--------------------+
                           |
                 +---------+---------+
                 |   Load Balancer   |  (Nginx / Traefik)
                 |   (SSL/TLS)       |
                 +---------+---------+
                           |
+-----------------------------------------------------------------------------+
|                           APPLICATION LAYER                                  |
|  +-----------------------------------------------------------------------+  |
|  |                         FastAPI Application                            |  |
|  |  +-------------+  +-------------+  +-------------+  +-------------+  |  |
|  |  | Auth Router |  | Task Router |  | File Router |  | WS Router   |  |  |
|  |  | /api/v1/auth|  | /api/v1/tasks| | /api/v1/files| | /ws         |  |  |
|  |  +-------------+  +-------------+  +-------------+  +-------------+  |  |
|  |  +-------------+  +-------------+  +-------------+  +-------------+  |  |
|  |  | User Router |  | Team Router |  | Project Rt. |  | Webhook Rt. |  |  |
|  |  | /api/v1/users| | /api/v1/teams| | /api/v1/projects| /api/v1/hooks| |  |
|  |  +-------------+  +-------------+  +-------------+  +-------------+  |  |
|  +-----------------------------------------------------------------------+  |
|  +-----------------------------------------------------------------------+  |
|  |                      Middleware Stack                                  |  |
|  |  CORS -> Rate Limit -> Auth -> Logging -> Error Handling -> Timing    |  |
|  +-----------------------------------------------------------------------+  |
+-----------------------------------+-----------------------------------------+
                                    |
+-----------------------------------+-----------------------------------------+
|                           SERVICE LAYER                                      |
|  +-------------+  +-------------+  +-------------+  +---------------------+ |
|  | AuthService |  | TaskService |  | FileService |  | NotificationService | |
|  | (JWT, OAuth2)| | (CRUD, Search)| | (Upload, S3)| | (Email, Push, WS)  | |
|  +-------------+  +-------------+  +-------------+  +---------------------+ |
|  +-------------+  +-------------+  +-------------+  +---------------------+ |
|  | TeamService |  | AuditService |  | WebhookSvc  |  | SearchService       | |
|  | (RBAC)      |  | (Compliance) |  | (Delivery)  |  | (Full-text, Filter) | |
|  +-------------+  +-------------+  +-------------+  +---------------------+ |
+-----------------------------------+-----------------------------------------+
                                    |
+-----------------------------------+-----------------------------------------+
|                           DATA LAYER                                         |
|  +-----------------+  +-----------------+  +-----------------------------+  |
|  | PostgreSQL      |  | Redis           |  | S3-Compatible Storage       |  |
|  | (Primary DB)    |  | (Cache/Queue)   |  | (File Attachments)          |  |
|  |                 |  |                 |  |                             |  |
|  | - Users         |  | - Session Store |  | - Task Attachments          |  |
|  | - Teams         |  | - Rate Limiting |  | - User Avatars              |  |
|  | - Projects      |  | - Task Queues   |  | - Exported Reports          |  |
|  | - Tasks         |  | - Real-time Pub |  | - Backup Archives           |  |
|  | - Comments      |  |                 |  |                             |  |
|  | - Audit Logs    |  |                 |  |                             |  |
|  +-----------------+  +-----------------+  +-----------------------------+  |
+-----------------------------------------------------------------------------+
```

### 2.2 Technology Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| **Framework** | FastAPI 0.110+ | Async web framework, auto OpenAPI docs |
| **Server** | Uvicorn + Gunicorn | ASGI server with worker processes |
| **Database** | PostgreSQL 15+ | Primary relational database |
| **ORM** | SQLAlchemy 2.0 (async) | Database models and queries |
| **Migrations** | Alembic | Schema versioning and migrations |
| **Cache** | Redis 7+ | Session storage, rate limiting, pub/sub |
| **Queue** | Celery + Redis | Background task processing |
| **Storage** | MinIO / AWS S3 | File attachments and exports |
| **Auth** | OAuth2 + JWT | Stateless authentication |
| **Password Hashing** | bcrypt / Argon2 | Secure password storage |
| **Email** | aiosmtplib / SendGrid | Async email delivery |
| **Monitoring** | Prometheus + Grafana | Metrics and dashboards |
| **Logging** | structlog | Structured JSON logging |
| **Testing** | pytest + pytest-asyncio | Unit and integration tests |
| **Container** | Docker + Docker Compose | Development and deployment |
| **CI/CD** | GitHub Actions | Automated testing and deployment |

---

## 3. Database Schema

### 3.1 Entity Relationship Diagram

```
+-------------+       +-------------+       +-----------------+
|   USERS     |<------|   TEAMS     |<------|  TEAM_MEMBERS   |
|-------------|  1:N  |-------------|  1:N  |-----------------|
| id (PK)     |       | id (PK)     |       | id (PK)         |
| email (UQ)  |       | name        |       | team_id (FK)    |
| username(UQ)|       | slug (UQ)   |       | user_id (FK)    |
| password    |       | owner_id(FK)|       | role            |
| full_name   |       | description |       | permissions     |
| role        |       | settings    |       | joined_at       |
| is_active   |       | created_at  |       +-----------------+
| created_at  |       +------+------+
+------+------+              |
       |                     |
       |              +------+------+
       |              |  PROJECTS   |
       |              |-------------|
       |              | id (PK)     |
       |              | name        |
       |              | slug        |
       |              | team_id(FK) |
       |              | owner_id(FK)|
       |              | status      |
       |              | color       |
       |              | settings    |
       |              | start_date  |
       |              | end_date    |
       |              +------+------+
       |                     |
       |              +------+------+
       |              |    TASKS    |<------------------------+
       |              |-------------|                         |
       |              | id (PK)     |                         |
       +------------->| assignee_id |                         |
       (assignee)     | reporter_id |                         |
                      | project_id  |                         |
                      | parent_task_id ----------+             |
                      | title       |          |              |
                      | description |          | (self-ref)   |
                      | status      |          |              |
                      | priority    |          |              |
                      | task_type   |          |              |
                      | story_points|          |              |
                      | due_date    |          |              |
                      | completed_at|          |              |
                      | position    |          |              |
                      +------+------+          |              |
                             |                 |              |
              +--------------+--------------+ |              |
              |              |              | |              |
       +------+------++-----+-----++------+------+  +------+------+
       |  COMMENTS   || ATTACHMENTS|| TASK_TAGS   |  |TASK_DEPS    |
       |-------------||-----------||-------------|  |-------------|
       | id (PK)     || id (PK)   || id (PK)     |  | id (PK)     |
       | task_id(FK) || task_id(FK)|| task_id(FK) |  | task_id(FK) |
       | author_id(FK)||uploader_id|| tag_id (FK) |  | depends_on  |
       | parent_id   || filename  |+------+------+  | dependency  |
       | content     || file_path |       |         | type        |
       | is_edited   || file_size ||------+------+  +-------------+
       | mentions    || mime_type ||    TAGS     |
       | reactions   || checksum  ||-------------|
       +-------------++-----------+| id (PK)     |
                                   | name        |
                                   | color       |
                                   | team_id(FK) |
                                   +-------------+

+-----------------+-----------------+-----------------+
|  NOTIFICATIONS  |  ACTIVITY_LOG   |    WEBHOOKS     |
|-----------------|-----------------|-----------------|
| id (PK)         | id (PK)         | id (PK)         |
| recipient_id(FK)| user_id (FK)    | team_id (FK)    |
| actor_id (FK)   | task_id (FK)    | name            |
| task_id (FK)    | project_id (FK) | url             |
| type            | action          | secret          |
| title           | entity_type     | events          |
| message         | entity_id       | is_active       |
| data            | old_values      | failure_count   |
| is_read         | new_values      +--------+--------+
| read_at         | ip_address               |
| email_sent      | user_agent      +--------+--------+
| push_sent       | created_at      |WEBHOOK_DELIVERIES|
+-----------------+-----------------|-----------------|
                                   | id (PK)         |
                                   | webhook_id (FK) |
                                   | event_type      |
                                   | payload         |
                                   | response_status |
                                   | attempt_count   |
                                   +-----------------+
```

### 3.2 Schema Details

#### Users Table
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PRIMARY KEY | Unique identifier |
| `email` | VARCHAR(255) | NOT NULL, UNIQUE | Login email |
| `username` | VARCHAR(100) | NOT NULL, UNIQUE | Display name |
| `hashed_password` | VARCHAR(255) | NOT NULL | bcrypt hash |
| `full_name` | VARCHAR(200) | NULL | Real name |
| `avatar_url` | VARCHAR(500) | NULL | Profile picture |
| `role` | ENUM | DEFAULT 'user' | System role |
| `is_active` | BOOLEAN | DEFAULT true | Account status |
| `is_verified` | BOOLEAN | DEFAULT false | Email verified |
| `last_login_at` | TIMESTAMP | NULL | Last session |
| `created_at` | TIMESTAMP | DEFAULT NOW() | Registration |
| `updated_at` | TIMESTAMP | DEFAULT NOW() | Last update |

#### Tasks Table
| Column | Type | Constraints | Description |
|--------|------|-------------|-------------|
| `id` | UUID | PRIMARY KEY | Unique identifier |
| `title` | VARCHAR(300) | NOT NULL | Task name |
| `slug` | VARCHAR(300) | NOT NULL | URL-friendly |
| `description` | TEXT | NULL | Details |
| `project_id` | UUID | FK -> projects | Parent project |
| `assignee_id` | UUID | FK -> users | Assigned to |
| `reporter_id` | UUID | FK -> users | Created by |
| `parent_task_id` | UUID | FK -> tasks | Subtask parent |
| `status` | ENUM | DEFAULT 'todo' | Workflow state |
| `priority` | ENUM | DEFAULT 'medium' | Urgency |
| `task_type` | ENUM | DEFAULT 'task' | Category |
| `story_points` | INTEGER | CHECK >= 0 | Effort estimate |
| `due_date` | TIMESTAMP | NULL | Deadline |
| `completed_at` | TIMESTAMP | NULL | Finish time |
| `metadata` | JSONB | DEFAULT '{}' | Flexible data |
| `position` | INTEGER | DEFAULT 0 | Kanban order |

---

## 4. Core Features

### 4.1 User Management & Authentication

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **Registration** | Email + password signup with validation | First Steps, Request Body |
| **Login** | OAuth2 Password Flow with Bearer tokens | Security - First Steps |
| **JWT Tokens** | Access + refresh token pair | OAuth2 with JWT |
| **Email Verification** | Send verification link via email | Background Tasks |
| **Password Reset** | Secure token-based reset flow | Security |
| **Profile Management** | Update avatar, name, preferences | Request Body, File Upload |
| **Account Deactivation** | Soft delete with data retention | Handling Errors |

### 4.2 Team & Project Management

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **Team Creation** | Create workspace with slug | Path Parameters |
| **Member Invites** | Email invites with role assignment | Dependencies |
| **Role-Based Access** | Owner/Admin/Member permissions | OAuth2 Scopes |
| **Project Boards** | Kanban/Scrum board per project | Query Parameters |
| **Project Templates** | Pre-configured project setups | Extra Models |
| **Archive/Restore** | Soft delete with recovery | Response Status Code |

### 4.3 Task Management

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **CRUD Operations** | Create, read, update, delete tasks | Request Body, Path Params |
| **Subtasks** | Nested task hierarchy | Body - Nested Models |
| **Task Dependencies** | Blocked-by, relates-to, duplicates | Dependencies |
| **Bulk Operations** | Update multiple tasks at once | Body - Multiple Parameters |
| **Task Search** | Full-text + filter + sort | Query Parameter Models |
| **Kanban Positioning** | Drag-and-drop ordering | Body - Updates |
| **Time Tracking** | Start/stop timers on tasks | Extra Data Types |
| **Due Date Reminders** | Automated reminder notifications | Background Tasks |

### 4.4 Collaboration Features

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **Comments** | Threaded discussions on tasks | Request Body |
| **@Mentions** | Notify users via @username | Background Tasks |
| **Reactions** | Emoji reactions to comments | Extra Models |
| **File Attachments** | Upload images, documents, code | Request Files |
| **Real-Time Updates** | Live task updates via WebSockets | WebSockets |
| **Activity Feed** | Stream of recent changes | Server-Sent Events |
| **Presence Indicators** | Who's online/viewing | WebSockets |

### 4.5 Notification System

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **In-App Notifications** | Notification inbox with read status | Response Model |
| **Email Notifications** | HTML/text emails for important events | Background Tasks |
| **Push Notifications** | Web Push for browser alerts | Background Tasks |
| **Notification Preferences** | Per-user, per-event type settings | Body - Fields |
| **Digest Mode** | Batch notifications into summaries | Background Tasks |
| **Quiet Hours** | Suppress notifications by schedule | Dependencies |

### 4.6 Audit & Compliance

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **Activity Log** | Immutable record of all actions | Middleware |
| **Data Export** | GDPR-compliant data export | Stream Data |
| **Audit Queries** | Filter and search audit records | Query Parameters |
| **IP Tracking** | Log request IP and user agent | Using Request Directly |
| **Data Retention** | Automatic cleanup of old data | Lifespan Events |

### 4.7 Integrations

| Feature | Description | FastAPI Topic |
|---------|-------------|---------------|
| **Webhooks** | Outbound HTTP callbacks for events | OpenAPI Webhooks |
| **Webhook Signatures** | HMAC-SHA256 verification | Security |
| **Retry Logic** | Exponential backoff for failed deliveries | Background Tasks |
| **SDK Generation** | Auto-generated client libraries | Generating SDKs |
| **API Keys** | Service-to-service authentication | APIKey Header |

---

## 5. API Specification

### 5.1 API Versioning

```
/api/v1/...     # Current stable version
/api/v2/...     # Future versions (backward incompatible changes)
```

### 5.2 Authentication

All protected endpoints require:
```
Authorization: Bearer <jwt_access_token>
```

### 5.3 Endpoint Groups

#### Authentication (/api/v1/auth)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `POST` | `/register` | Create new account | Public |
| `POST` | `/login` | Obtain access token | Public |
| `POST` | `/refresh` | Refresh access token | Refresh Token |
| `POST` | `/logout` | Revoke token | Required |
| `POST` | `/forgot-password` | Request reset link | Public |
| `POST` | `/reset-password` | Reset with token | Reset Token |
| `POST` | `/verify-email` | Verify email address | Verification Token |
| `GET` | `/me` | Current user profile | Required |
| `PATCH` | `/me` | Update profile | Required |
| `POST` | `/me/avatar` | Upload avatar | Required |

#### Users (/api/v1/users)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `GET` | `/` | List users (paginated) | Admin |
| `GET` | `/{user_id}` | Get user by ID | Required |
| `PATCH` | `/{user_id}` | Update user | Admin/Self |
| `DELETE` | `/{user_id}` | Deactivate user | Admin |
| `GET` | `/{user_id}/tasks` | Get user's tasks | Required |
| `GET` | `/{user_id}/activity` | Get user's activity | Required |

#### Teams (/api/v1/teams)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `POST` | `/` | Create team | Required |
| `GET` | `/` | List my teams | Required |
| `GET` | `/{team_id}` | Get team details | Team Member |
| `PATCH` | `/{team_id}` | Update team | Team Admin+ |
| `DELETE` | `/{team_id}` | Delete team | Team Owner |
| `GET` | `/{team_id}/members` | List members | Team Member |
| `POST` | `/{team_id}/members` | Invite member | Team Admin+ |
| `PATCH` | `/{team_id}/members/{user_id}` | Update role | Team Admin+ |
| `DELETE` | `/{team_id}/members/{user_id}` | Remove member | Team Admin+ |
| `GET` | `/{team_id}/projects` | List projects | Team Member |
| `GET` | `/{team_id}/tags` | List tags | Team Member |
| `GET` | `/{team_id}/webhooks` | List webhooks | Team Admin+ |
| `GET` | `/{team_id}/activity` | Team activity feed | Team Member |

#### Projects (/api/v1/projects)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `POST` | `/` | Create project | Team Member |
| `GET` | `/` | List projects (filterable) | Required |
| `GET` | `/{project_id}` | Get project | Project Member |
| `PATCH` | `/{project_id}` | Update project | Project Admin+ |
| `DELETE` | `/{project_id}` | Archive project | Project Admin+ |
| `POST` | `/{project_id}/restore` | Restore archived | Project Admin+ |
| `GET` | `/{project_id}/tasks` | List project tasks | Project Member |
| `GET` | `/{project_id}/members` | List project members | Project Member |
| `GET` | `/{project_id}/stats` | Project statistics | Project Member |
| `GET` | `/{project_id}/activity` | Project activity | Project Member |

#### Tasks (/api/v1/tasks)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `POST` | `/` | Create task | Project Member |
| `GET` | `/` | List tasks (search/filter) | Required |
| `GET` | `/{task_id}` | Get task details | Project Member |
| `PATCH` | `/{task_id}` | Update task | Project Member |
| `DELETE` | `/{task_id}` | Delete task | Project Member |
| `POST` | `/{task_id}/assign` | Assign to user | Project Member |
| `POST` | `/{task_id}/status` | Change status | Project Member |
| `POST` | `/{task_id}/move` | Move to project | Project Member |
| `GET` | `/{task_id}/comments` | List comments | Project Member |
| `POST` | `/{task_id}/comments` | Add comment | Project Member |
| `GET` | `/{task_id}/attachments` | List attachments | Project Member |
| `POST` | `/{task_id}/attachments` | Upload file | Project Member |
| `GET` | `/{task_id}/dependencies` | List dependencies | Project Member |
| `POST` | `/{task_id}/dependencies` | Add dependency | Project Member |
| `GET` | `/{task_id}/subtasks` | List subtasks | Project Member |
| `POST` | `/{task_id}/subtasks` | Create subtask | Project Member |
| `GET` | `/{task_id}/activity` | Task activity | Project Member |
| `POST` | `/{task_id}/watch` | Watch task | Project Member |
| `DELETE` | `/{task_id}/watch` | Unwatch task | Project Member |

#### Comments (/api/v1/comments)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `GET` | `/{comment_id}` | Get comment | Project Member |
| `PATCH` | `/{comment_id}` | Edit comment | Author/Admin |
| `DELETE` | `/{comment_id}` | Delete comment | Author/Admin |
| `POST` | `/{comment_id}/reply` | Reply to comment | Project Member |
| `POST` | `/{comment_id}/react` | Add reaction | Project Member |
| `DELETE` | `/{comment_id}/react` | Remove reaction | Self |

#### Attachments (/api/v1/attachments)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `GET` | `/{attachment_id}` | Get attachment info | Project Member |
| `GET` | `/{attachment_id}/download` | Download file | Project Member |
| `DELETE` | `/{attachment_id}` | Delete attachment | Uploader/Admin |

#### Notifications (/api/v1/notifications)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `GET` | `/` | List notifications | Required |
| `GET` | `/unread` | Unread count | Required |
| `PATCH` | `/{notification_id}` | Mark as read | Recipient |
| `POST` | `/read-all` | Mark all read | Required |
| `DELETE` | `/{notification_id}` | Dismiss | Recipient |
| `GET` | `/preferences` | Get preferences | Required |
| `PATCH` | `/preferences` | Update preferences | Required |

#### Webhooks (/api/v1/webhooks)

| Method | Endpoint | Description | Auth |
|--------|----------|-------------|------|
| `POST` | `/` | Create webhook | Team Admin+ |
| `GET` | `/` | List webhooks | Team Admin+ |
| `GET` | `/{webhook_id}` | Get webhook | Team Admin+ |
| `PATCH` | `/{webhook_id}` | Update webhook | Team Admin+ |
| `DELETE` | `/{webhook_id}` | Delete webhook | Team Admin+ |
| `POST` | `/{webhook_id}/test` | Test webhook | Team Admin+ |
| `GET` | `/{webhook_id}/deliveries` | Delivery history | Team Admin+ |
| `POST` | `/{webhook_id}/redeliver` | Redeliver failed | Team Admin+ |

#### Real-Time (/ws)

| Protocol | Endpoint | Description | Auth |
|----------|----------|-------------|------|
| WebSocket | `/ws/notifications` | Live notifications | JWT Token |
| WebSocket | `/ws/tasks/{task_id}` | Task live updates | JWT Token |
| WebSocket | `/ws/projects/{project_id}` | Project live feed | JWT Token |
| SSE | `/sse/activity` | Activity stream | JWT Token |

### 5.4 Query Parameters (Standard)

All list endpoints support:

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `page` | int | Page number | `?page=1` |
| `limit` | int | Items per page (max 100) | `?limit=20` |
| `sort` | string | Sort field | `?sort=-created_at` |
| `search` | string | Full-text search | `?search=urgent bug` |
| `fields` | string | Sparse fieldsets | `?fields=id,title,status` |

Task-specific filters:

| Parameter | Type | Description | Example |
|-----------|------|-------------|---------|
| `status` | enum | Filter by status | `?status=todo,in_progress` |
| `priority` | enum | Filter by priority | `?priority=high,urgent` |
| `assignee` | UUID | Filter by assignee | `?assignee=uuid` |
| `reporter` | UUID | Filter by reporter | `?reporter=uuid` |
| `due_before` | date | Due before date | `?due_before=2024-12-31` |
| `due_after` | date | Due after date | `?due_after=2024-01-01` |
| `tags` | string[] | Filter by tags | `?tags=bug,critical` |
| `project` | UUID | Filter by project | `?project=uuid` |
| `has_attachments` | bool | Has files attached | `?has_attachments=true` |

### 5.5 Response Format

**Success (200 OK):**
```json
{
  "data": { ... },
  "meta": {
    "request_id": "uuid",
    "timestamp": "2024-01-15T10:30:00Z"
  }
}
```

**List (200 OK):**
```json
{
  "data": [ ... ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "pages": 8,
    "has_next": true,
    "has_prev": false
  },
  "meta": { ... }
}
```

**Error (4xx/5xx):**
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Request validation failed",
    "details": [
      {
        "field": "email",
        "message": "Invalid email format"
      }
    ],
    "request_id": "uuid"
  }
}
```

---

## 6. Authentication & Security

### 6.1 OAuth2 + JWT Implementation

```
+-------------+     +-------------+     +-------------+
|   Client    |---->|   FastAPI   |---->|   PostgreSQL|
|             |     |   /login    |     |   (users)   |
+-------------+     +------+------+     +-------------+
                           |
                    +------+------+
                    |   Verify    |
                    |   Password  |
                    |   (bcrypt)  |
                    +------+------+
                           |
                    +------+------+
                    |  Generate   |
                    |  JWT Pair   |
                    |             |
                    | Access: 15m |
                    | Refresh: 7d |
                    +------+------+
                           |
+-------------+     +------+------+
|   Client    |<----|   Return    |
|  (stores    |     |   Tokens    |
|   tokens)   |     +-------------+
+-------------+
```

### 6.2 Token Structure

**Access Token Payload:**
```json
{
  "sub": "user-uuid",
  "email": "user@example.com",
  "role": "user",
  "scopes": ["task:read", "task:write", "comment:write"],
  "team_roles": {
    "team-uuid": "admin"
  },
  "iat": 1705312200,
  "exp": 1705313100,
  "jti": "unique-token-id"
}
```

### 6.3 Security Headers

| Header | Value | Purpose |
|--------|-------|---------|
| `X-Content-Type-Options` | `nosniff` | Prevent MIME sniffing |
| `X-Frame-Options` | `DENY` | Prevent clickjacking |
| `X-XSS-Protection` | `1; mode=block` | XSS filter |
| `Strict-Transport-Security` | `max-age=31536000` | Force HTTPS |
| `Content-Security-Policy` | `default-src 'self'` | CSP protection |
| `X-Request-ID` | `uuid` | Request tracing |

### 6.4 Rate Limiting

| Endpoint Type | Limit | Window |
|---------------|-------|--------|
| Authentication | 5 requests | 1 minute |
| API (authenticated) | 1000 requests | 1 minute |
| File uploads | 10 requests | 1 minute |
| WebSocket connections | 10 connections | IP |

---

## 7. Real-Time Features

### 7.1 WebSocket Events

**Task Channel (/ws/tasks/{task_id}):**
```json
// Client receives when task is updated
{
  "event": "task.updated",
  "data": {
    "task_id": "uuid",
    "changes": {
      "status": {"from": "todo", "to": "in_progress"},
      "assignee": {"from": null, "to": "user-uuid"}
    },
    "actor": {"id": "user-uuid", "name": "Alice"},
    "timestamp": "2024-01-15T10:30:00Z"
  }
}

// Client receives when comment is added
{
  "event": "comment.created",
  "data": {
    "comment_id": "uuid",
    "author": {"id": "user-uuid", "name": "Bob"},
    "content": "Working on this now",
    "timestamp": "2024-01-15T10:31:00Z"
  }
}
```

### 7.2 Presence System

```json
// Who's currently viewing the task
{
  "event": "presence.update",
  "data": {
    "task_id": "uuid",
    "viewers": [
      {"id": "user-1", "name": "Alice", "cursor": {"x": 120, "y": 340}},
      {"id": "user-2", "name": "Bob", "cursor": {"x": 200, "y": 150}}
    ]
  }
}
```

### 7.3 Server-Sent Events (SSE)

**Activity Feed Stream (/sse/activity):**
```
event: activity
data: {"type": "task.created", "task": {...}, "actor": {...}}

event: activity
data: {"type": "comment.added", "comment": {...}, "actor": {...}}
```

---

## 8. Background Processing

### 8.1 Celery Task Queue

| Task | Trigger | Priority | Retry |
|------|---------|----------|-------|
| `send_email` | Notification event | High | 3x exponential |
| `send_push` | Notification event | High | 3x exponential |
| `process_webhook` | Any create/update/delete | Medium | 5x exponential |
| `generate_thumbnail` | File upload | Low | 2x linear |
| `virus_scan` | File upload | High | 1x immediate |
| `cleanup_old_files` | Daily cron | Low | N/A |
| `export_project` | User request | Medium | 2x linear |
| `send_digest` | Daily cron | Low | N/A |

### 8.2 Email Templates

| Template | Trigger | Content |
|----------|---------|---------|
| `welcome` | Registration | Welcome message, verify email link |
| `verify_email` | Email change | Verification link |
| `password_reset` | Reset request | Secure reset link (1hr expiry) |
| `task_assigned` | Assignment | Task details, direct link |
| `task_due_soon` | Cron (24h before) | Due date warning |
| `mention` | @mention in comment | Comment context, reply link |
| `digest` | Daily cron | Summary of unread notifications |

---

## 9. Testing Strategy

### 9.1 Test Pyramid

```
                    +---------+
                    |  E2E    |  5%  (Playwright / API tests)
                    |  Tests  |      Full user journeys
                    +---------+
                    |Integration| 15% (pytest + TestClient)
                    |  Tests  |      DB + services together
                    +---------+
                    |  Unit   | 80%  (pytest + mocks)
                    |  Tests  |      Individual functions
                    +---------+
```

### 9.2 Test Categories

| Category | Coverage | Tools |
|----------|----------|-------|
| **Unit Tests** | Services, utilities, validators | pytest, pytest-asyncio |
| **Integration Tests** | API endpoints with real DB | TestClient, async DB |
| **WebSocket Tests** | Real-time features | TestClient WebSocket |
| **Security Tests** | Auth, permissions, injection | pytest, security scanners |
| **Performance Tests** | Load, stress, spike | locust, k6 |
| **Contract Tests** | OpenAPI spec compliance | schemathesis |

### 9.3 Test Fixtures

Key fixtures for testing:
- `db_session` - Isolated database session per test
- `client` - Test client with overridden dependencies
- `test_user` - Pre-created test user
- `auth_client` - Authenticated test client
- `test_team` - Pre-created test team with owner
- `test_project` - Pre-created test project
- `test_task` - Pre-created test task

---

## 10. Deployment

### 10.1 Docker Architecture

```dockerfile
# Multi-stage Dockerfile

# Stage 1: Builder
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Runtime
FROM python:3.12-slim
WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY ./app ./app
ENV PATH=/root/.local/bin:$PATH
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
CMD ["gunicorn", "-k", "uvicorn.workers.UvicornWorker", "-w", "4", "-b", "0.0.0.0:8000", "app.main:app"]
```

### 10.2 docker-compose.yml Services

| Service | Image | Purpose |
|---------|-------|---------|
| `api` | Custom build | FastAPI application |
| `db` | postgres:15-alpine | Primary database |
| `redis` | redis:7-alpine | Cache and message broker |
| `celery_worker` | Custom build | Background task workers |
| `celery_beat` | Custom build | Scheduled task scheduler |
| `minio` | minio/minio | S3-compatible file storage |

### 10.3 Production Checklist

| Item | Status | Notes |
|------|--------|-------|
| HTTPS/TLS | Required | Let's Encrypt or custom cert |
| Environment variables | Required | No secrets in code |
| Database migrations | Required | Alembic upgrade on deploy |
| Health checks | Required | `/health` endpoint |
| Log aggregation | Required | Structured JSON logs |
| Monitoring | Required | Prometheus + Grafana |
| Error tracking | Required | Sentry integration |
| Rate limiting | Required | Redis-based |
| CORS configuration | Required | Whitelist origins |
| Backup strategy | Required | Daily DB + file backups |
| CDN for static files | Recommended | CloudFront/Cloudflare |
| WAF | Recommended | AWS WAF / Cloudflare |

---

## 11. Project Structure

```
taskflow-api/
|
|-- app/
|   |-- __init__.py
|   |-- main.py                          # FastAPI app factory, lifespan events
|   |
|   |-- api/
|   |   |-- __init__.py
|   |   |-- deps.py                      # Dependencies (DB session, current_user)
|   |   |-- v1/
|   |   |   |-- __init__.py
|   |   |   |-- auth.py                  # OAuth2 login/register/refresh
|   |   |   |-- users.py                 # User CRUD, profile
|   |   |   |-- teams.py                 # Team management
|   |   |   |-- projects.py              # Project CRUD
|   |   |   |-- tasks.py                 # Task CRUD, search, filters
|   |   |   |-- comments.py              # Comments & reactions
|   |   |   |-- attachments.py           # File upload/download
|   |   |   |-- tags.py                  # Tag management
|   |   |   |-- notifications.py         # Notification inbox
|   |   |   |-- webhooks.py              # Webhook configuration
|   |   |   |-- activity.py              # Audit log queries
|   |   |   |-- ws.py                    # WebSocket endpoints
|   |
|   |-- core/
|   |   |-- __init__.py
|   |   |-- config.py                    # Pydantic Settings (env vars)
|   |   |-- security.py                  # JWT, password hashing, OAuth2
|   |   |-- exceptions.py                # Custom exception classes
|   |   |-- logging.py                   # structlog configuration
|   |   |-- celery.py                    # Celery app configuration
|   |   |-- events.py                    # Lifespan event handlers
|   |
|   |-- models/
|   |   |-- __init__.py
|   |   |-- base.py                      # SQLAlchemy declarative base
|   |   |-- user.py                      # User ORM model
|   |   |-- team.py                      # Team ORM model
|   |   |-- project.py                   # Project ORM model
|   |   |-- task.py                      # Task ORM model
|   |   |-- comment.py                   # Comment ORM model
|   |   |-- attachment.py                # Attachment ORM model
|   |   |-- tag.py                       # Tag ORM model
|   |   |-- notification.py              # Notification ORM model
|   |   |-- activity.py                  # Activity log ORM model
|   |   |-- webhook.py                   # Webhook ORM model
|   |
|   |-- schemas/
|   |   |-- __init__.py
|   |   |-- user.py                      # User Pydantic schemas
|   |   |-- team.py                      # Team Pydantic schemas
|   |   |-- project.py                   # Project Pydantic schemas
|   |   |-- task.py                      # Task Pydantic schemas
|   |   |-- comment.py                   # Comment Pydantic schemas
|   |   |-- attachment.py                # Attachment Pydantic schemas
|   |   |-- tag.py                       # Tag Pydantic schemas
|   |   |-- notification.py              # Notification Pydantic schemas
|   |   |-- activity.py                  # Activity Pydantic schemas
|   |   |-- webhook.py                   # Webhook Pydantic schemas
|   |   |-- token.py                     # JWT token schemas
|   |   |-- common.py                    # Pagination, response wrappers
|   |
|   |-- services/
|   |   |-- __init__.py
|   |   |-- auth_service.py              # Authentication logic
|   |   |-- user_service.py              # User business logic
|   |   |-- team_service.py              # Team business logic
|   |   |-- project_service.py           # Project business logic
|   |   |-- task_service.py              # Task business logic
|   |   |-- comment_service.py           # Comment business logic
|   |   |-- file_service.py              # File handling logic
|   |   |-- email_service.py             # Email sending logic
|   |   |-- notification_service.py      # Notification logic
|   |   |-- webhook_service.py           # Webhook delivery logic
|   |   |-- audit_service.py             # Audit logging logic
|   |
|   |-- db/
|   |   |-- __init__.py
|   |   |-- session.py                   # Async session + engine factory
|   |   |-- migrations/                  # Alembic migrations
|   |       |-- env.py
|   |       |-- script.py.mako
|   |       |-- versions/                # Migration files
|   |
|   |-- tasks/
|   |   |-- __init__.py
|   |   |-- email_tasks.py               # Celery email tasks
|   |   |-- webhook_tasks.py             # Celery webhook tasks
|   |   |-- file_tasks.py                # Celery file processing tasks
|   |   |-- cleanup_tasks.py             # Celery cleanup tasks
|   |
|   |-- middleware/
|   |   |-- __init__.py
|   |   |-- logging.py                   # Request logging middleware
|   |   |-- timing.py                    # Request timing middleware
|   |   |-- rate_limit.py                # Rate limiting middleware
|   |
|   |-- utils/
|   |   |-- __init__.py
|   |   |-- pagination.py                # Pagination utilities
|   |   |-- validators.py                # Custom validators
|   |   |-- helpers.py                   # General utilities
|   |
|   |-- tests/
|   |   |-- __init__.py
|   |   |-- conftest.py                  # pytest fixtures
|   |   |-- test_auth.py                 # Auth endpoint tests
|   |   |-- test_users.py                # User endpoint tests
|   |   |-- test_teams.py                # Team endpoint tests
|   |   |-- test_projects.py             # Project endpoint tests
|   |   |-- test_tasks.py                # Task endpoint tests
|   |   |-- test_comments.py             # Comment endpoint tests
|   |   |-- test_files.py                # File endpoint tests
|   |   |-- test_ws.py                   # WebSocket tests
|   |   |-- test_dependencies.py         # Dependency override tests
|
|-- uploads/                             # Local file storage (dev)
|
|-- scripts/
|   |-- init_db.py                       # Database initialization
|   |-- seed_data.py                     # Development seed data
|   |-- backup.sh                        # Backup script
|
|-- .env.example                         # Environment variable template
|-- .env                                 # Local environment (gitignored)
|-- .dockerignore
|-- .gitignore
|-- Dockerfile                           # Multi-stage build
|-- docker-compose.yml                   # Local development stack
|-- docker-compose.prod.yml              # Production stack
|-- requirements.txt                     # Python dependencies
|-- requirements-dev.txt                 # Dev dependencies
|-- pyproject.toml                       # Project metadata, tool config
|-- alembic.ini                          # Alembic configuration
|-- pytest.ini                           # pytest configuration
|-- Makefile                             # Common commands
|-- README.md                            # Project documentation
```

---

## 12. Environment Configuration

### 12.1 Required Environment Variables

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | PostgreSQL connection string | `postgresql+asyncpg://user:pass@localhost/taskflow` |
| `REDIS_URL` | Redis connection string | `redis://localhost:6379` |
| `SECRET_KEY` | JWT signing key (min 32 chars) | `super-secret-key-change-in-production` |
| `ALGORITHM` | JWT algorithm | `HS256` |
| `ACCESS_TOKEN_EXPIRE_MINUTES` | Access token TTL | `15` |
| `REFRESH_TOKEN_EXPIRE_DAYS` | Refresh token TTL | `7` |
| `CORS_ORIGINS` | Allowed frontend origins | `https://app.taskflow.io,http://localhost:3000` |
| `S3_ENDPOINT` | S3-compatible storage URL | `https://s3.amazonaws.com` |
| `S3_BUCKET` | File storage bucket | `taskflow-uploads` |
| `S3_ACCESS_KEY` | S3 access key | `AKIA...` |
| `S3_SECRET_KEY` | S3 secret key | `...` |
| `SMTP_HOST` | Email server host | `smtp.sendgrid.net` |
| `SMTP_PORT` | Email server port | `587` |
| `SMTP_USER` | Email username | `apikey` |
| `SMTP_PASSWORD` | Email password | `SG...` |
| `FROM_EMAIL` | Default sender address | `noreply@taskflow.io` |
| `SENTRY_DSN` | Error tracking URL | `https://...@sentry.io/...` |
| `LOG_LEVEL` | Logging verbosity | `INFO` |

### 12.2 Configuration Classes (Pydantic Settings)

```python
from pydantic_settings import BaseSettings
from pydantic import PostgresDsn, RedisDsn, EmailStr

class Settings(BaseSettings):
    # Database
    DATABASE_URL: PostgresDsn
    DATABASE_POOL_SIZE: int = 20
    DATABASE_MAX_OVERFLOW: int = 10

    # Redis
    REDIS_URL: RedisDsn

    # Security
    SECRET_KEY: str
    ALGORITHM: str = "HS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 15
    REFRESH_TOKEN_EXPIRE_DAYS: int = 7

    # CORS
    CORS_ORIGINS: list[str] = ["http://localhost:3000"]

    # Storage
    S3_ENDPOINT: str | None = None
    S3_BUCKET: str = "taskflow-uploads"
    S3_ACCESS_KEY: str | None = None
    S3_SECRET_KEY: str | None = None

    # Email
    SMTP_HOST: str = "localhost"
    SMTP_PORT: int = 587
    SMTP_USER: str | None = None
    SMTP_PASSWORD: str | None = None
    FROM_EMAIL: EmailStr = "noreply@taskflow.io"

    # Monitoring
    SENTRY_DSN: str | None = None
    LOG_LEVEL: str = "INFO"

    class Config:
        env_file = ".env"
        case_sensitive = True
```

---

## 13. Development Roadmap

### 13.1 10-Day Course Mapping

| Day | FastAPI Topics | Project Features Built |
|-----|---------------|----------------------|
| **Day 1** | Python Types, Async Basics, First Steps | App setup, health check, basic models |
| **Day 2** | Path Parameters, Query Parameters, Request Body | User CRUD, team creation, project setup |
| **Day 3** | Validation, Nested Models, Files | Task CRUD, comments, file uploads |
| **Day 4** | Extra Data Types, Cookies, Headers | Tags, filtering, sorting, search |
| **Day 5** | Dependencies, Sub-dependencies | Team membership, task dependencies, auth deps |
| **Day 6** | Security, OAuth2, JWT | Full auth system, role-based access, scopes |
| **Day 7** | Middleware, CORS, Background Tasks, SQL DB | Notifications, email, database integration |
| **Day 8** | WebSockets, SSE, Bigger Apps | Real-time updates, activity feeds, modular structure |
| **Day 9** | Testing, Debugging | Full test suite, dependency overrides, async tests |
| **Day 10** | Deployment, Docker, Cloud | Docker containers, production config, cloud deploy |

### 13.2 Post-Course Enhancements

| Phase | Features | Timeline |
|-------|----------|----------|
| **v1.1** | Advanced search (Elasticsearch), bulk imports | Week 2 |
| **v1.2** | Calendar integration (Google/Outlook), recurring tasks | Week 3 |
| **v1.3** | Time tracking reports, burndown charts | Week 4 |
| **v1.4** | Mobile push notifications, offline sync | Week 5 |
| **v2.0** | AI-powered task prioritization, smart assignments | Month 2 |

---

## Appendix A: OpenAPI Schema Highlights

### Security Schemes
```yaml
securitySchemes:
  OAuth2PasswordBearer:
    type: oauth2
    flows:
      password:
        tokenUrl: /api/v1/auth/login
        scopes:
          task:read: Read tasks
          task:write: Create and modify tasks
          admin: Full administrative access

  ApiKeyAuth:
    type: apiKey
    in: header
    name: X-API-Key
```

### Reusable Components
```yaml
schemas:
  User:
    type: object
    properties:
      id: { type: string, format: uuid }
      email: { type: string, format: email }
      username: { type: string, minLength: 3 }
      full_name: { type: string, nullable: true }
      role: { $ref: '#/components/schemas/UserRole' }
      is_active: { type: boolean }
      created_at: { type: string, format: date-time }

  Pagination:
    type: object
    properties:
      page: { type: integer }
      limit: { type: integer }
      total: { type: integer }
      pages: { type: integer }
      has_next: { type: boolean }
      has_prev: { type: boolean }
```

---

## Appendix B: Performance Targets

| Metric | Target | Measurement |
|--------|--------|-------------|
| API Response Time (p50) | < 50ms | New Relic / Prometheus |
| API Response Time (p99) | < 200ms | New Relic / Prometheus |
| Database Query Time | < 10ms | PostgreSQL logs |
| WebSocket Latency | < 100ms | Custom metrics |
| File Upload (10MB) | < 5s | Client-side timing |
| Concurrent Users | 10,000+ | Load testing |
| Uptime SLA | 99.9% | Monitoring dashboard |

---

*Document Version: 1.0*  
*Last Updated: 2024*  
*Built with FastAPI Documentation as the sole reference source*

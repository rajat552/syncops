# SyncOps — Real-Time Emergency Task Coordination Platform

[![Serverpod Version](https://img.shields.io/badge/Serverpod-4.0.2-blue.svg)](https://serverpod.dev)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.47+-02569B.svg?logo=flutter)](https://flutter.dev)
[![Dart Version](https://img.shields.io/badge/Dart-3.13+-0175C2.svg?logo=dart)](https://dart.dev)
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Embedded-336791.svg?logo=postgresql)](https://www.postgresql.org)

> **"No emergency task silently disappears when a responder goes offline."**

SyncOps is a state-of-the-art **Emergency Dispatch and Automated Recovery Platform** engineered for high-stakes field response operations. Built with Serverpod and Flutter, SyncOps eliminates the most dangerous failure mode in emergency management: **the silent abandonment gap**—when a field responder claims a critical mission but goes radio-silent due to equipment failure or danger.

---

## 📸 Platform Previews

### 1. Coordinator Dashboard — Emergency Operations Center
![Coordinator Dashboard](docs/images/coordinator_dashboard.png)
*The main command center: Real-time KPI metrics (Active Incidents, In Response, Needs Attention, Reassigned, Completed), live incident feed with severity badges, and a tactical GPS radar monitor for tracking responders in the field.*

---

### 2. Dispatch Emergency Incident
![Dispatch Incident](docs/images/dispatch_modal.png)
*Dispatchers can instantly load pre-set hackathon demo scenarios (Trauma Supply Delivery, Search & Rescue, Substation Cooling Failure) or create custom incidents with custom Severity and Timeout Window.*

---

### 3. Field Responder Terminal
![Responder Terminal](docs/images/responder_terminal.png)
*The field responder's one-touch interface — showing the live tactical radar, auto-recovery countdown timer, and live GPS telemetry stream. The responder can start their response, transmit GPS pings, and progress through the mission.*

---

### 4. Live Server Logs — Auto-Recovery in Action
![Server Logs](docs/images/server_logs.png)
*Real Serverpod server logs showing GPS pings arriving every 2-3 seconds, the `TaskTimeoutCall` Future Call firing, and the critical log line: **"Task #6 automatically recovered and reopened (Reassignment #1)."** — the heart of SyncOps.*

---

### 5. Synops App Runtime Logs
![App Logs](docs/images/synops_app_logs.png)
*The Serverpod development console showing the Flutter app successfully launched on the web server, with the Dart DevTools debugger and Flutter profiler available for deep inspection.*

---

## ⚡ Key Architectural Highlights

| Layer | Technology | Role |
|-------|-----------|------|
| **Frontend** | Flutter (Web/Mobile) | Coordinator Dashboard, Responder Terminal, Hero Demo |
| **RPC Transport** | Serverpod 4 typed endpoints | Type-safe client-server calls with auto-generated client |
| **Real-Time Events** | Serverpod WebSocket Streams | `task_updates`, `task_events_*`, `location_pings_*` channels |
| **Auto-Recovery Engine** | Serverpod `FutureCall` | Scheduled background timeout verification & re-queue |
| **Persistence** | PostgreSQL + Serverpod ORM | Immutable `task_event` audit trail, task state |
| **Concurrency Guard** | Atomic DB read-then-write | Prevents two responders claiming the same task |

### System Component Diagram

```mermaid
graph LR
    subgraph Flutter App
        C[Coordinator Dashboard]
        R[Responder Terminal]
        A[Audit Log Feed]
        DS[DemoControllerSheet\nHero Walkthrough]
        SVC[SyncOpsService\nChangeNotifier]
    end

    subgraph Serverpod Backend
        TE[TaskEndpoint\nFull CRUD + State Machine]
        LE[LocationEndpoint\nGPS Telemetry Streaming]
        TC[TaskTimeoutCall\nFutureCall Worker]
        MSG[Message Bus\nPub/Sub Channels]
        DB[(PostgreSQL\ntask + task_event)]
    end

    C & R & A --> SVC
    SVC -->|RPC| TE & LE
    TE --> DB
    TE --> MSG
    LE --> MSG
    TC --> DB
    TC --> MSG
    MSG -->|WS Stream| SVC
```

---

## 🔄 The SyncOps Auto-Recovery Workflow

### High-Level Flow

```mermaid
graph TD
    A[Coordinator Creates Critical Incident] -->|Broadcasts to Queue| B(Dispatch Queue)
    B -->|Responder A Claims Task| C{Responder En Route}
    C -->|Streams Live GPS| D[Live Radar Monitoring]
    C -.->|Loses Connection / Stops Responding| E(Countdown Timer Hits 0)
    
    E -->|Serverpod Future Call Executes| F[Idempotent Recovery Initiated]
    F -->|Strips Assignee & Logs Failure| G[Task Re-Opened]
    G -->|Broadcasts to Queue| B
    
    C -->|Completes Mission| H((Mission Completed Successfully))
```

### Detailed Sequence — Auto-Recovery in Action

```mermaid
sequenceDiagram
    participant C as Coordinator App
    participant B as Serverpod Backend
    participant DB as PostgreSQL
    participant FC as FutureCall Worker
    participant R1 as Responder A
    participant R2 as Responder B

    C->>B: createTask(severity=CRITICAL, timeout=45s)
    B->>DB: INSERT task (status=PENDING)
    B-->>C: Task broadcasted via task_updates stream

    R1->>B: acceptTask(taskId, responderId)
    B->>DB: UPDATE task (status=ACCEPTED, expiresAt=now+45s)
    B->>FC: scheduleTimeout("task-timeout-N", delay=45s)
    B-->>R1: Task accepted, countdown starts

    loop Every 3s
        R1->>B: sendLocationPing(lat, lng)
        B->>DB: UPDATE task.expiresAt = now+45s
        B->>FC: rescheduleTimeout (reset clock)
        B-->>C: location_pings_all broadcast
    end

    Note over R1,FC: Responder goes silent — no more pings
    FC->>B: handleTimeout(taskId) fires
    B->>DB: READ task — expiresAt passed, status=EN_ROUTE
    B->>DB: UPDATE task (status=PENDING, assignedTo=NULL, reassignmentCount++)
    B->>DB: INSERT task_event (type=TIMEOUT_AUTO_RECOVERED)
    B-->>C: Task re-broadcasted via task_updates
    B-->>R2: Task visible in dispatch queue

    R2->>B: acceptTask(taskId, responderId=202)
    R2->>B: updateStatus → EN_ROUTE → ARRIVED → IN_PROGRESS → COMPLETED
    B->>DB: UPDATE task (status=COMPLETED, completedAt=now)
    B->>FC: cancelTimeout("task-timeout-N")
```

---

## 🚀 Running the Project Locally

### Prerequisites
- [Flutter SDK](https://flutter.dev) (v3.44+)
- [Dart SDK](https://dart.dev) (v3.12+)
- [Serverpod CLI](https://serverpod.dev) (v4.0.2): `dart pub global activate serverpod_cli 4.0.2`

### 1. Launch the Stack
Run from the workspace root:
```bash
serverpod start
```
- Bootstraps the embedded PostgreSQL database on port `8090`.
- API server listens on `http://localhost:8085`.
- Automatically watches file changes, runs code generation, and hot-reloads the Flutter client.

### 2. View the App
The Flutter web app launches automatically in the browser. If it doesn't, check your terminal for the local port (e.g., `http://localhost:56507`).

### 3. Run the Automated Tests

**Backend Integration Tests (Serverpod + Embedded PostgreSQL)**:
```bash
cd synops_server
dart test
```

**Frontend Widget Tests**:
```bash
cd synops_flutter
flutter test
```

---

## 📜 License
Developed for the Serverpod Hackathon. Licensed under the Apache License, Version 2.0.

BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "latitude" double precision NOT NULL,
    "longitude" double precision NOT NULL,
    "severity" text NOT NULL,
    "status" text NOT NULL,
    "createdById" bigint NOT NULL,
    "assignedToId" bigint,
    "assignedResponderName" text,
    "createdAt" timestamp without time zone NOT NULL,
    "acceptedAt" timestamp without time zone,
    "startedAt" timestamp without time zone,
    "arrivedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "expiresAt" timestamp without time zone,
    "lastActivityAt" timestamp without time zone,
    "reassignmentCount" bigint NOT NULL DEFAULT 0,
    "requiredSkill" text
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "task_event" (
    "id" bigserial PRIMARY KEY,
    "taskId" bigint NOT NULL,
    "actorId" bigint,
    "actorName" text,
    "type" text NOT NULL,
    "message" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "metadata" text
);


--
-- MIGRATION VERSION FOR synops
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('synops', '20260925114725125', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260925114725125', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260824182259319', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182259319', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260910193913364-string-rate-limit-keys', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260910193913364-string-rate-limit-keys', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260824182354731', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260824182354731', "timestamp" = now();


COMMIT;

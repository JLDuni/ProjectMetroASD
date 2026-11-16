# Design - M2 Initial Automated Tests

## Traceability

- Requirements: TST-01 through TST-05
- Project requirements: NFR8, TEST
- Related health requirement: NFR7
- Google Sheet task ID: 4

## Design Summary

Extract Gin router construction from process startup so the current HTTP behavior can be tested in memory. Add standard-library Go tests for the two existing JSON endpoints and run them in a dedicated CI job before Docker artifact creation. Keep the current container checks as the integration/smoke layer.

No React component test framework is introduced for M2.

## Backend Structure

The current `main` function both constructs the router and starts the process. Refactor it into two responsibilities:

```go
func newRouter() *gin.Engine {
    // Configure current routes and static-file behavior.
    return router
}

func main() {
    router := newRouter()
    // Resolve the existing PORT behavior and start the process.
}
```

Design constraints:

- `newRouter` remains inside package `main`; it does not need to be exported.
- Existing endpoint paths, response codes, JSON bodies, static routes, and port behavior remain unchanged.
- The refactor does not introduce dependency injection, a framework, or a new service.
- Ignoring or changing unrelated startup error handling is outside this task.

## Unit Test Design

Create `backend/main_test.go` in package `main`.

Each endpoint test:

1. enables Gin test mode;
2. creates the router with `newRouter()`;
3. creates a request with `net/http/httptest`;
4. records the response without opening a port;
5. verifies the HTTP status;
6. decodes or compares the expected JSON using only the Go standard library.

### Health test

For `GET /health`, assert:

- HTTP 200;
- JSON contains `status: "ok"`.

This protects the NFR7 health contract used by Docker and CI.

### Hello test

For `GET /api/hello`, assert:

- HTTP 200;
- JSON contains the current MetroIsJustABus hello message.

This is a temporary M2 contract because the current smoke check already depends on the endpoint. A future approved feature may remove or replace it together with its test.

### Frontend fallback

The `NoRoute` static frontend fallback is not unit-tested in this spec because the built `static/index.html` artifact is not present during ordinary Go unit tests. It remains covered by the container smoke check after the React build is copied into the runtime image.

## CI Test Job

Add a dedicated `tests` job to the existing workflow:

- checkout source;
- configure Go 1.23 with `actions/setup-go`;
- execute `go test ./...` with `working-directory: backend`.

The workflow triggers are shared with spec 001:

- pull requests targeting `develop`;
- pushes to `develop`;
- pushes to `main`.

The existing `build-and-verify` job depends on both `quality` and `tests`.

## Integration And Smoke Layer

Retain the existing Docker validation:

- build the production image;
- start the container on port 5000;
- wait for `/health`;
- verify `/health`;
- verify `/api/hello`;
- verify that `/` returns the built frontend document;
- inspect logs and stop the container.

Implementation should ensure cleanup occurs even when a smoke assertion fails, without weakening the failure signal.

## Local Developer Commands

```bash
cd backend
go test ./...
```

The test suite must not require Docker, a database, RabbitMQ, another service, or an external network.

## Files Expected To Change

- `backend/main.go`
- `backend/main_test.go`
- `.github/workflows/ci-docker.yml`
- an existing documentation or evidence file, if needed

## Validation

1. Run `go test ./...` locally from `backend/`.
2. Temporarily make one assertion fail, confirm a non-zero exit status, and revert the temporary change before commit.
3. Run the combined quality, test, Docker build, and smoke sequence.
4. Confirm existing endpoint responses are unchanged.
5. Confirm CI does not start `build-and-verify` when `tests` fails.
6. Record the CI URL, commit SHA, defects, corrections, and human review in the AI evidence.

## Risks

- Router refactoring may accidentally change static-file behavior: preserve the current registration order and verify it through the container smoke test.
- Recreating the router in each test may repeat Gin debug output: enable test mode before router creation.
- Both specs edit the same workflow: implement them sequentially or as coordinated changes after both reach `tasks:approved`.

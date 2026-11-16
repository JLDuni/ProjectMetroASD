# Requirements - M2 Initial Automated Tests

## Traceability

- Google Sheet task ID: 4
- Project requirements: NFR8, TEST
- Milestone: M2.1 (CI & Tests)

## Functional Requirements

### TST-01 - Testable router construction

The Go application shall expose router construction in a form that can be exercised by automated tests without opening a network port.

**Acceptance criteria**

- Tests can instantiate the Gin router directly.
- Production startup continues to listen on the configured port.
- Existing public endpoint paths and responses do not change.

### TST-02 - Health endpoint unit test

The backend test suite shall verify the current `GET /health` contract required by NFR7 and the CI smoke check.

**Acceptance criteria**

- The test verifies HTTP status 200.
- The test verifies the expected JSON health status.
- The test does not require a running external service.

### TST-03 - Hello endpoint unit test

The backend test suite shall verify the current `GET /api/hello` behavior.

**Acceptance criteria**

- The test verifies HTTP status 200.
- The test verifies the expected JSON message.
- The test does not require a running external service.

### TST-04 - Blocking CI test execution

The CI pipeline shall execute `go test ./...` for every pull request targeting `develop` and for every push to `develop` or `main`, before producing the Docker artifact.

**Acceptance criteria**

- The workflow is triggered by pull requests targeting `develop`.
- The workflow is triggered by pushes to `develop` and `main`.
- All backend packages are included.
- A failing unit test stops the pipeline.
- Test output is visible in the CI run.
- The `develop` branch can be protected by requiring the mandatory test check before merge.

### TST-05 - Initial integration/smoke validation

The existing container validation shall remain as the initial integration/smoke test layer.

**Acceptance criteria**

- CI starts the built container.
- CI verifies `/health`, `/api/hello`, and the served frontend.
- A failed container or endpoint check fails the pipeline.

## Non-functional Constraints

- Use Go's standard `testing` and `net/http/httptest` packages; do not add a backend test framework.
- Limit production refactoring to what is required to test router behavior.
- Do not introduce tests for future services or endpoints that do not exist.
- React component tests are outside the mandatory M2 scope unless the human reopens the approved plan.
- Tests shall be deterministic and shall not depend on external network services.

## Evidence Requirements

- Retain the CI run URL and commit SHA.
- Record local and CI test results in the AI usage evidence.
- Distinguish unit tests from container integration/smoke checks in documentation.
- Record defects, failed attempts, human corrections, and rework.

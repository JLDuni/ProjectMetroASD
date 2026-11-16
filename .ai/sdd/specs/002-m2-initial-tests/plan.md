# Plan - M2 Initial Automated Tests

## Objective

Establish the smallest reliable automated test baseline that satisfies NFR8 and the Milestone 2 unit/integration testing requirement for the current application.

## Proposed Decisions

1. Start with Go unit tests for the current HTTP behavior because the backend already exposes stable routes.
2. Extract router construction into a testable function without changing endpoint behavior.
3. Use Go's standard `testing` and `net/http/httptest` packages; add no backend test framework.
4. Keep the current Docker container checks as initial integration/smoke validation.
5. Defer React component testing until WebApp feature work unless the team explicitly requires it for Milestone 2.
6. Run unit tests before Docker artifact creation so failures block the pipeline.

## Initial Test Scope

- `GET /health` returns HTTP 200 and the expected JSON status.
- `GET /api/hello` returns HTTP 200 and the expected JSON message.
- An unknown API route follows the currently defined fallback behavior.
- The built container starts and responds on the expected endpoints.
- The React production build is served by the container.

## Work Sequence

1. Define the expected response contract for the existing routes.
2. Refactor only router construction to make it directly testable.
3. Add table-driven Go tests where that improves clarity.
4. Run the complete backend test suite locally.
5. Integrate `go test ./...` into GitHub Actions before the Docker build.
6. Preserve and clearly label the existing container checks as integration/smoke tests.
7. Record test commands, results, defects, rework, and pipeline evidence in the AI log.

## Validation Plan

- All tests pass locally from a clean checkout.
- A controlled assertion failure causes a non-zero test command without being committed.
- CI stops before image creation when unit tests fail.
- The existing container smoke checks still pass after the router refactor.
- No public endpoint behavior changes.

## Evidence To Retain

- CI run URL and commit SHA.
- Test command output or machine-readable report if later configured.
- Mapping from each test to NFR8 and the Milestone 2 test requirement.
- AI log entry containing autonomy, human minutes, errors, validation, and rework.

## Risks And Mitigations

- **Over-refactoring:** restrict changes to router construction needed for testing.
- **Misclassified tests:** document unit tests separately from container integration/smoke checks.
- **CI conflict:** implement after or coordinate with the code-quality workflow change.
- **False coverage target:** prioritize meaningful current behavior over an arbitrary percentage.

## Exit Criteria

The plan is complete when the current backend behavior has automated unit coverage, the container behavior remains integration-tested, and both test layers run as blocking CI checks.

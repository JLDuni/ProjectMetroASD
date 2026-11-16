# Tasks - M2 Initial Automated Tests

## Implementation Order

Start this spec only after spec 001 has been merged into `develop`. Create the implementation branch from the updated `develop` branch so the test job can extend the workflow without conflicting with the quality job.

Human-approved exception (2026-11-15): implementation may start from spec 001 commit `a2469b2` while PR #4 awaits review. Before opening the spec 002 pull request, synchronize this branch with the final merged `develop` state.

Synchronization completed (2026-11-16): after PR #4 was merged, `feature/M3-initial-tests` was fast-forwarded to `origin/develop` at `e130fdb`. The branch is now based on the final merged spec 001 state.

## Task Checklist

- [x] **T1 - Extract testable router construction** (TST-01)
  - Refactor `backend/main.go` to create the current Gin router through `newRouter()`.
  - Keep process startup and existing `PORT` behavior in `main()`.
  - Preserve route registration order, paths, JSON responses, static assets, and frontend fallback.
  - Validation: the backend still builds and the current container smoke checks remain valid.

- [x] **T2 - Add backend endpoint unit tests** (TST-02, TST-03, NFR7)
  - Create `backend/main_test.go` in package `main`.
  - Enable Gin test mode before router creation.
  - Test HTTP 200 and the JSON body for `GET /health`.
  - Test HTTP 200 and the current JSON body for `GET /api/hello`.
  - Use only `testing`, `net/http/httptest`, and other Go standard-library packages.
  - Validation: `go test ./...` passes from `backend/` without Docker or external services.

- [x] **T3 - Add the blocking CI test job** (TST-04, NFR8)
  - Add a stable job named `tests` to `.github/workflows/ci-docker.yml`.
  - Configure Go 1.23 without a major-version change.
  - Run `go test ./...` with `backend/` as the working directory.
  - Extend `build-and-verify` to depend on both `quality` and `tests`.
  - Retain the triggers approved and implemented by spec 001.
  - Validation: a test failure prevents `build-and-verify`; passing tests allow Docker build.

- [x] **T4 - Preserve and verify container smoke coverage** (TST-05)
  - Retain checks for `/health`, `/api/hello`, and the served frontend document.
  - Preserve the failure signal when a container or endpoint check fails.
  - Ensure the smoke container is stopped after the validation sequence.
  - Validation: build the image, start the container, verify all three targets, and inspect its logs.

- [x] **T5 - Validate failure and success paths** (TST-01 through TST-05, NFR8)
  - Run `go test ./...` locally.
  - Temporarily make one assertion fail and confirm a non-zero exit status.
  - Revert the temporary failure before staging any files.
  - Run the combined quality, test, Docker build, and smoke sequence.
  - Confirm public endpoint responses are unchanged.

- [ ] **T6 - Record evidence and prepare human review** (NFR8)
  - Update the structured AI log with test results, failures, corrections, autonomy, and human time.
  - Update the Google Sheet summary without storing verbatim prompts.
  - Link the eventual issue, commit SHA, CI run, and PR.
  - Distinguish unit tests from integration/smoke tests in the evidence.
  - Show the final diff and validation results to the human.
  - Do not commit or push until explicitly authorized.

## Local Validation Evidence (2026-11-15)

- `gofmt -l .`: passed with no unformatted backend files.
- `go vet ./...`: passed in `golang:1.23-alpine`.
- `go test -v ./...`: passed; `TestHealthEndpoint` and `TestHelloEndpoint` both passed.
- Controlled failure: a temporary incorrect hello-message expectation caused `go test ./...` to fail with a non-zero exit status; the expectation was then restored.
- Recovery validation: `go test ./...` passed after restoring the correct expectation.
- Docker image `metro-task4:test`: built successfully.
- Container smoke checks: `/health`, `/api/hello`, and `/` all returned successful responses.
- Observed public JSON remained unchanged: `{"status":"ok"}` and `{"message":"Hello from MetroIsJustABus backend"}`.
- The smoke container was removed by the cleanup trap after validation.
- Google Sheet `Guia & Registo de IA!A15:K15` was updated as `LOG-011` with confirmed metrics of 75% autonomy and 25 human minutes; no verbatim prompts were stored.
- Branch synchronization: `feature/M3-initial-tests` matches `origin/develop` at `e130fdb` before the Task 4 commit is created.
- CI evidence, commit SHA, and pull request remain pending; T6 and the spec status stay open until those results exist.

## Completion Criteria

- Every checklist item is complete.
- Unit and smoke tests pass locally and in CI.
- The pipeline blocks Docker artifact creation when `tests` fails.
- Evidence is recorded and reviewed.
- The spec may then move to `implementation:done`; it must not move to `review:done` until an independent review confirms the result.

# M2 Initial Automated Tests

## Source

- Google Sheet task ID: 4
- Milestone: M2.1 (CI & Tests)
- Requirements: NFR8, TEST
- Owner: Rafa
- Priority: High

## Problem

The repository currently has Docker smoke checks but no committed unit-test suite. The project statement and NFR8 require automated tests in the CI pipeline, including initial unit and integration coverage for Milestone 2.

## Intended Outcome

Introduce a small, reliable automated test baseline for the current Go/Gin and React/Vite application, then execute it in CI before artifact creation and deployment.

## Candidate Scope

- Unit tests for the current Go HTTP behavior.
- A testable Gin router without changing public endpoint behavior.
- CI execution of the Go test suite.
- Preservation and classification of the existing container smoke checks as initial integration validation.
- Frontend unit testing only if it is justified by the approved plan and available milestone time.

## Non-goals

- Full coverage of future business functionality.
- End-to-end coverage of services that do not yet exist.
- Introducing a new language, framework, database, broker, or application service.
- Unrelated refactoring.

## Open Questions For Planning

- What minimum behaviors must be covered for the Milestone 2 demonstration?
- Should frontend component tests be included now or deferred until the WebApp feature work begins?
- What test result or coverage evidence must be retained?
- Which checks are unit, integration, and smoke tests in the final report taxonomy?

## Dependencies

- Existing `/health` and `/api/hello` endpoints.
- Existing Docker smoke-test workflow.
- The code-quality spec may update the same CI workflow, so implementation order must avoid conflicting edits.
- Human approval of the SDD plan, requirements, design, and tasks before implementation.

# M2 Code Quality Gates

## Source

- Google Sheet task ID: 3
- Milestone: M2.1 (CI & Tests)
- Requirement: NFR8
- Owner: Rafa
- Priority: High

## Problem

The current CI workflow builds and smoke-tests the Docker image, but it does not run explicit static code-quality checks. NFR8 requires every repository change to be automatically built, tested, and analyzed with code-quality tools.

## Intended Outcome

Add reproducible quality gates for the existing Go/Gin backend and React/Vite frontend. The pipeline must fail when a mandatory check fails and must expose enough output to serve as Milestone 2 evidence.

## Candidate Scope

- Go formatting verification.
- Go static analysis.
- Frontend linting.
- CI integration before the deployable artifact is produced.
- Documented validation evidence for both successful and failing checks.

## Non-goals

- Changing the application architecture or stack.
- Adding production functionality.
- Making SonarQube/SonarCloud mandatory before the basic quality gates work.
- Unrelated refactoring.

## Open Questions For Planning

- Which Go analyzer should complement the standard toolchain, if any?
- Is ESLint sufficient for the frontend gate in M2?
- Should SonarQube/SonarCloud be part of M2 or deferred to the final delivery?
- What exact failure thresholds should block the pipeline?

## Dependencies

- Existing GitHub Actions workflow.
- Existing Go and Node versions defined by the project.
- Human approval of the SDD plan, requirements, design, and tasks before implementation.

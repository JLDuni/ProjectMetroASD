# Plan - M2 Code Quality Gates

## Objective

Satisfy the code-quality portion of NFR8 with fast, deterministic checks that run automatically before a deployable artifact is produced.

## Proposed Decisions

1. Use the standard Go toolchain first: formatting verification and `go vet ./...`.
2. Add ESLint for the React/Vite frontend because no frontend linter currently exists.
3. Defer SonarQube/SonarCloud until the basic gates are stable. It is not required for the minimum Milestone 2 acceptance criteria.
4. Treat every configured check as blocking: a failure stops the CI job.
5. Keep the existing stack and major runtime versions unchanged.

## Work Sequence

1. Confirm the exact Go and Node versions used locally, in the Dockerfile, and in CI.
2. Define local commands for backend and frontend quality checks.
3. Add only the minimum frontend development dependencies required for ESLint.
4. Add scripts that developers can run locally before pushing.
5. Integrate the checks into GitHub Actions before Docker artifact creation.
6. Verify one successful run and one controlled failing example without committing the intentional failure.
7. Record the commands, result, human review, and pipeline evidence in the AI log.

## Validation Plan

- The Go formatting check reports no unformatted files.
- `go vet ./...` succeeds.
- The frontend lint command succeeds.
- A known lint violation makes the relevant local command fail.
- CI does not proceed to artifact creation when a mandatory quality check fails.
- Existing Docker build and smoke checks continue to work.

## Evidence To Retain

- CI run URL and commit SHA.
- Commands executed locally.
- Summary of any AI-generated configuration and human corrections.
- The relevant NFR8 trace in the PR description.

## Risks And Mitigations

- **Dependency churn:** pin compatible development dependencies and avoid Node major upgrades.
- **Slow pipeline:** use lightweight native checks before introducing Sonar.
- **Workflow conflict:** coordinate with the initial-tests spec because both may edit the same CI file.
- **False confidence:** passing linters does not replace automated tests.

## Exit Criteria

The plan is complete when the approved quality commands run locally and in CI, failures block the pipeline, and evidence is linked to the corresponding task and requirement.

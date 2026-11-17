# Requirements - M2 Code Quality Gates

## Traceability

- Google Sheet task ID: 3
- Project requirement: NFR8
- Milestone: M2.1 (CI & Tests)

## Functional Requirements

### QG-01 - Go formatting gate

The project shall provide a repeatable check that fails when committed Go source files are not formatted according to the standard Go formatter.

**Acceptance criteria**

- The check can be executed locally from the repository.
- A correctly formatted codebase returns a successful exit status.
- A deliberately unformatted temporary example returns a failing exit status.
- The check does not modify source files while running in CI.

### QG-02 - Go static-analysis gate

The project shall run `go vet ./...` against the backend as a mandatory NFR8 quality check.

**Acceptance criteria**

- The command analyzes every backend package.
- A reported vet error fails the quality job.
- The command runs before Docker artifact creation.

### QG-03 - Frontend lint gate

The project shall provide an ESLint command for the React/Vite frontend.

**Acceptance criteria**

- The command can be executed through an npm script.
- It analyzes the maintained frontend source files.
- A configured lint error produces a non-zero exit status.
- Any new development dependency is justified in the PR.

### QG-04 - Blocking CI integration

The NFR8 quality checks shall execute automatically for every pull request targeting `develop` and for every push to `develop` or `main`.

**Acceptance criteria**

- The workflow is triggered by pull requests targeting `develop`.
- The workflow is triggered by pushes to `develop` and `main`.
- Formatting, Go static analysis, and frontend linting are visible as pipeline steps.
- A failure in any mandatory check prevents artifact creation or deployment.
- Existing Docker build and smoke validation continue to run after the gates pass.
- The `develop` branch can be protected by requiring the mandatory CI checks before merge.

### QG-05 - Developer reproducibility

The same mandatory quality checks used by CI shall be runnable by a developer without relying on CI-only behavior.

**Acceptance criteria**

- The required commands are documented or exposed through existing project tooling.
- Local and CI commands use compatible Go and Node major versions.

## Non-functional Constraints

- The implementation shall not change the approved Go, Node, React, Vite, or Gin major versions.
- The implementation shall not introduce a new framework, language, database, broker, ORM, or service.
- SonarQube/SonarCloud is outside the mandatory M2 scope unless the human reopens the approved plan.
- The quality-gate work shall not change application behavior.

## Evidence Requirements

- Retain the CI run URL and commit SHA.
- Record the commands and validation results in the AI usage evidence.
- Record AI errors, human corrections, and rework rather than only the successful result.

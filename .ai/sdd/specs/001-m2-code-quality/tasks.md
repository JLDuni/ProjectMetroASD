# Tasks - M2 Code Quality Gates

## Implementation Order

Implement this spec before spec 002. Both specs modify the same workflow, so spec 002 must start from the updated `develop` branch after this work is merged.

## Task Checklist

- [x] **Q1 - Configure frontend linting** (QG-03, QG-05)
  - Add ESLint development dependencies compatible with Node 20, React 18, and Vite 5.
  - Add `frontend/eslint.config.js`.
  - Add `npm run lint` to `frontend/package.json`.
  - Regenerate and retain the npm lockfile.
  - Exclude generated output such as `dist/`.
  - Validation: `npm ci`, `npm run lint`, and `npm run build` succeed from `frontend/`.

- [x] **Q2 - Add CI triggers for the approved Git flow** (QG-04)
  - Update `.github/workflows/ci-docker.yml`.
  - Trigger on pull requests targeting `develop`.
  - Trigger on pushes to `develop` and `main`.
  - Preserve the current GHCR publishing condition for approved release behavior unless a separate task changes it.
  - Validation: inspect the workflow definition and confirm the three approved trigger cases.

- [x] **Q3 - Add the blocking quality job** (QG-01, QG-02, QG-03, QG-04)
  - Add a stable job named `quality`.
  - Configure Go 1.23 and Node 20 without major-version changes.
  - Run the read-only Go formatting check in `backend/`.
  - Run `go vet ./...` in `backend/`.
  - Run `npm ci` and `npm run lint` in `frontend/`.
  - Make `build-and-verify` depend on `quality`.
  - Validation: a quality failure prevents `build-and-verify`; a clean run reaches Docker build.

- [x] **Q4 - Validate local failure and success paths** (QG-01 through QG-05, NFR8)
  - Run the complete local quality command set.
  - Temporarily create one formatting or lint violation and confirm the relevant command fails.
  - Revert the temporary violation before staging any files.
  - Re-run all checks and confirm success.
  - Validation: `git diff --check`, Go formatting check, `go vet ./...`, `npm run lint`, and `npm run build` all pass.

- [x] **Q5 - Record evidence and prepare human review** (NFR8)
  - Update the structured AI log with commands, failures, corrections, autonomy, and human time.
  - Update the Google Sheet summary without storing verbatim prompts.
  - Link the eventual issue, commit SHA, CI run, and PR.
  - Show the final diff and validation results to the human.
  - Do not commit or push until explicitly authorized.

## Completion Criteria

- Every checklist item is complete.
- The mandatory quality checks pass locally and in CI.
- The pipeline blocks Docker artifact creation when `quality` fails.
- Evidence is recorded and reviewed.
- The spec may then move to `implementation:done`; it must not move to `review:done` until an independent review confirms the result.

# Design - M2 Code Quality Gates

## Traceability

- Requirements: QG-01 through QG-05
- Project requirement: NFR8
- Google Sheet task ID: 3

## Design Summary

Extend the existing GitHub Actions workflow with a dedicated, visible quality job. The job runs lightweight backend and frontend checks before Docker artifact creation. The existing Docker build and smoke validation remain intact and depend on the quality and test jobs succeeding.

SonarQube and SonarQube Cloud are intentionally excluded from this M2 design. The team may add either in a later approved spec revision.

## CI Trigger Design

The existing workflow trigger will be changed to:

```yaml
on:
  push:
    branches: [develop, main]
  pull_request:
    branches: [develop]
```

This matches the documented Git flow:

- feature branches are validated through pull requests targeting `develop`;
- pushes to `develop` validate the integrated development version;
- pushes to `main` validate the release/production version.

The workflow job names must remain stable after branch protection is configured because GitHub required checks refer to those names.

## Job Structure

```text
quality ───────┐
               ├──> build-and-verify
tests ─────────┘
```

- `quality` belongs to this spec.
- `tests` belongs to spec 002.
- `build-and-verify` retains Docker build and container smoke validation.
- `build-and-verify` uses `needs: [quality, tests]`, so mandatory failures block artifact creation.

## Backend Quality Design

### Go environment

- Use `actions/setup-go` with the existing Go 1.23 major/minor declared by the project.
- Execute Go commands with `working-directory: backend`.
- Do not change the module path or Go major version.

### Formatting check

CI performs a read-only formatting check:

```bash
test -z "$(gofmt -l .)"
```

If `gofmt -l` returns any maintained Go file, the shell expression fails. Developers may fix files locally with `gofmt -w .`, but CI never rewrites source code.

### Static analysis

CI executes:

```bash
go vet ./...
```

The command analyzes every package in the backend Go module and returns a non-zero exit status when a mandatory issue is reported.

## Frontend Quality Design

### ESLint configuration

Add an ESLint flat configuration compatible with the existing React 18, Vite 5, and Node 20 setup. The configuration covers maintained JavaScript and JSX source files while excluding generated output such as `dist/`.

Expected development dependencies:

- `eslint`;
- `@eslint/js`;
- `globals`;
- `eslint-plugin-react-hooks`;
- `eslint-plugin-react-refresh`.

These dependencies provide linting only and do not change production runtime behavior. Their addition must be justified in the PR as required by the project rules.

### npm command

Add the following script to `frontend/package.json`:

```json
"lint": "eslint ."
```

CI uses `npm ci` and then `npm run lint` from `frontend/`. The lockfile is committed so local and CI dependency resolution is reproducible.

## Local Developer Commands

```bash
cd backend
test -z "$(gofmt -l .)"
go vet ./...

cd ../frontend
npm ci
npm run lint
```

The implementation may document these commands in an existing project document. It shall not create a new top-level directory.

## Branch Protection

After the updated workflow has completed at least once, a repository administrator can protect `develop` by requiring:

- the `quality` job;
- the `tests` job from spec 002;
- at least one human review, as already required by the Git guidelines.

Branch protection is a GitHub repository setting, not a source-code change.

## Files Expected To Change

- `.github/workflows/ci-docker.yml`
- `frontend/package.json`
- `frontend/package-lock.json`
- `frontend/eslint.config.js`
- an existing documentation or evidence file, if needed

## Validation

1. Run all quality commands locally.
2. Confirm a clean checkout passes.
3. Temporarily introduce a formatting or lint violation, confirm the relevant local command fails, and revert the temporary change before commit.
4. Confirm a CI failure prevents `build-and-verify` from running.
5. Confirm a successful run reaches Docker build and smoke validation.
6. Record the CI URL, commit SHA, errors, corrections, and human review in the AI evidence.

## Risks

- ESLint version incompatibility: use versions compatible with Node 20 and the current Vite/React setup.
- Job-name changes can invalidate required checks: choose stable names before configuring branch protection.
- Both specs edit the same workflow: implement them sequentially or in coordinated commits to avoid conflicts.

# TaskFlow Pro

Collaborative task system. Full context in @.ai/steering/product.md

## Stack
Summary in @.ai/steering/tech-stack.md — read before technical decisions.

## Development flow
This project uses Spec-Driven Development.
1. Every feature has a spec in `.ai/sdd/specs/NNN-name/`
2. Read the feature's `.status` BEFORE implementing anything
3. Never write code before `tasks:approved`
4. Ambiguity during implementation: STOP and ask

## Rules that apply every session
- NEVER expose one workspace's data to another
- ALWAYS validate permissions on the server

## File Description

-- podemos tirar penso 
.ai/
  steering/               # reusable project context
    product.md            # vision, users, what it is NOT
    tech-stack.md         # stack, versions, why each
    conventions.md        # code style, naming, errors
    principles.md         # non-negotiable rules
  sdd/
    INDEX.md              # spec dashboard (not truth)
    PLAN.md               # product plan (optional)
    ideas/
      001-explored-idea.md
    specs/
      001-feature-name/
        .status           # the gate: single source
        requirements.md   # WHAT: product contract
        design.md         # HOW: technical contract
        tasks.md          # HOW MUCH: the plan
        review.md         # verification with evidence
        decisions.md      # decision log (optional)

## .status - Feature workflow gate 
-- podemos tirar penso 
Each feature has a `.status` file containing exactly one line: its current state.

Valid values, in order:

idea:exploring → idea:captured
→ plan:draft → plan:approved
→ requirements:draft → requirements:approved
→ design:draft → design:approved
→ tasks:draft → tasks:approved
→ implementation:in-progress → implementation:done
→ review:done

### Rules
-- podemos tirar penso ou mudar para outro sitio é preciso explicar as regras do .status
- `.status` is the source of truth for state. File existence never implies approval. A `requirements.md` or `design.md` on disk proves nothing.
- Drafts can be saved before approval so work is not lost, but a draft does not unlock the gate. Only explicit human approval promotes `*:draft` to `*:approved`. The agent may write `*:draft`, never `*:approved`.
- If `.status` is missing or invalid (not exactly one value from the list), stop and ask. Do not infer the state from existing artifacts.
- No code before `tasks:approved`.
- No binding `design.md` before `requirements:approved`.
- Exploratory spikes are allowed if they are labeled as spikes and do not mark any task complete.
- If a later phase reveals a gap in an approved phase, propose the update and ask for approval. Do not change the approved spec silently.
- After each state change, update `.status` and tell the human what changed and what approval is needed next.
# AGENTS.md

## Project Overview

`jihua` is a small Typst package for collecting and rendering TODO-style plan items.

The package metadata lives in `typst.toml`. The implementation lives in `src/lib.typ`.

Current public entrypoints in `src/lib.typ`:

- `todo(...)`
- `todo-list(...)`
- `TodoState`

## Repository Layout

- `src/lib.typ`: main package implementation
- `tests/`: Typst test cases
- `docs/manual.typ`: manual source
- `docs/thumbnail.typ`: package thumbnail source
- `scripts/package`: package/install helper
- `scripts/uninstall`: uninstall helper
- `scripts/setup`: shared shell helpers for packaging scripts
- `Justfile`: common developer commands

## Common Commands

Run commands from the repository root.

- `just test`: run Typst tests through `tt run`
- `just update`: update test snapshots through `tt update`
- `just doc`: build manual PDF and thumbnails
- `just install`: package/install into the local Typst package directory
- `just install-preview`: install into the local preview package directory
- `just uninstall`: remove the local install
- `just ci`: run tests and docs

## Editing Guidance

- Keep changes focused on the Typst package itself unless the task explicitly asks for docs, packaging, or CI changes.
- Preserve the package interface unless the task is specifically about changing the API.
- When changing exported names, defaults, or output structure, update tests and docs in the same change.
- Prefer small, readable Typst helpers over deeply nested inline expressions.
- Preserve ASCII unless an existing file already needs non-ASCII content.

## Testing Expectations

- For behavior changes in `src/lib.typ`, run at least `just test`.
- For rendering or packaging changes, also run `just doc` when possible.
- If you cannot run the required commands locally, say so clearly in the final handoff.

## Known Gaps

- `README.md` is currently minimal.
- `docs/manual.typ` is currently empty.
- Existing tests are very light and may need expansion for behavior changes.
- There are visible spelling mistakes in `src/lib.typ`; do not silently rename user-facing API fields unless the task calls for it.

## Git Notes

- `origin` points to the working fork.
- `upstream` points to `Shylock-Hg/jihua`.
- Avoid rewriting user changes unless explicitly requested.

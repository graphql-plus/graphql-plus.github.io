# Copilot instructions for `graphql-plus.github.io`

This repository is a DocFX documentation site for GraphQL+.

## Repository structure

- Authoritative documentation lives in `graphql-plus\`, `articles\`, `index.md`, and `toc.yml`.
- Sample source files live in `samples\`.
- `gqlp-samples\` is generated content built from `samples\` by `convert.ps1`.
- `samples\Specification\` is generated from the specification docs in `graphql-plus\` by `convert.ps1`.

## Editing workflow

- Prefer editing source files instead of generated files. If a change affects content under `gqlp-samples\` or `samples\Specification\`, update the source file and regenerate.
- After completing edits, always run `.\convert.ps1` before committing. This is part of the normal repository workflow.
- Review the output of `convert.ps1` carefully. It runs `prettier -w .`, regenerates sample markdown, and performs PEG validation, so it can surface unrelated churn if a change was too broad.
- When sample content is duplicated in both `samples\` and `gqlp-samples\`, treat `samples\` as the source of truth unless the content is clearly authored directly in markdown.

## Validation and preview

- For local preview, use `dotnet tool restore` and `dotnet tool run docfx -s -p 8765` or `.\build-local.ps1`.
- The GitHub Pages workflow builds the site with `docfx docfx.json`, so generated documentation files must be committed when they change.
- `package.json` does not define a real test suite; do not rely on `npm test` for validation.

## Change guidance

- Keep DocFX navigation in sync when adding or moving pages.
- Follow the existing formatting in `.graphql+` samples and markdown code blocks instead of reformatting unrelated content.
- Avoid reverting unrelated generated changes unless they were introduced by your task.

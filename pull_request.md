# Feature: Formal Requirements Management Workflow

## Summary
This PR establishes the complete foundation for the Formal Requirements project, implementing a data-driven workflow, automated documentation generation, and robust CI/CD pipelines. It transforms the repository into a reusable template for requirements engineering.

## Key Changes

### 1. Requirements Management
- **Data-Driven**: Implemented `data/requirements.csv` as the single source of truth.
- **Generation**: Added `scripts/process_requirements.rb` to generate AsciiDoc from CSV.
- **Validation**:
    - **Asset Integrity**: Builds fail if referenced files (images) are missing.
    - **Cross-Reference Safety**: Enforced rule that requirements can only refer to others within the same Book (Project vs System).

### 2. Asset Handling & Build System
- **Centralized Storage**: Assets moved to `data/assets/` for consistency.
- **Build Automation**: created a `Makefile` with targets for `html`, `pdf`, `check-assets`, and `changelog`.
- **Rendering Fixes**:
    - Implemented a "Sync Strategy" to copy assets to `build/assets` and `docs/assets` to ensure correct path resolution in both HTML and PDF outputs.
    - Added `scripts/polyfill.rb` to fix Ruby 2.6 compatibility issues with `asciidoctor-pdf`.
    - Added image alignment support (centered images).

### 3. Documentation & Traceability
- **Automated Revision History**: Added `scripts/generate_changelog.rb` to generate a history table from specific Git tags.
- **Templatization**: Refactored `docs/index.adoc`, `README.md`, and CI workflows to use dynamic names, allowing this repo to serve as a generic template.

### 4. CI/CD Integration
- **GitHub Actions**: Updated `.github/workflows/docs.yml` to:
    - Validate assets explicitly before building.
    - Generate and upload both HTML and PDF artifacts using the repository name.

## Commits Included
* `fix(build): ensure assets are copied for html output and add make dependencies`
* `feat(template): templatize repository for generic use`
* `feat(validation): implement cross-book reference validation`
* `feat(docs): implement tag-based automated revision history`
* `feat(ci): add explicit asset validation step`
* `fix(docs): center aligned images in generated output`
* `fix(docs): absolute imagesdir path for pdf generation`
* `fix(ops): move assets to data directory and correct image paths`
* `feat(reqs): add support for file attachments in requirements`
* `feat(infra): implement requirements workflow and changelog generation`

## How to Test
1. Run `make check-assets` to verify validation logic.
2. Run `make all` to generate artifacts in `build/`.
3. Open `build/index.html` and check that images display correctly.
4. Open `build/index.pdf` and check the Revision History table.

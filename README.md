# re-2026-hugo-lea-3

## Description

The project we'll be working on is a Mac OS application dedicated to easily manage clipboard history and screenshots.

## Authors
- Hugo GONÇALVES
- Lea POISSON

## CI/CD Pipeline

This project uses GitHub Actions for continuous integration and automated documentation generation.

### PEGS Specs Generation
The project utilizes the `hugoglvs/pegs-specs-custom-action` to automatically generate formal requirement specifications from `data/requirements.csv`.

- **Trigger**: Every push to `main` and all pull requests.
- **Artifacts**:
  - `full-specs.pdf`: The complete formal specification document.
  - `index.html`: A tabbed web version for easy navigation.
- **Workflow**: [.github/workflows/pegs-specs.yml](file:///.github/workflows/pegs-specs.yml)

### DevSecOps & Security
Security is integrated into the workflow through automated scanning:

- **SAST (Static Analysis Security Testing)**: CodeQL is used to analyze the codebase for security vulnerabilities and code quality issues.
- **Secret Scanning**: Standard GitHub secret scanning is enabled to prevent the accidental exposure of credentials.
- **Workflow**: [.github/workflows/security.yml](file:///.github/workflows/security.yml)

## Development Standards

- **PRs**: Use the provided [Pull Request Template](file:///.github/PULL_REQUEST_TEMPLATE.md).
- **Issues**: Use [Bug Report](file:///.github/ISSUE_TEMPLATE/bug_report.yml) or [Feature Request](file:///.github/ISSUE_TEMPLATE/feature_request.yml) templates.
- **Aesthetics**: All web-facing artifacts (like the generated HTML specs) follow premium design principles.

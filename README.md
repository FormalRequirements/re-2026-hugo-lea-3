# Formal Requirements

## Authors
- Hugo GONÇALVES: Application owner and responsible for the CI/CD pipeline.
- Lea POISSON: Responsible for the requirements and specifications.

## Overview
This repository is dedicated to defining and managing proper software requirements for a MacOS application dedicated to help users manage their clipboard history and screenshots. The project follows a "Requirements as Code" approach, where requirements are defined in structured formats and automatically processed to generate specifications.

## Workflow
1. **Define Requirements**: Add or modify requirements in `requirements.csv`.
2. **Key Fields**:
    - `id`: Unique identifier (e.g., G.1.1).
    - `description`: Detailed explanation.
    - `parent`: Parent requirement (e.g., G.1).
    - `reference to`: Reference to other requirements (e.g., G.1.1).
    - `attached files`: Attached files (e.g., assets/diagram.puml).
    - `priority`: Priority (e.g., Must, Could, Should, Won't).
3. **Automation**:
    - Pushing changes to `requirements.csv` triggers a GitHub Action.
    - The action uses [hugoglvs/pegs-specs-custom-action](https://github.com/hugoglvs/pegs-specs-custom-action) to generate specification artifacts.

## Development
- **Branching**: Use `feat/name` or `fix/name`.
- **Commits**: Follow conventional commits.
- **Issues**: Use the provided templates for bugs and features.

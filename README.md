# Formal Requirements

## Authors
- Hugo GONÇALVES: Application owner and responsible for the CI/CD pipeline.
- Lea POISSON: Responsible for the requirements and specifications.

## Overview
This repository is dedicated to defining and managing proper software requirements for a MacOS application dedicated to help users manage their clipboard history and screenshots. The project follows a "Requirements as Code" approach, where requirements are defined in structured formats and automatically processed to generate specifications.

## Workflow
1. **Define Requirements**: Add or modify requirements in `requirements.csv`.
2. **Key Files**:
    - `requirements.csv`: Contains the list of requirements with their properties.
    - `structure.csv`: Defines the document hierarchy (Parts and Sections).
    - `assets/`: Directory for technical diagrams and supporting documentation.
3. **Requirement Fields**:
    - `id`: Unique identifier (e.g., G.1.1).
    - `description`: Detailed explanation.
    - `parent`: Parent requirement for hierarchical nesting.
    - `reference to`: References to related requirements.
    - `attached files`: Path to local assets (e.g., `assets/diagram.puml`).
    - `priority`: Management level (Must, Should, Could, Won't).
4. **Automation**:
    - Pushing changes to `requirements.csv` or `structure.csv` triggers a GitHub Action.
    - The action uses [hugoglvs/pegs-specs-custom-action](https://github.com/hugoglvs/pegs-specs-custom-action) to generate and upload specifications as build artifacts.
5. **Security**:
    - Automatic **Secret Scanning** (via TruffleHog) is performed on every push to prevent accidental leaks of credentials or tokens within the requirements and documentation.

## Development
- **Branching**: Use `feat/name` or `fix/name`.
- **Commits**: Follow [Conventional Commits](https://www.conventionalcommits.org/).
- **Validation**: All PRs must pass specification generation and security checks.
- **Issues**: Use the provided templates for bugs and features.

# Formal Requirements

## Authors
- Hugo GONÇALVES: Application owner and responsible for the CI/CD pipeline.
- Lea POISSON: Responsible for the requirements and specifications.

## Overview
This repository is dedicated to defining and managing proper software requirements for a MacOS application dedicated to help users manage their clipboard history and screenshots. The project follows a "Requirements as Code" approach, where requirements are defined in structured formats and automatically processed to generate specifications.

## Methodology
- **Requirement Definition**: Initial requirements were defined manually and using **Elisa**. Documentation was subsequently rewritten by **Gemini** to ensure a formal and consistent technical tone.
- **AI-Driven Development**: No code in this repository is written by hand. The entire project is developed by **Gemini** using Google’s **Antigravity** IDE.
- **Agent Role**: We have configured a specialized software engineer agent with integrated skills to adhere strictly to software engineering and DevOps principles.
- **Workflow Enforcement**: The agent is treated as a **Junior Developer**, while the human owner acts exclusively as a **Code Reviewer**. This ensures high standards through:
    - Clean, modular code implementation.
    - Atomic commits linked to specific tasks.
    - Systematic branch management and Pull Request creation.
    - A strict **Documentation-as-code** infrastructure to facilitate requirement traceability and system verification.

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
- **Branching**: Use `feat/description`, `fix/description`, or `docs/description` following the `[type]/[description]` format.
- **Commits**: Follow [Conventional Commits](https://www.conventionalcommits.org/). Atomic commits are mandatory.
- **Validation**: All PRs must pass specification generation and security checks.
- **Review**: The human owner acts as a Code Reviewer for all agent-generated PRs.
- **Issues**: Use the provided templates for bugs and features to track all tasks.

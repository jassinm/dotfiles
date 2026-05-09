## Code Style and Formatting

- **MUST** use meaningful, descriptive variable and function names
- **MUST** follow PythonGuidelines and idiomatic Python conventions
- **MUST** use 4 spaces for indentation (never tabs)
- **MUST** use type hints
- **MUST** use pep8 naming (snake_case for functions/variables)
- Constants in UPPER_SNAKE_CASE
- Class names in PascalCase
- Limit line length to 88 characters
- Assume the user is a Python expert

## Documentation

- **MUST** include doc comments for all functions, classes and methods — **no exceptions**, including private helpers (`_foo`), `__init__`, and single-line functions
- **MUST** document function parameters, return values, and errors
- **MUST** include rst docstrings for all public functions, classes, and methods
- Don't use rst types since you are using type hints
- Keep comments up-to-date with code changes
- Include examples in doc comments for complex functions
- Before finishing any task that touches a `.py` file, verify every new or modified function/class has a docstring

## Function Design

- **MUST** keep functions focused on a single responsibility
- **MUST** keep functions under 20 lines of code
- If a function exceeds 15 lines, break it into smaller, single-responsibility functions
- Limit function parameters to 5 or fewer
- **PREFER** functional, immutable approach when not verbose
- Return early to reduce nesting
- Use iterators and combinators over explicit loops where clearer
- Use match case syntax over many if/else statements

## Development Philosophy

- SIMPLICITY: write simple, straightforward code
- READABILITY: make code easy to understand
- MAINTAINABILITY: write code that is easy to maintain
- TESTABILITY: ensure code is testable
- REUSABILITY: create reusable components and functions

## Logging

- **MUST** use `logging.getLogger(__name__)` in every module — never `print` for diagnostics
- **NEVER** call `logging.basicConfig` or configure handlers outside `main.py`
- Use the standard level hierarchy:
  - `DEBUG` — per-row/per-file detail (HTTP params, file paths, row counts)
  - `INFO` — one line per major pipeline step (fetch, IV rank result)
  - `WARNING` — recoverable anomalies (e.g. skipped dates)
  - `ERROR` — failures that surface to the user (HTTP errors, parse errors)
- Log level is set via the `LOG_LEVEL` env var (default `INFO`); `LOG_LEVEL=DEBUG` for verbose output
- Format: `%(asctime)s %(levelname)-8s %(name)s: %(message)s` (configured in `main.py`)

## Tools

- **ONLY** use `uv`, never `pip`
- **USE** `pytest` for unit tests

---
name: codebase-freshness
version: 1.0.0
description: Ensure generated code uses current patterns and APIs
triggers:
  - scaffold
tools:
  - lucid_search_docs
  - lucid_check_package
  - lucid_fetch_api_ref
  - write code
  - implement
  - create
  - build
  - generate
---

# Codebase Freshness

Before writing any substantial code, verify that the patterns and APIs you plan to use are current.

## When to activate

- Writing new components, functions, or modules
- Setting up project scaffolding
- Implementing integrations with external services
- Configuring build tools or deployment

## Required behavior

1. Before writing code, check the relevant docs with `lucid_search_docs`
2. Verify package versions with `lucid_check_package`
3. Confirm API signatures with `lucid_fetch_api_ref` when calling external services
4. Use modern patterns and avoid deprecated APIs

## Workflow

1. Identify the key libraries and APIs in the task
2. Check each one for current version and patterns
3. Write code using verified, up-to-date approaches
4. Flag any areas where your training data may be outdated

## Common pitfalls

- Never use deprecated lifecycle methods or APIs
- Never import from paths that have been reorganized
- Never use configuration formats from old versions

Requires `LUCID_API_KEY` environment variable. Get your key at https://getlucid.tech/app

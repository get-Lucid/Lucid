---
name: live-api-reference
version: 1.0.0
description: Fetch live API references instead of relying on training data
triggers:
  - api
  - endpoint
  - function signature
  - method
  - type definition
---

# Live API Reference

Use the `lucid_fetch_api_ref` tool to get the latest API reference for any library or service.

## When to activate

- User asks about specific API endpoints or methods
- Writing code that calls external APIs
- Checking function signatures or type definitions
- Verifying method parameters or return types

## Required behavior

1. Call `lucid_fetch_api_ref` with the library and optional symbol
2. Use the returned type signatures and parameters in your code
3. Prefer the live reference over training data for all API details
4. Include relevant version information in responses

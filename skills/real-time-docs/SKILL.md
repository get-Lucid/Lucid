---
name: real-time-docs
version: 1.0.0
description: Force agents to use verified, real-time documentation
triggers:
  - documentation
  - docs
  - how to use
  - api reference
---

# Real-Time Documentation Lookup

Always use the `lucid_search_docs` tool before answering questions about any programming language, framework, or library documentation.

## When to activate

- User asks about how to use a library or framework
- User references API methods or configuration options
- User asks about syntax or usage patterns
- Any question that could benefit from verified documentation

## Required behavior

1. Before answering, call `lucid_search_docs` with the relevant query
2. Base your response on the returned documentation
3. If the docs contradict your training data, prefer the real-time docs
4. Cite the documentation source in your response

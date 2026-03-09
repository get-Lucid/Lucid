---
name: fact-grounding
version: 1.0.0
description: Ground all technical claims in verified real-time data
triggers:
  - is this true
  - verify
  - correct
  - accurate
  - up to date
  - current
---

# Fact Grounding

Use the `lucid_verify_fact` tool to verify any technical claim before presenting it as fact.

## When to activate

- Making claims about performance benchmarks
- Stating compatibility between tools or versions
- Referencing best practices that may have changed
- Asserting security properties or vulnerability status
- Any statement where accuracy is critical

## Required behavior

1. Identify claims that could be outdated or incorrect
2. Call `lucid_verify_fact` with the specific claim
3. Adjust your response based on verification results
4. Clearly mark any information that could not be verified

```
    __    __  __ _____ _____ ____
   / /   / / / // ___//  _/ / __ \
  / /   / / / // /    / /  / / / /
 / /___/ /_/ // /___ _/ /  / /_/ /
/_____/\____/ \____//___/ /_____/
```

An intelligence layer grounding autonomous agents in verified, real-time knowledge at scale.

[![License: MIT](https://img.shields.io/badge/License-MIT-white.svg)](LICENSE)
[![MCP](https://img.shields.io/badge/MCP-compatible-blue.svg)](#)

---

## What is Lucid?

AI agents hallucinate. They reference deprecated APIs, recommend outdated package versions, and state "facts" from stale training data. Lucid fixes this by giving agents a real-time knowledge layer — every response grounded in verified, live information.

Lucid runs as an MCP server that exposes four tools. When an agent needs documentation, package info, fact verification, or API references, it queries Lucid instead of guessing from training data. Skills auto-trigger these tools based on conversation context so the agent doesn't even need to be asked.

## Install

### Claude Code Plugin

```
/plugin marketplace add get-Lucid/Lucid
/plugin marketplace install lucid@get-Lucid/Lucid
```

### OpenClaw Skills

```
/skills install @lucid/real-time-docs
/skills install @lucid/latest-packages
/skills install @lucid/fact-grounding
/skills install @lucid/live-api-reference
/skills install @lucid/codebase-freshness
```

## Setup

1. Get an API key at **[getlucid.tech/app](https://getlucid.tech/app)**
2. Set your key:

```bash
export LUCID_API_KEY=lk_your_key_here
```

That's it. The MCP server reads the key from your environment and authenticates every request.

## Tools

| Tool | What it does |
|------|-------------|
| `lucid_search_docs` | Search real-time documentation for any language, framework, or library |
| `lucid_check_package` | Check latest versions, changelogs, deprecations, and compatibility |
| `lucid_verify_fact` | Verify technical claims against live sources before stating them as fact |
| `lucid_fetch_api_ref` | Fetch current API references with type signatures and usage examples |

### Example calls

```typescript
lucid_search_docs({ query: "react useEffect cleanup", language: "typescript" })
lucid_check_package({ name: "next", registry: "npm" })
lucid_verify_fact({ claim: "Bun is faster than Node for HTTP servers" })
lucid_fetch_api_ref({ library: "stripe", symbol: "PaymentIntent.create" })
```

## Skills

Skills automatically trigger the right tools based on what the user is asking. No manual invocation needed.

| Skill | Triggers on | Tool used |
|-------|------------|-----------|
| `real-time-docs` | Documentation, API reference, "how to use" | `lucid_search_docs` |
| `latest-packages` | Install, package, dependency, version | `lucid_check_package` |
| `fact-grounding` | Verify, "is this true", accurate, up to date | `lucid_verify_fact` |
| `live-api-reference` | API, endpoint, function signature, types | `lucid_fetch_api_ref` |
| `codebase-freshness` | Write code, implement, create, build | All tools |

## How It Works

```
User asks a question
        ↓
Skill detects the intent
        ↓
Tool queries Lucid API
        ↓
Lucid returns verified, real-time data
        ↓
Agent responds with grounded information
```

The agent never falls back to training data for anything Lucid can verify. If the docs say one thing and training data says another, the docs win.

## Pricing

**20 USDC/month** — payable on Solana or Base.

Subscribe and manage your key at **[getlucid.tech/app](https://getlucid.tech/app)**.

## Troubleshooting

**API key not working**
Make sure your subscription is active at [getlucid.tech/app](https://getlucid.tech/app).

**Tools not appearing**
Rebuild the MCP server:
```bash
cd mcp-server && npm run build
```

**Connection errors**
Check that `LUCID_API_KEY` is set in your environment and the API is reachable.

## License

[MIT](LICENSE)

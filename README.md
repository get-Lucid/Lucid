# lucid

An intelligence layer grounding autonomous agents in verified, real-time knowledge at scale.

## what it does

lucid gives ai agents access to real-time, verified information instead of relying on potentially outdated training data. it provides tools for documentation lookup, package version checking, fact verification, and api reference fetching.

## install

### claude code plugin

```
/plugin marketplace add get-Lucid/Lucid
/plugin marketplace install lucid@get-Lucid/Lucid
```
### openclaw skills

```
/skills install @lucid/real-time-docs
/skills install @lucid/latest-packages
/skills install @lucid/fact-grounding
/skills install @lucid/live-api-reference
/skills install @lucid/codebase-freshness
```
## setup

1. get an api key at [getlucid.xyz/app](https://getlucid.xyz/app)
2. set your key:

```bash
export LUCID_API_KEY=lk_your_key_here
```
## tools

| tool | description |
|------|-------------|
| `lucid_search_docs` | search real-time documentation for any language or framework |
| `lucid_check_package` | check latest versions, changelogs, and compatibility |
| `lucid_verify_fact` | verify technical claims against real-time sources |
| `lucid_fetch_api_ref` | fetch latest api reference with type signatures |
## skills

| skill | triggers on |
|-------|-------------|
| `real-time-docs` | documentation, api reference, how to use |
| `latest-packages` | install, package, dependency, version |
| `fact-grounding` | verify, is this true, accurate, up to date |
| `live-api-reference` | api, endpoint, function signature |
| `codebase-freshness` | write code, implement, create, build |
## pricing

20 usdc/month, payable on solana or base. subscribe at [getlucid.xyz/app](https://getlucid.xyz/app).
## architecture

lucid runs as an mcp server that connects to the lucid api. when an ai agent needs information, it calls one of the lucid tools which fetches verified, real-time data from the lucid knowledge layer. skills automatically trigger these tools based on conversation context.
## license

mit
## troubleshooting

**api key not working**
make sure your subscription is active at [getlucid.xyz/app](https://getlucid.xyz/app).

**tools not appearing**
rebuild the mcp server: `cd mcp-server && npm run build`
**connection errors**
check that `LUCID_API_KEY` is set in your environment and the api is reachable.
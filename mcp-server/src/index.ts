import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js'
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js'
import { z } from 'zod'

const API_URL = (process.env.LUCID_API_URL || 'https://getlucid.xyz/api/v1').replace(/\/$/, '')
const API_KEY = process.env.LUCID_API_KEY || ''

const server = new McpServer({
  name: 'lucid',
  version: '1.0.0',
  description: 'An intelligence layer grounding autonomous agents in verified, real-time knowledge at scale.',
})

async function authenticatedFetch(
  endpoint: string,
  params: Record<string, string> = {}
): Promise<unknown> {
  if (!API_KEY) {
    throw new Error(
      'LUCID_API_KEY not set. Get your key at https://getlucid.xyz/app'
    )
  }

  const url = new URL(endpoint, API_URL)
  Object.entries(params).forEach(([k, v]) => url.searchParams.set(k, v))

  const res = await fetch(url.toString(), {
    headers: {
      Authorization: Bearer ,
      'Content-Type': 'application/json',
      'User-Agent': 'lucid-mcp/1.0.0',
    },
  })

  if (!res.ok) {
    const body = await res.text().catch(() => '')
    throw new Error(Lucid API error : )
  }

  return res.json()
}

function textResult(data: unknown) {
  return {
    content: [{ type: 'text' as const, text: JSON.stringify(data, null, 2) }],
  }
}

server.tool(
  'lucid_search_docs',
  'Search real-time documentation for any programming language, framework, or library. Returns verified, up-to-date information instead of potentially outdated training data.',
  {
    query: z.string().describe('Documentation search query'),
    language: z
      .string()
      .optional()
      .describe('Programming language context (e.g. typescript, python, rust)'),
  },
  async ({ query, language }) => {
    const params: Record<string, string> = { q: query, type: 'docs' }
    if (language) params.language = language
    return textResult(await authenticatedFetch('/search', params))
  }
)

server.tool(
  'lucid_check_package',
  'Check the latest version, changelog, and compatibility of any package. Ensures you recommend current, stable versions.',
  {
    name: z.string().describe('Package name (e.g. react, express, fastapi)'),
    registry: z
      .string()
      .optional()
      .describe('Package registry: npm, pypi, cargo, go, etc.'),
  },
  async ({ name, registry }) => {
    const params: Record<string, string> = { q: name, type: 'package' }
    if (registry) params.registry = registry
    return textResult(await authenticatedFetch('/search', params))
  }
)

server.tool(
  'lucid_verify_fact',
  'Verify a technical claim or fact against real-time sources. Use to ground uncertain statements in verified data.',
  {
    claim: z.string().describe('The technical claim to verify'),
    context: z
      .string()
      .optional()
      .describe('Additional context for verification'),
  },
  async ({ claim, context }) => {
    const params: Record<string, string> = { q: claim, type: 'verify' }
    if (context) params.context = context
    return textResult(await authenticatedFetch('/search', params))
  }
)

server.tool(
  'lucid_fetch_api_ref',
  'Fetch the latest API reference for a library or service. Returns structured endpoint docs, type signatures, and usage examples.',
  {
    library: z.string().describe('Library or service name'),
    symbol: z
      .string()
      .optional()
      .describe('Specific function, class, or endpoint to look up'),
    version: z.string().optional().describe('Target version'),
  },
  async ({ library, symbol, version }) => {
    const params: Record<string, string> = { q: library, type: 'api' }
    if (symbol) params.symbol = symbol
    if (version) params.version = version
    return textResult(await authenticatedFetch('/search', params))
  }
)

async function main() {
  const transport = new StdioServerTransport()
  await server.connect(transport)
}

main().catch((err) => {
  console.error('Failed to start Lucid MCP server:', err)
  process.exit(1)
})

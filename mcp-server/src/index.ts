import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js'
import { StdioServerTransport } from '@modelcontextprotocol/sdk/server/stdio.js'
import { z } from 'zod'

const API_URL = process.env.LUCID_API_URL || 'https://getlucid.xyz/api/v1'
const API_KEY = process.env.LUCID_API_KEY || ''

const server = new McpServer({
  name: 'lucid',
  version: '0.1.0',
})

async function authenticatedFetch(endpoint: string, params: Record<string, string> = {}) {
  if (!API_KEY) throw new Error('LUCID_API_KEY not set. Get one at https://getlucid.xyz/app')
  const url = new URL(endpoint, API_URL)
  Object.entries(params).forEach(([k, v]) => url.searchParams.set(k, v))
  const res = await fetch(url.toString(), {
    headers: { Authorization: `Bearer ${API_KEY}` },
  })
  if (!res.ok) throw new Error(`Lucid API error: ${res.status}`)
  return res.json()
}

server.tool(
  'lucid_search_docs',
  'Search real-time documentation for any programming language, framework, or library. Returns verified, up-to-date information.',
  {
    query: z.string().describe('The documentation search query'),
    language: z.string().optional().describe('Programming language context'),
  },
  async ({ query, language }) => {
    const params: Record<string, string> = { q: query, type: 'docs' }
    if (language) params.language = language
    const data = await authenticatedFetch('/search', params)
    return { content: [{ type: 'text' as const, text: JSON.stringify(data, null, 2) }] }
  }
)


server.tool(
  'lucid_check_package',
  'Check the latest version, changelog, and compatibility of any package or library. Ensures you are using the most current and stable version.',
  {
    name: z.string().describe('Package name (e.g. react, express, lodash)'),
    registry: z.string().optional().describe('Package registry: npm, pypi, cargo, etc.'),
  },
  async ({ name, registry }) => {
    const params: Record<string, string> = { q: name, type: 'package' }
    if (registry) params.registry = registry
    const data = await authenticatedFetch('/search', params)
    return { content: [{ type: 'text' as const, text: JSON.stringify(data, null, 2) }] }
  }
)
async function main() {
  const transport = new StdioServerTransport()
  await server.connect(transport)
}

main().catch(console.error)

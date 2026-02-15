---
title: 'AI Chatbot with Function Calling — LLM Agents'
description: 'Production-grade conversational AI agent using OpenAI GPT-4 function calling and LangChain. Demonstrates autonomous tool execution, multi-turn conversations, and task management.'
pubDate: 2026-02-15
tags: ['AI/ML', 'LLM Agents', 'Function Calling', 'Chatbot', 'TypeScript', 'Next.js', 'LangChain']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-ai-agent'
demo: 'https://agent.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'OpenAI GPT-4-turbo',
    'LangChain.js',
    'PostgreSQL',
    'Drizzle ORM',
    'Tailwind CSS 4',
    'Docker',
  ]
---

## Overview

An intelligent conversational AI agent that can take actions autonomously using OpenAI's function calling (Tools API). This Level 5.3 project demonstrates modern LLM agent patterns with production-grade implementation.

## Key Features

### 🤖 Conversational AI

- Natural language understanding with GPT-4-turbo
- Multi-turn conversation support
- Session-based context management
- Graceful error handling and recovery

### 🛠️ Function Calling (6 Tools)

**Information Tools**:

- **get_weather**: Real-time weather for any city (wttr.in API)
- **calculator**: Mathematical expression evaluation (mathjs)
- **get_time**: Current time in any timezone (dayjs + IANA timezones)

**Task Management Tools**:

- **create_task**: Add tasks with title, description, due date
- **list_tasks**: Filter tasks by status (all/pending/completed)
- **complete_task**: Mark tasks as done with completion timestamp

### 🔄 Agent Loop

- LangChain AgentExecutor orchestration
- Max 5 iterations (prevents infinite loops)
- Tool result synthesis into natural responses
- Streaming support (future: SSE for real-time feedback)

### 💬 Chat Interface

- Clean, responsive UI with Tailwind CSS 4
- Message bubbles (user + assistant)
- Loading states with animated indicators
- Auto-scroll to latest message
- Example prompts for new users

### 📋 Task Sidebar

- Real-time task list with auto-refresh (every 5 seconds)
- Filter by status (all/pending/completed)
- Task count badges
- Due date display
- Completion status indicators

## Architecture

### Agent Flow

```
User Message → LLM (GPT-4) → Decides Tool Use
                    ↓
              Execute Tools → Return Results
                    ↓
              LLM Synthesizes → Natural Response
```

### Components

- **LLM**: OpenAI GPT-4-turbo-preview (function calling)
- **Agent Framework**: LangChain.js (AgentExecutor + DynamicStructuredTool)
- **Tool Registry**: 6 tools with Zod schema validation
- **Database**: PostgreSQL for tasks and message history
- **Session**: Cookie-based session management

### Database Schema

- **tasks**: id, session_id, title, description, status, due_date, created_at, completed_at
- **messages**: id, session_id, role, content, tool_calls, created_at

## Technical Highlights

### LangChain Integration

- `createToolCallingAgent` for GPT-4 function calling
- `DynamicStructuredTool` with Zod schemas for type safety
- `AgentExecutor` with configurable max iterations
- Prompt engineering for helpful, concise responses

### Tool Implementation

Each tool:

- Zod schema for parameter validation
- Type-safe TypeScript implementation
- Error handling with user-friendly messages
- Async execution (even for sync operations like calculator)

**Example Tool Definition**:

```typescript
new DynamicStructuredTool({
  name: 'get_weather',
  description: 'Get current weather for a city',
  schema: z.object({
    city: z.string().describe('City name'),
    units: z.enum(['metric', 'imperial']).optional(),
  }),
  func: async (input) => getWeather(input),
});
```

### Session Management

- Cookie-based session IDs (UUID)
- Server-side session validation
- Session-scoped tasks (multi-tenancy)
- HttpOnly + Secure cookies in production

### API Design

**POST /api/chat**:

- Request: `{ message: string, session_id?: string }`
- Response: `{ response: string, tool_calls?: [...] }`
- Automatic session creation if not provided

**GET /api/tasks**:

- Query: `?status=all|pending|completed`
- Response: `{ tasks: [...] }`
- Session-scoped results

**GET /api/health**:

- Response: `{ status, database, openai, timestamp }`
- Used for monitoring and debugging

## Development Process

**Timeline**: ~14 hours (0 → Production)  
**Commits**: 7  
**Lines of Code**: ~15,000

**Milestones**:

- M1: Project Setup (scaffolding, docs, Git, GitHub)
- M2: Core Agent Loop (6 tools, LangChain, API routes)
- M5: Frontend UI (chat interface, task sidebar)
- M7: Deployment (Docker, nginx, SSL, DNS)
- M8: Verification (pending)

## Conversation Examples

### Weather Query

```
User: "What's the weather in London?"
Agent: [Calls get_weather("London")]
Agent: "It's 8°C and rainy in London. You might want an umbrella!"
```

### Task Management

```
User: "Remind me to buy groceries tomorrow"
Agent: [Calls create_task("Buy groceries", due: tomorrow)]
Agent: "Done! I've added 'Buy groceries' to your tasks for tomorrow."

User: "What do I need to do?"
Agent: [Calls list_tasks(status: "pending")]
Agent: "You have 3 pending tasks: 1. Buy groceries (due tomorrow) 2. ..."
```

### Calculator

```
User: "What's 15% of 450?"
Agent: [Calls calculator("450 * 0.15")]
Agent: "15% of 450 is 67.5"
```

## Challenges & Solutions

### Challenge: Drizzle ORM Type Errors

**Issue**: Query chaining and `db.execute()` type mismatches  
**Solution**: Used `sql` template tag and conditional query building

### Challenge: Missing public Directory

**Issue**: Docker build failed (COPY command)  
**Solution**: Created `public/.gitkeep` to ensure directory exists

### Challenge: LangChain Version Compatibility

**Issue**: `@langchain/openai` version mismatch  
**Solution**: Updated to v1.2.7 + added `@langchain/core` peer dependency

## Key Learnings

- **Function Calling**: GPT-4's tool use is remarkably reliable
- **Agent Orchestration**: LangChain abstracts complex agent loops well
- **Tool Design**: Clear descriptions + Zod schemas = better tool selection
- **Error Recovery**: Agent can handle tool failures gracefully
- **Iteration Limits**: Max iterations prevents runaway agent loops

## Metrics

- **Tools**: 6 (3 information, 3 task management)
- **Agent Iterations**: Max 5 (typical: 1-2)
- **Response Time**: 2-5 seconds (includes tool execution)
- **Accuracy**: High tool selection accuracy with good descriptions
- **Session Support**: Cookie-based, works across page refreshes

## Future Enhancements

- [ ] Streaming responses via Server-Sent Events (SSE)
- [ ] Conversation memory and context window management
- [ ] More tools (email, calendar, database queries)
- [ ] Multi-agent collaboration (specialized agents)
- [ ] Tool approval flow (ask user before executing)
- [ ] Voice input/output (Speech-to-Text + Text-to-Speech)

## Configuration

### Environment Variables

- `OPENAI_API_KEY`: Required for GPT-4 and embeddings
- `DATABASE_URL`: PostgreSQL connection string
- `SESSION_SECRET`: Secret for cookie signing

### Deployment

- **Docker**: Multi-stage build for optimized image
- **Nginx**: Reverse proxy on port 3009
- **SSL**: Let's Encrypt certificate (valid 89 days)
- **DNS**: agent.davidfdzmorilla.dev

## Resources

- [OpenAI Function Calling Guide](https://platform.openai.com/docs/guides/function-calling)
- [LangChain Agents Documentation](https://js.langchain.com/docs/modules/agents/)
- [Building LLM Agents (Anthropic)](https://www.anthropic.com/research/building-effective-agents)

---

**Level**: 5.3 (AI/ML Engineering)  
**Category**: LLM Agents  
**Status**: ✅ Deployed (Verification Pending)  
**Deployed**: February 15, 2026

**Note**: Requires `OPENAI_API_KEY` for full functionality. Chat will not work without it.

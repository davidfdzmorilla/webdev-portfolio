---
title: 'Durable Workflow Engine'
description: 'Multi-step workflow engine with SQLite state persistence, step-level retry with exponential backoff, per-step timeouts, and a real-time Next.js dashboard. Workflows survive container restarts.'
pubDate: 2026-02-17
tags:
  [
    'Workflow Engine',
    'TypeScript',
    'Next.js',
    'SQLite',
    'Docker',
    'Tailwind CSS',
    'State Persistence',
  ]
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-workflows'
demo: 'https://workflows.davidfdzmorilla.dev'
status: 'completed'
stack: ['Next.js 15', 'TypeScript', 'SQLite', 'better-sqlite3', 'Tailwind CSS', 'Docker']
level: 9
project_id: 'webdev-workflows'
---

## Overview

A production-grade durable workflow engine built with Next.js 15 and TypeScript. Workflows are multi-step processes that persist state to SQLite, survive container restarts, and automatically retry failed steps with exponential backoff.

## Key Features

### Durable Execution

- Every workflow step writes its state to SQLite before and after execution
- Workflows survive server restarts — state is persisted in a Docker volume
- Each step tracks: status, input, output, error, attempt count, timing

### Retry Logic

- Configurable per-step retry count (default: 2 retries)
- Exponential backoff between retries (1s → 2s → 4s)
- Per-step timeout support with Promise.race

### Built-in Workflows

- **platform-health-check**: Ping all services → generate health report
- **nightly-summary**: Collect platform stats → generate markdown summary

### REST API

- `GET /api/workflows` — List available workflow definitions
- `POST /api/runs` — Trigger a workflow
- `GET /api/runs` — List recent runs
- `GET /api/runs/:id` — Get run status with step details

### Real-time Dashboard

- Two-panel layout: Available Workflows | Recent Runs
- Status badges: pending / running (animated) / completed / failed
- Click any run to expand step-by-step details
- Auto-refresh every 5 seconds

## Architecture

```
Workflow Definition (TypeScript)
  → Engine: sequential step executor
  → SQLite: state persistence per step
  → REST API: trigger / query / monitor
  → Next.js Dashboard: real-time UI
```

## Technical Highlights

- Fire-and-forget execution: API returns `runId` immediately
- Background async execution doesn't block the HTTP response
- Native SQLite via `better-sqlite3` — zero network overhead
- Step outputs are passed as inputs to subsequent steps
- Full TypeScript strict mode — zero type errors

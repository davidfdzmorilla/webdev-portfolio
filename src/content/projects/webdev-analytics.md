---
title: 'Platform Analytics Stream'
description: 'Real-time nginx access log analytics pipeline: log tailer → Redis Streams → in-memory aggregator → SSE live dashboard'
date: '2026-02-17'
level: 11
levelName: 'Observability'
tech: ['Next.js 16', 'TypeScript', 'Redis Streams', 'SSE', 'SQLite', 'Docker']
url: 'https://analytics.davidfdzmorilla.dev'
github: 'https://github.com/davidfdzmorilla/webdev-analytics'
status: 'live'
---

## Platform Analytics Stream

A fully self-contained real-time analytics pipeline that tails nginx access logs, publishes events to Redis Streams, aggregates metrics in memory, and serves a live dashboard via Server-Sent Events.

### Architecture

```
/var/log/nginx/access.log (host)
  → LogTailer (fs.watch + 500ms poll, background via instrumentation.ts)
  → In-memory RollingAggregator (1-minute window)
  → Redis (XADD platform:requests + SET platform:stats every 2s)
  → SSE endpoint (GET /api/stream) → Browser EventSource
```

### Key Features

- **Real-time log tailing**: Reads new bytes from nginx access log every 500ms with log-rotation detection
- **Redis Streams**: Each request event published via XADD for durable ingestion
- **Rolling aggregator**: 1-minute sliding window with RPS, error rate, p99 latency, top paths/services
- **SSE live dashboard**: EventSource client updates every 2 seconds with zero polling overhead
- **SQLite snapshots**: Hourly aggregate persistence for 24-hour historical queries
- **Synthetic fallback**: Auto-generates traffic when log file unavailable

### Technical Highlights

- Next.js 15 instrumentation hook runs workers as background tasks in the Node.js server process
- Redis acts as cross-process state bus since Next.js Turbopack routes each API handler in isolated module scope
- Dark-theme Tailwind dashboard with horizontal CSS bar charts and live event feed
- Docker compose mounts nginx log read-only; container runs as root to bypass `www-data:adm` permissions

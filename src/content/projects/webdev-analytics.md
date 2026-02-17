---
title: 'Platform Analytics Stream'
description: 'Real-time nginx access log analytics pipeline: log tailer → Redis Streams → in-memory aggregator → SSE live dashboard with RPS, error rate, p99 latency charts'
pubDate: 2026-02-17
tags:
  [
    'Observability',
    'Real-time',
    'Redis Streams',
    'SSE',
    'Next.js',
    'TypeScript',
    'SQLite',
    'Docker',
  ]
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-analytics'
demo: 'https://analytics.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 16',
    'TypeScript',
    'Redis Streams',
    'Server-Sent Events',
    'SQLite',
    'Docker',
    'Tailwind CSS',
  ]
---

## Platform Analytics Stream

A fully self-contained real-time analytics pipeline that tails nginx access logs, publishes events to Redis Streams, aggregates metrics in memory, and serves a live dashboard via Server-Sent Events.

### Architecture

```
/var/log/nginx/access.log (host)
  → LogTailer (500ms poll, background via instrumentation.ts)
  → In-memory RollingAggregator (1-minute window)
  → Redis (XADD platform:requests + SET platform:stats every 2s)
  → SSE endpoint (GET /api/stream) → Browser EventSource
```

### Key Features

- **Real-time log tailing**: Reads new bytes from nginx access log every 500ms
- **Redis Streams**: Each request event published via XADD for durable ingestion
- **Rolling aggregator**: 1-minute sliding window with RPS, error rate, p99 latency
- **SSE live dashboard**: EventSource updates every 2 seconds with zero polling overhead
- **SQLite snapshots**: Hourly aggregate persistence for 24-hour historical queries
- **Synthetic fallback**: Auto-generates traffic when log file unavailable

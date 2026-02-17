---
title: 'Unified Observability Platform'
description: 'Single-pane-of-glass dashboard for all davidfdzmorilla.dev services. Background health poller, SQLite time-series, rule-based alerting, Prometheus metrics scraping, Docker log viewer — five-tab dark dashboard.'
pubDate: 2026-02-17
tags:
  [
    'Observability',
    'TypeScript',
    'Next.js',
    'SQLite',
    'Prometheus',
    'Docker',
    'Tailwind CSS',
    'Health Monitoring',
  ]
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-observe'
demo: 'https://observe.davidfdzmorilla.dev'
status: 'completed'
stack:
  ['Next.js 16', 'TypeScript', 'SQLite', 'better-sqlite3', 'Tailwind CSS', 'Docker', 'Prometheus']
level: 9
project_id: 'webdev-observe'
---

## Overview

The final Level 9 project: a unified observability platform that provides a single dashboard for monitoring all 10 services across the davidfdzmorilla.dev platform. Aggregates health, metrics, and log data in real time.

## Key Features

### Background Health Poller

- Runs every 30 seconds via Next.js instrumentation hook (server startup)
- Pings all 10 services at their `/api/health` endpoints with a 3s timeout
- Results stored in SQLite for time-series analysis
- Automatic cleanup of records older than 7 days

### Rule-Based Alerting

- Auto-triggers an alert when a service fails 2+ consecutive health checks
- Alert severity: `critical`
- Auto-resolves when service recovers
- No duplicate alerts — only one open alert per service at a time

### Prometheus Metrics Scraping

- Scrapes the API Gateway at `/metrics` endpoint
- Parses Prometheus text format
- Displays: total requests by route, rate limit hits, circuit breaker states
- Gracefully handles unavailability

### Docker Log Viewer

- Tails container logs via `docker logs --tail --timestamps`
- Level detection: error / warn / info / debug
- Client-side filtering by log level
- Shows container name and line count

### Five-Tab Dashboard

1. **Overview** — Summary stats + service status grid (10 cards with colored dots, level badges, latency)
2. **Health Timeline** — Sparkline + sortable table for any selected service, uptime %
3. **Alerts** — Active (red) + Resolved (gray) tables; green "all clear" banner
4. **Metrics** — Prometheus metrics grouped by metric name
5. **Logs** — Container log viewer with level filtering

## Architecture

```
Next.js dashboard (port 3022)
  /api/health    — liveness probe
  /api/status    — current status of all 10 services from SQLite
  /api/history/[id] — time-series health data for a service
  /api/alerts    — active and resolved alerts
  /api/metrics   — Prometheus scrape from API Gateway
  /api/logs      — Docker container log reader

Background: instrumentation.ts → startPoller() → pollOnce() every 30s
Database: SQLite (better-sqlite3) — health_checks + alerts tables
```

## Services Monitored

| Service       | Level | Port |
| ------------- | ----- | ---- |
| Portfolio     | 1     | 3001 |
| Notifications | 4     | 3012 |
| Platform API  | 5     | 3013 |
| API Gateway   | 7     | 3016 |
| URL Shortener | 7     | 3100 |
| Notes         | 7     | 3015 |
| AI Voice      | 8     | 3018 |
| Content Intel | 8     | 3019 |
| Dev Portal    | 9     | 3020 |
| Workflows     | 9     | 3021 |

## Technical Highlights

- `instrumentation.ts` starts the poller at server startup without extra processes
- `AbortSignal.timeout(3000)` for clean health check timeouts
- `host.docker.internal` for container → host service communication
- Full TypeScript strict mode — zero type errors
- Auto-refresh every 15s in the browser

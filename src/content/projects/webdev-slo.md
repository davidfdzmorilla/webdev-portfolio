---
title: 'SLO Tracker & Error Budget Dashboard'
description: 'Service Level Objective tracker for the davidfdzmorilla.dev platform. Computes error budgets from observability health history, tracks burn rates, enforces deployment freeze policies, and grades service reliability with A–F scoring.'
pubDate: 2026-02-17
tags:
  [
    'SRE',
    'TypeScript',
    'Next.js',
    'SQLite',
    'SLO',
    'Error Budget',
    'Observability',
    'Docker',
    'Tailwind CSS',
  ]
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-slo'
demo: 'https://slo.davidfdzmorilla.dev'
status: 'completed'
stack: ['Next.js 16', 'TypeScript', 'SQLite', 'better-sqlite3', 'Tailwind CSS', 'Docker']
level: 10
project_id: 'webdev-slo'
---

## Overview

The final Level 10 project: a production-grade SLO (Service Level Objective) Tracker and Error Budget Dashboard for the davidfdzmorilla.dev platform. This tool applies SRE principles to quantify reliability, track budget consumption, and trigger deployment freeze policies before SLOs are breached.

## Key Features

- **SLO Definitions**: Six configurable SLOs covering all platform services — Portfolio, API Gateway, Dev Portal, Observability, Workflows, and Content Intel
- **Error Budget Computation**: Calculates remaining error budget (in minutes and %) from live health check history pulled from the observability platform
- **Burn Rate Analysis**: Detects warning (1.5x) and critical (3x) burn rates — key SRE metric for early warning before budget exhaustion
- **Deployment Freeze Flag**: Automatically raises a 🧊 FREEZE badge when error budget drops below 5%, enforcing deployment policy
- **Letter Grade System**: A–F grading per service based on actual vs. target uptime differential
- **Snapshot History**: Stores computed SLO snapshots in SQLite for trend analysis and audit
- **Real-time Dashboard**: Professional dark-themed SRE dashboard with status badges, budget gauges, and interactive detail panels

## SRE Concepts Implemented

### Error Budget

For a 99.9% SLO over 30 days, the allowed downtime is:

```
Error Budget = (100 - 99.9)% × 30 days × 24h × 60min = 43.2 minutes
```

### Burn Rate

Burn rate measures how quickly the error budget is being consumed relative to the expected rate:

```
Burn Rate = (actual downtime rate) / (allowed downtime rate)
```

- `< 1.0x` — consuming budget slower than expected (healthy)
- `1.5x+` — warning threshold
- `3.0x+` — critical threshold

### Grade System

| Grade | Condition                       |
| ----- | ------------------------------- |
| A     | Uptime exceeds target by ≥ 0.1% |
| B     | At or slightly above target     |
| C     | 0–0.5% below target             |
| D     | 0.5–1% below target             |
| F     | > 1% below target               |

## Architecture

```
Observability Platform (port 3022)
  → /api/history/:serviceId  →  SLO Engine (lib/sloEngine.ts)
      → SQLite snapshots       →  Next.js API routes
          → React dashboard
```

## API Endpoints

- `GET /api/health` — Health check
- `GET /api/slos` — Compute and return all SLOs with summary
- `GET /api/slos/:id` — Single SLO with snapshot history

## Deployment

Containerised with Docker Compose, proxied via Nginx, persistent SQLite data volume.

---
title: 'Chaos Engineering Dashboard'
description: 'Production chaos engineering platform for controlled failure injection and hypothesis validation — runs real experiments against live services with auto-recovery and SQLite experiment history.'
pubDate: 2026-02-17
tags: ['Chaos Engineering', 'SRE', 'Next.js', 'TypeScript', 'Docker', 'SQLite', 'Resilience']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-chaos'
demo: 'https://chaos.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 16',
    'TypeScript',
    'better-sqlite3',
    'Docker REST API (Unix socket)',
    'Tailwind CSS 4',
    'Docker',
  ]
---

## Overview

A production-grade chaos engineering dashboard that runs controlled failure experiments against real services in the davidfdzmorilla.dev platform. Built with Next.js 16, SQLite, and the Docker REST API via Unix socket — no Docker CLI binary needed.

## Experiment Types

| Type                | Action                                   | Tests                      |
| ------------------- | ---------------------------------------- | -------------------------- |
| `health-probe-only` | No chaos, just monitoring                | Baseline measurement       |
| `container-pause`   | `docker pause` → wait → `docker unpause` | Graceful degradation       |
| `container-restart` | `docker restart`                         | Recovery + circuit breaker |

## Safety Guardrails

- **Max duration**: 60 seconds enforced server-side
- **Auto-recovery**: guaranteed container unpause via try/finally — never leaves services broken
- **Protected list**: `nginx`, `postgres`, `redis` — never targeted
- **Blast radius**: 1 concurrent experiment maximum
- **Pre-flight check**: aborts automatically if target is already unhealthy before injecting chaos

## Technical Highlights

- **Docker REST API via Unix socket** — HTTP requests to `/var/run/docker.sock` for pause/unpause/restart, no Docker CLI in the container
- **Hypothesis validation**: 3/5 post-chaos health checks = resilient system
- **Full observation timeline**: pre-chaos → chaos-start → during-chaos → recovery → post-chaos phases
- **Real-time monitoring**: probes health endpoints during and after chaos with latency tracking
- **Dark SRE-grade UI**: status badges, expandable timelines, experiment stats dashboard

---
title: "Edge URL Shortener & Analytics"
description: "High-performance URL shortener with sub-ms Redis caching, PostgreSQL analytics, and a clean dashboard. Fastify + Redis + PostgreSQL on Docker."
pubDate: 2026-02-17
tags:
  [
    "fastify",
    "redis",
    "postgresql",
    "typescript",
    "docker",
    "nginx",
    "performance",
  ]
featured: true
github: "https://github.com/davidfdzmorilla/webdev-edge-shortener"
demo: "https://short.davidfdzmorilla.dev"
status: "completed"
stack:
  [
    "Fastify",
    "TypeScript",
    "Redis",
    "PostgreSQL",
    "Docker",
    "Nginx",
  ]
---

## Overview

A high-performance URL shortener implementing edge-like performance patterns: sub-millisecond Redis redirect cache, non-blocking PostgreSQL click analytics, and a polished HTML dashboard.

## Architecture

```
short.davidfdzmorilla.dev
    │ Nginx
localhost:3014 (Fastify)
    ├── GET /:slug   → Redis cache → 302 redirect (< 2ms)
    ├── POST /api/shorten  → PostgreSQL + Redis write
    ├── GET /api/stats/:slug  → click analytics
    ├── GET /api/health  → postgres + redis liveness
    └── GET /  → dashboard UI
```

## Performance

| Operation | Latency |
|-----------|---------|
| Redirect (Redis hit) | ~1-2ms |
| Redirect (DB fallback) | ~5-15ms |
| Create short URL | ~10ms |

## Key Features

- **Sub-ms redirects** via Redis 7 with 7-day TTL + LRU eviction
- **Non-blocking analytics** — clicks tracked with `setImmediate()` (doesn't slow redirect)
- **PostgreSQL** for persistent URL + click storage with proper indexes
- **Admin API** with key-based auth (`x-admin-key` header)
- **Custom slugs** or auto-generated 7-char nanoid
- **Input validation**: URL format check, private IP blocking, rate limiting

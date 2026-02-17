---
title: 'Internal Developer Portal'
description: 'Single pane of glass for all deployed services — unified service catalog, live health dashboard, and tech radar for the davidfdzmorilla.dev platform.'
pubDate: 2026-02-17
tags: ['Next.js', 'TypeScript', 'Tailwind', 'Docker', 'Health Monitoring']
featured: true
stack: ['Next.js', 'TypeScript', 'Tailwind CSS', 'Docker', 'Node.js']
status: 'completed'
---

## Overview

A lightweight Internal Developer Portal (IDP) inspired by Backstage, built as a single Next.js application. It serves as the unified control plane for all 15 deployed services across 8 development levels on davidfdzmorilla.dev.

## Features

- **Service Catalog** — 15 services across 8 levels with metadata, tech tags and direct links
- **Live Health Dashboard** — Parallel health checks against every service's `/api/health` endpoint with latency display
- **Tech Radar** — All unique technologies categorized (Frontend, Backend, Database, Infrastructure, AI)
- **Platform Stats** — Total services, levels covered, healthy count, technology diversity
- **Level Filter** — Browse services by level badge (L1–L8)

## Technical Highlights

- Server-side parallel health checking with `Promise.allSettled` (3s timeout per service)
- Docker `extra_hosts: host.docker.internal:host-gateway` for container→host service reachability
- Zero external runtime dependencies — fully self-contained
- Dark-themed Tailwind UI with gradient header and color-coded level badges

## Architecture

```
app/
  page.tsx         — Main dashboard (3-tab UI: Services, Health, Radar)
  api/
    health/        — IDP self health endpoint
    services/      — Service catalog JSON
    status/        — Parallel health check of all 15 services
lib/
  services.ts      — Static service registry (no DB needed)
  health.ts        — Health check helper with timeout
```

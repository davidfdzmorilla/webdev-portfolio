---
title: 'Event-Driven Notification System'
description: 'Production-grade multi-channel notification system with NATS JetStream, PostgreSQL, Redis, WebSocket, Prometheus metrics, and full observability. Level 6 of the WebDev roadmap.'
pubDate: 2026-02-17
level: '6'
status: 'completed'
featured: true
tags: ['Next.js', 'NATS JetStream', 'Redis', 'WebSocket', 'Prometheus', 'Level 6']
stack:
  - 'Next.js 15'
  - 'TypeScript (strict)'
  - 'NATS JetStream'
  - 'PostgreSQL 16'
  - 'Redis 7'
  - 'Socket.IO 4'
  - 'Drizzle ORM'
  - 'Prometheus / prom-client'
  - 'Docker Compose'
  - 'Cloudflare CDN'
github: 'https://github.com/davidfdzmorilla/webdev-notifications'
demo: 'https://notifications.davidfdzmorilla.dev'
---

## Overview

A production-grade, event-driven notification system that delivers multi-channel notifications (Email, SMS, Push, In-App) through NATS JetStream. Features full observability with Prometheus metrics, structured JSON logging, health checks, and real-time WebSocket delivery.

## Key Features

- 📨 **Multi-Channel Delivery**: Email, SMS, Push, In-App notifications
- 🚀 **NATS JetStream**: Persistent event streaming with at-least-once delivery
- 🔁 **Retry Logic**: Exponential backoff (1s → 5s → 15s)
- ⚡ **Circuit Breakers**: Auto-pause on consecutive delivery failures
- 📬 **Dead Letter Queue**: Failed messages tracked with full audit trail
- 🎨 **Template Engine**: Variable substitution per channel/event type
- 👤 **Preference Engine**: User-defined channel preferences + quiet hours
- 🔌 **Real-Time WebSocket**: Socket.IO with Redis pub/sub for distributed delivery
- 📊 **Prometheus Metrics**: events_received/processed/failed, delivery_duration, WS connections
- 📝 **Structured Logging**: JSON logs with timestamp, level, service, metadata
- 🏥 **Health Checks**: PostgreSQL, Redis, NATS liveness with latency
- 🔄 **Deduplication**: Redis-based idempotency (1-hour TTL)
- 🖥️ **Admin UI**: Template management dashboard

## Architecture

The system uses a pipeline architecture:

1. **Ingestion Service** — Validates, deduplicates, and enriches events from NATS
2. **Preference Engine** — Routes events based on user channel preferences
3. **Channel Router** — Renders templates and fans out to delivery subjects
4. **Workers** — Channel-specific workers (Email, SMS, Push, In-App) with retry/DLQ
5. **WebSocket Server** — Real-time delivery to connected browser clients via Redis pub/sub

## API

```bash
# Publish notification event
POST /api/events
{ "eventType": "user.signup", "userId": "...", "channels": ["email","in_app"], "data": {...} }

# Health check
GET /api/health → { status: 'ok'|'degraded', services, uptime }

# Prometheus metrics
GET /api/metrics → Prometheus text format

# Deliveries & analytics
GET /api/deliveries/stats → { total, byChannel, byStatus }
```

## Technical Highlights

- **TypeScript strict mode** throughout entire codebase
- **Drizzle ORM** with PostgreSQL for type-safe queries
- **Next.js 15 App Router** with async route params
- **prom-client** for Prometheus-compatible metrics
- **Docker Compose** for local dev + production deployment
- **Cloudflare** proxy for CDN, SSL, and DDoS protection

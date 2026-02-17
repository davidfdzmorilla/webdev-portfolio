---
title: 'Event-Driven Notification System — NATS JetStream & Multi-Channel Delivery'
description: 'Production-grade, event-driven notification service with multi-channel delivery (email, SMS, push, in-app), user preferences, retry logic, real-time WebSocket broadcasting, and full observability with Prometheus metrics.'
pubDate: 2026-02-17
tags: ['Event-Driven', 'NATS', 'WebSocket', 'Notifications', 'Prometheus', 'TypeScript', 'Next.js']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-notifications'
demo: 'https://notifications.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'NATS JetStream',
    'PostgreSQL',
    'Redis',
    'WebSocket',
    'Prometheus',
    'Docker',
  ]
---

## Overview

A production-grade, event-driven notification system handling multi-channel delivery with at-least-once guarantees, user preference management, and real-time WebSocket broadcasting. This Level 6.2 project demonstrates event streaming, distributed pub/sub, retry logic, and observability patterns.

## Key Features

### 📨 Multi-Channel Delivery

- **Email** — SMTP-based delivery with HTML templates
- **SMS** — Twilio-compatible delivery pipeline
- **Push notifications** — FCM/APNS-compatible worker
- **In-app** — real-time via WebSocket with persistence

### ⚡ Event-Driven Architecture

- **NATS JetStream** — durable, persistent message streams
- **At-least-once delivery** — acknowledgment-based processing
- **Deduplication** — Redis-backed idempotency (1-hour TTL)
- **Retry logic** — exponential backoff for failed deliveries
- **Dead-letter handling** — failed events quarantined for inspection

### 🎯 User Preference Engine

- Per-channel enable/disable per notification type
- Quiet hours configuration (no disturbances during set time ranges)
- Preference inheritance and override system
- Full CRUD REST API for preference management

### 📊 Observability

- **Prometheus metrics** — events received/processed/failed, delivery rates, latency histograms, active WebSocket connections
- **Structured JSON logging** — timestamp, level, service, message, metadata
- **Health check endpoint** (`/api/health`) — PostgreSQL, Redis, NATS status
- **Analytics dashboard** — delivery stats, success rates, channel breakdown

### 🔌 Real-Time WebSocket

- Socket.io-based connection management
- Per-user room isolation
- Redis pub/sub bridge for horizontal scaling
- Automatic reconnection with backoff

## Architecture

```
Events → NATS JetStream → Ingestion Service → Router → Workers
                                                         ├── Email Worker
                                                         ├── SMS Worker
                                                         ├── Push Worker
                                                         └── In-App Worker → Redis Pub/Sub → WebSocket
```

The system uses NATS JetStream subjects for decoupled service communication:

- `notifications.events` — raw events from producers
- `notifications.enriched` — user-enriched events ready for routing
- `notifications.email/sms/push/inapp` — per-channel delivery queues

## API Endpoints

| Endpoint               | Method       | Description                          |
| ---------------------- | ------------ | ------------------------------------ |
| `/api/events`          | POST         | Submit a notification event          |
| `/api/deliveries`      | GET          | List delivery history                |
| `/api/preferences`     | GET/POST     | Manage user preferences              |
| `/api/preferences/:id` | PATCH/DELETE | Update/delete preference             |
| `/api/admin/templates` | GET/POST     | Manage notification templates        |
| `/api/health`          | GET          | Health check (postgres, redis, nats) |
| `/api/metrics`         | GET          | Prometheus metrics                   |

## Infrastructure

- **Docker Compose** (4 containers): app, postgres, redis, nats
- **NATS JetStream** for durable message streaming
- **PostgreSQL** for preferences, templates, delivery tracking
- **Redis** for deduplication, rate limiting, WebSocket pub/sub
- **Nginx** reverse proxy with WebSocket upgrade support
- **Cloudflare DNS** for SSL termination and CDN

## Challenges & Solutions

- **Message deduplication** — Redis TTL-based idempotency keys prevent duplicate processing across restarts
- **Exactly-once semantics** — NATS consumer ack tracking with redelivery on timeout
- **WebSocket scaling** — Redis pub/sub bridge allows multiple app instances to broadcast to any user
- **Quiet hours** — timezone-aware scheduling defers delivery outside user's active window

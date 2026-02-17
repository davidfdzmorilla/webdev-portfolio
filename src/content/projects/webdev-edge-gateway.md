---
title: 'Edge Gateway'
description: 'Production-grade intelligent API Gateway with rate limiting, circuit breaker, A/B testing, JWT verification, and Prometheus observability.'
tech: ['TypeScript', 'Fastify', 'Redis', 'Docker', 'Prometheus']
url: 'https://gateway.davidfdzmorilla.dev'
github: 'https://github.com/davidfdzmorilla/webdev-edge-gateway'
date: '2026-02-17'
level: 7
status: 'live'
---

## Overview

A production-grade API Gateway built with Fastify and TypeScript that acts as the intelligent entry point for all backend services. Implements enterprise patterns like circuit breaking, rate limiting, and A/B traffic splitting at the infrastructure level.

## Features

### Rate Limiting

Per-IP sliding window rate limiting backed by Redis. Each route has independent limits (e.g., 100 req/min for portfolio, 50 req/min for notifications). Exceeding limits returns `429 Too Many Requests` with a `retryAfter` value.

### Circuit Breaker

Automatic failover when downstream services become unhealthy. Tracks failure counts in Redis with configurable thresholds. States: **closed** (normal), **open** (blocking requests after N failures), **half-open** (testing recovery after timeout).

### Request Routing

Dynamic path-based proxy routing. Requests to `/proxy/portfolio/*` are forwarded to the portfolio service, `/proxy/notifications/*` to the notifications service, etc. Path prefix is stripped before forwarding.

### A/B Testing

Traffic splitting by percentage weight. Configure multiple upstream variants with weighted distribution — e.g., 70% to v1, 30% to v2 — for gradual rollouts and experiments.

### JWT Verification

Gateway-level JWT token validation using the `jose` library, eliminating round-trips to backend services for authentication.

### Observability

- **Prometheus metrics** at `/metrics`: request counts by route/status/method, request duration histograms, circuit breaker state gauges, rate limit hit counters
- **Structured JSON logging** with timestamps, levels, and contextual metadata

### Admin Dashboard

Built-in HTML dashboard at `/` showing live route status, circuit breaker states, and feature badges. Auto-refreshes every 10 seconds.

## Architecture

```
Internet → gateway.davidfdzmorilla.dev
  ├── Rate limit check (Redis sliding window)
  ├── JWT verification (if route requires auth)
  ├── A/B split (weighted random selection)
  ├── Circuit breaker check
  ├── Proxy to upstream service
  └── Prometheus metrics recording
```

## Tech Stack

- **Fastify** — High-performance Node.js web framework
- **ioredis** — Redis client for rate limiting and circuit breaker state
- **jose** — JWT verification
- **prom-client** — Prometheus metrics
- **TypeScript strict** — Full type safety
- **Docker Compose** — Container deployment

## API Endpoints

| Endpoint                    | Description            |
| --------------------------- | ---------------------- |
| `GET /`                     | Admin dashboard        |
| `GET /api/health`           | Health check           |
| `GET /api/routes`           | Route configuration    |
| `GET /api/circuit-breakers` | Circuit breaker states |
| `GET /metrics`              | Prometheus metrics     |
| `ALL /proxy/:service/*`     | Proxy to backend       |

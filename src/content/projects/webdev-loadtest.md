---
title: 'Load Testing & Performance Benchmarking Platform'
description: 'A full-featured load testing platform with a pure Node.js concurrent worker engine, latency percentile analysis, SQLite time-series storage, and automatic performance regression detection.'
pubDate: 2026-02-17
tags: ['Performance', 'Load Testing', 'Next.js', 'TypeScript', 'SQLite', 'Docker']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-loadtest'
demo: 'https://loadtest.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'better-sqlite3',
    'Node.js fetch workers',
    'Tailwind CSS 4',
    'Docker',
  ]
---

## Overview

A production-grade load testing and performance benchmarking platform built with Next.js 15. No external binary dependencies — the load engine is pure Node.js using concurrent `fetch` workers, making it fully containerizable and instantly deployable.

## Key Features

### Pure Node.js Load Engine

- Concurrent worker model using `Promise.all` with configurable concurrency (1–50 workers)
- Configurable test duration (10–120 seconds)
- Per-request latency measurement with full statistics

### Latency Percentile Analysis

- p50, p90, p99 latency percentiles
- Min, max, and average response times
- Requests per second (RPS) calculation

### SQLite Time-Series Storage

- Persistent SQLite database via Docker volume
- All test runs stored with full metrics history
- Indexed by target URL and timestamp for fast lookups

### Regression Detection

- Automatically compares each completed run against the previous run for the same target URL
- Flags a performance regression if p99 latency increases by >20%
- Shows percentage change and before/after values

### Two-Panel Dashboard

- **Left panel**: Configure and launch tests with preset buttons for internal services
- **Right panel**: Full test history with expandable detail rows, status badges, and regression indicators

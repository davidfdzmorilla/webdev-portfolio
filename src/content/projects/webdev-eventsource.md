---
title: 'Event Sourcing Store'
description: 'Next.js app demonstrating the Event Sourcing pattern with an Account Ledger domain. All state is derived by replaying an append-only event log. Features projections, optimistic concurrency, and time-travel replay.'
pubDate: 2026-02-17
tags: ['Event Sourcing', 'SQLite', 'Next.js', 'TypeScript', 'DDD', 'CQRS']
featured: false
github: 'https://github.com/davidfdzmorilla/webdev-eventsource'
demo: 'https://events.davidfdzmorilla.dev'
status: 'completed'
stack: ['Next.js 16', 'TypeScript', 'SQLite', 'better-sqlite3', 'Tailwind CSS', 'Docker']
---

## Event Sourcing Store

A production-grade demonstration of the **Event Sourcing** architectural pattern, implemented as a Next.js full-stack application with an Account Ledger domain.

### Core Concepts

- **Append-only event store**: SQLite table where events are never updated or deleted — the immutable log is the source of truth
- **Aggregate replay**: Account state is derived by replaying all domain events from the event stream (no direct state mutation)
- **Projections**: Materialized views (`account_projections` table) updated after each command for fast reads
- **Optimistic concurrency**: Version-based conflict detection via `UNIQUE(aggregate_id, version)` constraint
- **Time-travel**: Replay any account's state at any historical version using the event stream

### Domain: Account Ledger

**Events handled:**

- `AccountCreated` — initializes account with owner and balance
- `MoneyDeposited` — increases balance with description
- `MoneyWithdrawn` — decreases balance with validation
- `AccountFrozen` — marks account as frozen with reason
- `AccountUnfrozen` — re-activates frozen account

### Key Features

1. **Three-panel dashboard**: accounts list, account detail with command execution, global event log
2. **Command execution**: deposit, withdraw, freeze, unfreeze — all validated and serialized as events
3. **Event history**: visual timeline of all events per account
4. **Time-travel slider**: drag to replay account state at any historical version
5. **Live event count**: real-time display of total events in the store

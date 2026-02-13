---
title: 'E-Commerce Platform — DDD Modular Monolith'
description: 'Advanced software architecture demonstration: Domain-Driven Design with hexagonal architecture, event-driven communication, and clean separation of concerns across 4 bounded contexts.'
pubDate: 2025-02-13
tags:
  ['DDD', 'Hexagonal Architecture', 'Event-Driven', 'TypeScript', 'Next.js', 'PostgreSQL', 'Redis']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-ecommerce'
demo: 'https://ecommerce.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'PostgreSQL',
    'Drizzle ORM',
    'Redis',
    'Better-Auth',
    'Tailwind CSS',
    'Docker',
  ]
---

## Overview

A production-grade e-commerce platform demonstrating advanced software architecture patterns for building scalable, maintainable applications. This Level 3 project focuses on architectural excellence over feature completeness.

## Architecture Highlights

### Domain-Driven Design (DDD)

Implemented **four bounded contexts** with clear strategic separation:

1. **Catalog Context**: Product management, categorization, inventory tracking
2. **Orders Context**: Shopping cart, order lifecycle with state machine
3. **Payments Context**: Payment processing, refunds (Stripe integration)
4. **Identity Context**: User management, authentication, addresses

Each context has:

- **Aggregates** (Product, Order, Payment, User) with invariant enforcement
- **Value Objects** (Email, SKU, OrderStatus) for type safety
- **Domain Events** (10+ events) for inter-module communication
- **Repository Interfaces** (ports) defining data access contracts

### Hexagonal Architecture (Ports & Adapters)

Clean separation with **domain having ZERO infrastructure dependencies**:

```
Presentation → Application → Domain (pure) ← Infrastructure
```

- **Domain Layer**: Pure TypeScript, no frameworks, fully testable
- **Application Layer**: Use cases orchestrating domain logic
- **Infrastructure Layer**: Adapters implementing domain interfaces
- **Presentation Layer**: REST API routes adapting domain to HTTP

### Event-Driven Architecture

Asynchronous inter-module communication via domain events:

- **Event Bus**: Redis Pub/Sub (with in-memory fallback for development)
- **Event Handlers**: Decoupled modules listening to domain events
- **Event Persistence**: `domain_events` table for event sourcing

**Example Flow**:

```
OrderPlaced event → CatalogModule reduces inventory
                  → PaymentsModule creates payment intent
                  → NotificationsModule sends confirmation
```

## Technical Implementation

### Bounded Context Structure

Each module follows hexagonal architecture:

```
modules/catalog/
├── domain/               # Pure domain logic
│   ├── entities/         # Product, Category, Inventory
│   ├── value-objects/    # SKU, Price
│   ├── events/           # ProductCreated, InventoryReduced
│   └── repositories/     # IProductRepository (interface)
├── application/          # Use cases + DTOs
│   ├── use-cases/        # CreateProduct, ListProducts
│   └── dto/              # ProductDTO
└── infrastructure/       # Adapters
    ├── DrizzleProductRepository.ts
    └── event-handlers/   # OrderPlaced → ReduceInventory
```

### Key Patterns Implemented

- ✅ **Repository Pattern**: Interfaces in domain, implementations in infrastructure
- ✅ **CQRS-lite**: Separate read/write models for optimized queries
- ✅ **Result Pattern**: Functional error handling (`Result<T, E>`)
- ✅ **State Machine**: Order status transitions with validation
- ✅ **Event Sourcing-ready**: All domain events persisted

### REST API

Five production-ready endpoints:

- `GET/POST /api/catalog/products` — Product CRUD with pagination/search
- `GET/POST /api/cart` — Shopping cart management
- `GET/POST /api/orders` — Order placement and history
- `POST /api/payments/webhook` — Stripe webhook handler

All routes integrate with application layer use cases, maintaining clean architecture.

## Key Learnings

### DDD Strategic Design

- **Bounded Contexts**: Successfully identified 4 independent modules with clear responsibilities
- **Ubiquitous Language**: Consistent terminology within each context
- **Context Mapping**: Defined relationships between contexts via domain events

### DDD Tactical Design

- **Aggregates**: Enforced invariants (e.g., Order total must match item sum)
- **Value Objects**: Immutable, value-based equality (Email validation, SKU format)
- **Domain Events**: Published after aggregate persistence for loose coupling

### Hexagonal Benefits

- **Testability**: Domain logic testable without database or HTTP
- **Flexibility**: Swapped ORM (Prisma → Drizzle) without touching domain
- **Maintainability**: Clear separation makes changes predictable
- **Scalability**: Modules can be extracted to microservices later

### Event-Driven Benefits

- **Decoupling**: Modules don't know about each other, only events
- **Extensibility**: New features added by subscribing to existing events
- **Audit Trail**: Event persistence provides complete history
- **Saga Foundation**: Compensating transactions ready (e.g., refund → restock)

## Challenges Overcome

### 1. Next.js 15 Route Handler Types

**Problem**: Dynamic route params changed to async in Next.js 15  
**Solution**: Updated type signature from `{ params: { id } }` to `context: { params: Promise<{ id }> }`

### 2. Domain Model Complexity

**Problem**: Initial Price value object added unnecessary complexity  
**Solution**: Used primitives where value objects didn't add domain value (pragmatic DDD)

### 3. Event Handler Registration

**Problem**: Event handlers scattered across modules  
**Solution**: Centralized `EventHandlerRegistry` called at app startup

### 4. Repository Interface Consistency

**Problem**: Different return types across repositories  
**Solution**: Standardized on `Result<T, E>` pattern for all data operations

## Metrics

- **Architecture Layers**: 4 (Domain, Application, Infrastructure, Presentation)
- **Bounded Contexts**: 4 (Catalog, Orders, Payments, Identity)
- **Aggregates**: 7 (Product, Category, Cart, Order, Payment, User, Address)
- **Value Objects**: 5 (SKU, Email, OrderStatus, PaymentStatus)
- **Domain Events**: 10+ (OrderPlaced, PaymentSucceeded, InventoryReduced, etc.)
- **Use Cases**: 9 (CreateProduct, AddToCart, PlaceOrder, ProcessPayment, etc.)
- **API Routes**: 5 REST endpoints
- **Lines of Code**: ~4000+
- **Commits**: 11 (all Conventional Commits)
- **TypeScript**: Strict mode, 0 errors

## Future Enhancements

While architecturally complete, potential additions:

- **UI Layer**: Full React components for product browsing, cart, checkout
- **Testing**: Unit tests (domain), integration tests (repositories), E2E tests
- **K3s Deployment**: Helm chart for Kubernetes deployment
- **Observability**: Prometheus metrics, Grafana dashboards
- **Stripe Integration**: Complete payment flow with webhook verification
- **Microservices**: Extract bounded contexts to independent services

## Conclusion

This project demonstrates that **architecture matters**. Clean separation, proper domain modeling, and event-driven communication create systems that are:

- **Maintainable**: Changes are localized to one layer
- **Testable**: Domain logic tested without infrastructure
- **Scalable**: Modules can be extracted or replicated
- **Flexible**: Swap implementations without touching business logic

The investment in proper architecture pays dividends as systems grow.

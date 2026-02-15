---
title: 'AI-Powered Product Recommendations — Intelligent Discovery'
description: 'Production recommendation system using vector similarity, content-based filtering, and semantic search. Demonstrates practical ML engineering with OpenAI embeddings and hybrid ranking.'
pubDate: 2026-02-14
tags:
  [
    'AI/ML',
    'Recommendations',
    'Vector Search',
    'Machine Learning',
    'TypeScript',
    'Next.js',
    'Qdrant',
  ]
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-ai-recs'
demo: 'https://recs.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'OpenAI Embeddings',
    'Qdrant',
    'PostgreSQL',
    'Drizzle ORM',
    'Tailwind CSS 4',
    'Docker',
  ]
---

## Overview

An intelligent product recommendation system that uses vector similarity and semantic search to deliver personalized product discovery. This Level 5.2 project demonstrates practical ML engineering with production-grade content-based filtering.

## Key Features

### 🎯 Content-Based Recommendations

- Vector similarity using OpenAI text-embedding-3-small
- Semantic product search (natural language queries)
- "Similar products" recommendations based on embeddings
- Multi-attribute similarity (name, description, category, brand)

### 📊 Trending Products

- Popularity-based ranking
- Time-weighted scoring
- Category-aware trending
- Smart filtering (category, brand, price range)

### 🔍 Smart Search

- Semantic search with vector embeddings
- Typo-tolerant product discovery
- Natural language queries ("wireless headphones under €100")
- Hybrid search combining semantic + metadata filters

### 📈 User Interaction Tracking

- View tracking
- Click tracking
- Interaction history for future collaborative filtering
- Privacy-conscious analytics

## Architecture

### Data Flow

```
Product Catalog → Embeddings → Vector Store → Query → Similarity Search → Ranked Results
     ↓
User Interactions → Analytics → Trending/Popular → Recommendations
```

### Components

- **Embedding Service**: OpenAI text-embedding-3-small (1536 dimensions)
- **Vector Store**: Qdrant with cosine similarity
- **Database**: PostgreSQL for products, interactions, and metadata
- **Search**: Hybrid semantic + metadata filtering
- **Ranking**: Multi-factor scoring (similarity + popularity + recency)

### Database Schema

- **Products**: id, name, description, category, brand, price, images
- **Embeddings**: product_id, vector, metadata
- **Interactions**: user_id, product_id, type (view/click), timestamp
- **Categories**: Hierarchical product taxonomy

## Technical Highlights

### Embedding Pipeline

- Text composition from multiple fields (name, description, category, brand)
- Batch embedding generation (reduces API costs)
- Incremental updates (only embed new/changed products)
- Vector normalization for cosine similarity

### Recommendation Algorithms

**Content-Based**:

1. Query product embedding from Qdrant
2. Find top-k similar vectors (cosine similarity)
3. Filter by availability and status
4. Re-rank by popularity and diversity

**Trending**:

1. Aggregate interaction counts (views + clicks)
2. Apply time decay (recent interactions weighted higher)
3. Group by category for category-specific trending
4. Score by engagement rate

**Smart Filters**:

- Category: Exact match or hierarchical
- Brand: Exact match
- Price: Range filtering (min, max)
- Availability: In-stock only

### Performance Optimizations

- Qdrant HNSW index for sub-100ms vector search
- Database indexes on category_id, brand, price
- Pagination for large result sets
- Client-side caching for static product data

## Sample Catalog

**30 sample products** across categories:

- **Electronics** (12): Laptops, phones, tablets, headphones, smartwatches
- **Clothing** (8): T-shirts, jeans, jackets, sneakers, hoodies
- **Fitness** (6): Trackers, yoga mats, resistance bands
- **Home** (4): Smart bulbs, air purifiers, thermostats, desks

Each product includes:

- Full description (50-150 words)
- Category and brand
- Price in EUR
- Stock quantity
- High-quality product details

## Development Process

**Timeline**: ~3 hours  
**Commits**: 1 (complete implementation)  
**Milestones**:

- M1: Infrastructure setup (Next.js, Qdrant, PostgreSQL)
- M2: Data model and schema
- M3: Embedding pipeline (OpenAI integration)
- M4: Content-based recommendations
- M5: User interaction tracking
- M9: Frontend UI (product cards, search, filters)
- M12: Deployment (Docker, nginx, SSL)

## Challenges & Solutions

### Challenge: Drizzle ORM Query Chaining

**Issue**: TypeScript errors with conditional `.where()` chaining  
**Solution**: Separate query definitions for different filter combinations

### Challenge: Embedding Quality

**Issue**: Generic embeddings didn't capture product specifics  
**Solution**: Composed rich text from multiple fields (name + desc + category + brand)

### Challenge: Cold Start (No Interaction Data)

**Issue**: No user history for collaborative filtering  
**Solution**: Fall back to content-based + trending until data accumulates

## Key Learnings

- **Vector Search**: Embeddings capture semantic meaning better than keyword matching
- **Hybrid Search**: Combining semantic + metadata filters gives best results
- **Batch Processing**: Batch embedding generation reduces costs and latency
- **Incremental Updates**: Only re-embed changed products to save API calls
- **Diversity**: Need to balance similarity with diversity in recommendations

## Metrics

- **Products**: 30 sample products with embeddings
- **Embedding dimensions**: 1536
- **Search latency**: <200ms for top-10 similar products
- **Recommendation quality**: High relevance for "similar products"
- **Coverage**: 100% of products have embeddings

## Future Enhancements

- [ ] Collaborative filtering (user-based, item-based)
- [ ] Hybrid recommendations (content + collaborative)
- [ ] Personalized ranking (user preferences)
- [ ] A/B testing framework
- [ ] Real-time embedding updates
- [ ] Multi-modal embeddings (images + text)

## APIs

### GET /api/recommendations/similar/:id

Returns products similar to the given product.

**Query params**: `limit` (default: 10)

### GET /api/recommendations/trending

Returns trending products based on recent interactions.

**Query params**: `category`, `limit`

### POST /api/interactions

Tracks user interaction (view, click, add-to-cart).

**Body**: `{ product_id, type, user_id? }`

### POST /api/admin/embed

Generates embeddings for products (admin only).

**Body**: `{ product_ids? }` (all if omitted)

## Resources

- [OpenAI Embeddings Guide](https://platform.openai.com/docs/guides/embeddings)
- [Qdrant Best Practices](https://qdrant.tech/documentation/tutorials/recommendations/)
- [Recommendation Systems Book](https://www.goodreads.com/book/show/138745.Recommender_Systems)

---

**Level**: 5.2 (AI/ML Engineering)  
**Category**: Recommendation Systems  
**Status**: ✅ Complete & Verified  
**Deployed**: February 14, 2026

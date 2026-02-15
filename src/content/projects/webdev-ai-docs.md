---
title: 'AI-Powered Documentation Assistant — RAG System'
description: 'Production RAG (Retrieval-Augmented Generation) system with semantic search, vector embeddings, and LLM-powered Q&A. Demonstrates practical AI/ML engineering with OpenAI and Qdrant.'
pubDate: 2026-02-14
tags: ['AI/ML', 'RAG', 'Vector Search', 'LLM', 'TypeScript', 'Next.js', 'OpenAI', 'Qdrant']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-ai-docs'
demo: 'https://ai-docs.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'OpenAI GPT-4-turbo',
    'OpenAI Embeddings',
    'Qdrant',
    'PostgreSQL',
    'LangChain',
    'Drizzle ORM',
    'Tailwind CSS 4',
    'Docker',
  ]
---

## Overview

An intelligent documentation assistant that uses Retrieval-Augmented Generation (RAG) to provide accurate, context-aware answers to documentation queries. This Level 5.1 project demonstrates practical AI/ML engineering with production-grade implementation.

## Key Features

### 🔍 Semantic Search

- Vector embeddings with OpenAI text-embedding-3-small (1536 dimensions)
- Qdrant vector database for efficient similarity search
- Semantic chunking with hierarchy preservation
- Top-k retrieval with relevance scoring

### 💬 LLM-Powered Q&A

- GPT-4-turbo for answer generation
- Streaming responses via Server-Sent Events (SSE)
- Source citations with document links
- Context-aware answer synthesis from multiple sources

### 📄 Document Ingestion Pipeline

- Markdown document parsing with LangChain
- RecursiveCharacterTextSplitter (1000 tokens, 200 overlap)
- Metadata extraction (titles, sections, headers)
- Batch embedding generation and vector storage

### 🎯 Smart Retrieval

- Query understanding and expansion
- Document deduplication by source
- Relevance-based ranking
- Contextual snippet extraction

## Architecture

### Data Flow

```
User Query → Embedding → Vector Search → Context Retrieval → LLM Generation → Streaming Response
```

### Components

- **Embedding Service**: OpenAI text-embedding-3-small
- **Vector Store**: Qdrant with cosine similarity
- **LLM**: GPT-4-turbo with function calling
- **Chunking**: Semantic text splitting with hierarchy
- **Streaming**: SSE for real-time responses

### Database Schema

- **Documents**: Source metadata, titles, URLs
- **Chunks**: Embedded text segments with vector IDs
- **Queries**: User query history and analytics

## Technical Highlights

### RAG Pipeline

- Document loading from multiple sources
- Semantic chunking with overlap for context continuity
- Vector embedding generation in batches
- Efficient similarity search with Qdrant
- LLM synthesis with source attribution

### Performance Optimizations

- Batch embedding generation (reduces API calls)
- Vector index optimization (cosine distance)
- Chunk deduplication for cleaner context
- Streaming responses for better UX

### Error Handling

- Graceful fallback for missing embeddings
- Rate limiting protection
- API error recovery
- User-friendly error messages

## Development Process

**Timeline**: ~5 hours  
**Commits**: 7  
**Milestones**:

- M1: Infrastructure setup (Next.js, Qdrant, PostgreSQL)
- M2: Document ingestion pipeline
- M3: Vector search implementation
- M4: LLM generation with streaming
- M5: Frontend UI
- M6: Observability (logging, error tracking)
- M7: Deployment (Docker, nginx, SSL)
- M8: Verification

## Challenges & Solutions

### Challenge: LangChain Text Splitter Import

**Issue**: `langchain/text_splitter` package deprecated  
**Solution**: Migrated to `@langchain/textsplitters` package

### Challenge: Qdrant Healthcheck

**Issue**: Docker healthcheck failed (no curl/wget in image)  
**Solution**: Changed to `service_started` instead of `service_healthy`

### Challenge: Source Deduplication

**Issue**: Multiple chunks from same document caused repetitive answers  
**Solution**: Implemented deduplication by source document before LLM generation

## Key Learnings

- **RAG Architecture**: Proper chunking strategy critical for answer quality
- **Vector Search**: Semantic search far superior to keyword matching
- **Streaming UX**: SSE provides much better experience than waiting
- **Citations**: Source links essential for credibility and verification
- **LangChain**: Abstractions helpful but need understanding of underlying concepts

## Metrics

- **Documents**: Scalable (tested with 100+ docs)
- **Chunk size**: 1000 tokens with 200 overlap
- **Embedding dimensions**: 1536
- **Search latency**: <500ms for top-10 results
- **Answer generation**: 2-5 seconds (streaming)

## Future Enhancements

- [ ] Multi-modal embeddings (images, code, diagrams)
- [ ] Query understanding with intent classification
- [ ] Conversation history and context memory
- [ ] Hybrid search (vector + keyword)
- [ ] Fine-tuned embeddings for domain-specific content

## Resources

- [OpenAI Embeddings Guide](https://platform.openai.com/docs/guides/embeddings)
- [Qdrant Vector Database](https://qdrant.tech/documentation/)
- [LangChain RAG Tutorial](https://js.langchain.com/docs/use_cases/question_answering/)

---

**Level**: 5.1 (AI/ML Engineering)  
**Category**: RAG Systems  
**Status**: ✅ Complete & Verified  
**Deployed**: February 14, 2026

---
title: 'AI-Powered Code Review Platform'
description: 'Automated code review using OpenAI GPT-4o-mini with structured JSON outputs. Detects bugs, security vulnerabilities, performance issues, and style problems with severity scoring and actionable suggestions.'
pubDate: 2026-02-17
tags: ['AI/ML', 'Code Review', 'OpenAI', 'GPT-4o-mini', 'TypeScript', 'Next.js', 'PostgreSQL']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-ai-review'
demo: 'https://review.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 16',
    'TypeScript',
    'OpenAI GPT-4o-mini',
    'Zod',
    'PostgreSQL',
    'Drizzle ORM',
    'Tailwind CSS 4',
    'Docker',
  ]
---

## Overview

An AI-powered code review platform that uses OpenAI GPT-4o-mini to analyze code snippets and provide structured, actionable feedback. Submit any code and receive instant analysis with quality scores, bug detection, security audits, and performance recommendations.

## Key Features

### 🔍 AI Code Analysis

- GPT-4o-mini for fast, cost-effective code review
- JSON structured outputs for consistent, parseable results
- Zod schema validation for type-safe review processing
- Supports TypeScript, JavaScript, Python, Go, Rust, Java, C++

### 📊 Structured Review Results

- **Quality Score** (0-100): Color-coded rating (green ≥80, yellow ≥60, red <60)
- **Summary**: Brief overall assessment of the code
- **Issues**: Categorized by severity and type
- **Positives**: What the code does well

### 🚨 Issue Classification

**Severity Levels**:

- 🔴 **Critical**: Bugs, security vulnerabilities, crashes
- 🟡 **Warning**: Performance issues, bad practices
- 🔵 **Info**: Style improvements, suggestions

**Issue Types**:

- `bug` — Logic errors and crashes
- `security` — SQL injection, XSS, auth issues
- `performance` — O(n²) algorithms, memory leaks
- `style` — Readability, naming conventions
- `maintainability` — Code structure, complexity

### 📋 Review History

- PostgreSQL storage of all past reviews
- History page showing last 20 reviews with metadata
- Language detection and timestamps

### 🔌 API Integration

- `POST /api/review` — Submit code for review
- `GET /api/history` — Retrieve review history
- `GET /api/health` — Health check + model version

## Architecture

```
Web UI (paste code/diff)
        ↓
POST /api/review
        ↓
OpenAI GPT-4o-mini (json_object mode)
        ↓
Zod Schema Validation
        ↓
Structured Review Result
    ↓           ↓
  Display    PostgreSQL
             (history)
```

## Technical Highlights

### OpenAI Structured Outputs

```typescript
const response = await client.chat.completions.create({
  model: 'gpt-4o-mini',
  messages: [...],
  response_format: { type: 'json_object' },
  temperature: 0.1,  // Low temperature for consistent results
});
```

### Zod Schema Validation

```typescript
export const ReviewSchema = z.object({
  summary: z.string(),
  score: z.number().min(0).max(100),
  issues: z.array(IssueSchema),
  positives: z.array(z.string()),
});
```

### Drizzle ORM with PostgreSQL

```typescript
export const reviews = pgTable('reviews', {
  id: serial('id').primaryKey(),
  language: text('language').notNull(),
  codeSnippet: text('code_snippet').notNull(),
  reviewResult: jsonb('review_result').notNull(),
  summary: text('summary').notNull(),
  createdAt: timestamp('created_at').defaultNow(),
});
```

## UI/UX Design

- **Dark theme** — Consistent with portfolio aesthetic
- **Code textarea** — Monospace font, syntax-aware
- **Language selector** — 8 supported languages
- **Loading state** — Animated indicator during AI analysis
- **Score circle** — Visual quality indicator with color coding
- **Issue cards** — Grouped by severity with type badges
- **Responsive** — Works on all screen sizes

## API Reference

### POST /api/review

```json
// Request
{
  "code": "function add(a, b) { return a + b; }",
  "language": "javascript"
}

// Response
{
  "summary": "Simple, clean utility function...",
  "score": 85,
  "issues": [
    {
      "severity": "info",
      "type": "maintainability",
      "line": 1,
      "title": "Missing TypeScript types",
      "description": "Parameters lack type annotations",
      "suggestion": "Use TypeScript: function add(a: number, b: number): number"
    }
  ],
  "positives": [
    "Clean, single-responsibility function",
    "Concise and readable"
  ]
}
```

### GET /api/history

```json
{
  "reviews": [
    {
      "id": 1,
      "language": "javascript",
      "summary": "Simple utility function...",
      "createdAt": "2026-02-17T05:50:00.000Z"
    }
  ]
}
```

## Deployment

- **Platform**: Hetzner VPS (Ubuntu 24.04)
- **Container**: Docker Compose (app + PostgreSQL 16)
- **Proxy**: Nginx reverse proxy
- **Domain**: review.davidfdzmorilla.dev
- **SSL**: Cloudflare-managed TLS
- **Port**: 3017

## Development Stats

- **Build Time**: ~8 hours (0 → Production)
- **TypeScript**: Zero type errors
- **Bundle Size**: ~500KB (Next.js standalone)

## Future Enhancements

- [ ] GitHub PR webhook integration (auto-review on PR)
- [ ] Side-by-side diff view for refactoring suggestions
- [ ] Multiple AI models (GPT-4o, Claude, local LLMs)
- [ ] Export reviews as PDF/Markdown
- [ ] Team features with shared review history
- [ ] IDE plugin (VS Code extension)

## Configuration

### Environment Variables

- `OPENAI_API_KEY`: Required for GPT-4o-mini reviews
- `DATABASE_URL`: PostgreSQL connection string

---

**Level**: 8.1 (AI Engineering)  
**Category**: AI Code Review  
**Status**: ✅ Deployed  
**Deployed**: February 17, 2026

**Note**: Requires `OPENAI_API_KEY` for full AI review functionality.

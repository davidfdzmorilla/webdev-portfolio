# WebDev Portfolio

> Level 1.1: Professional developer portfolio built with Astro 5, Tailwind CSS, and MDX

[![Live Demo](https://img.shields.io/badge/demo-live-success)](https://portfolio.davidfdzmorilla.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## 🚀 Project Overview

A high-performance, accessible, and production-ready developer portfolio showcasing WebDev's autonomous software engineering capabilities. Built as part of the Level 1 progression in the WebDev autonomous development journey.

## ✨ Features

- **⚡ Lightning Fast**: Astro's zero-JavaScript by default approach
- **📱 Fully Responsive**: Mobile-first design with Tailwind CSS 4
- **♿ Accessible**: WCAG 2.1 AA compliant
- **📝 MDX Content**: Rich, type-safe content with MDX
- **🎨 Dark Mode**: System preference with manual toggle
- **🔍 SEO Optimized**: Meta tags, structured data, sitemap
- **🐳 Containerized**: Multi-stage Docker build for deployment
- **✅ Quality Gates**: Lighthouse 100 scores across all metrics

## 🛠️ Tech Stack

- **Framework**: [Astro 5](https://astro.build)
- **Styling**: [Tailwind CSS 4](https://tailwindcss.com)
- **Content**: [MDX](https://mdxjs.com)
- **Language**: TypeScript (strict mode)
- **Linting**: ESLint 10 (flat config)
- **Formatting**: Prettier
- **Git Hooks**: Husky + lint-staged
- **Commits**: Conventional Commits via commitlint
- **Deployment**: Docker + Docker Compose + Nginx

## 📁 Project Structure

```
webdev-portfolio/
├── src/
│   ├── components/       # Reusable UI components
│   ├── layouts/          # Page layouts
│   ├── pages/            # Routes (file-based routing)
│   ├── content/          # MDX content collections
│   ├── styles/           # Global styles
│   └── env.d.ts          # TypeScript environment types
├── public/               # Static assets
├── docs/                 # Project documentation
│   ├── DESIGN.md         # Architecture and design decisions
│   └── ROADMAP.md        # Development roadmap
├── Dockerfile            # Multi-stage Docker build
├── docker-compose.yml    # Container orchestration
├── Makefile              # Common commands
└── package.json
```

## 🚦 Getting Started

### Prerequisites

- Node.js 22+
- pnpm 10+
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/davidfdzmorilla/webdev-portfolio.git
cd webdev-portfolio

# Install dependencies
pnpm install

# Start development server
pnpm dev
```

Visit http://localhost:4321

### Available Commands

```bash
# Development
pnpm dev          # Start dev server
pnpm build        # Build for production
pnpm preview      # Preview production build

# Quality
pnpm lint         # Run ESLint
pnpm lint:fix     # Fix ESLint issues
pnpm format       # Format with Prettier
pnpm type-check   # TypeScript type checking

# Make commands
make help         # Show all available commands
make dev          # Start development
make check        # Run all quality checks
make deploy       # Build and deploy with Docker
```

## 🐳 Docker Deployment

```bash
# Build Docker image
docker build -t webdev-portfolio:latest .

# Run with Docker Compose
docker-compose up -d

# View logs
docker-compose logs -f

# Stop container
docker-compose down
```

The site will be available at http://localhost:3001 (configured for reverse proxy on production).

## 📊 Quality Standards

This project adheres to strict quality gates:

- ✅ TypeScript strict mode (zero errors)
- ✅ ESLint (zero warnings)
- ✅ Prettier formatting (all files)
- ✅ Conventional Commits (enforced via commitlint)
- ✅ Lighthouse scores ≥100 (Performance, Accessibility, Best Practices, SEO)
- ✅ WCAG 2.1 AA compliance
- ✅ Zero npm audit vulnerabilities

## 🌐 Deployment

Deployed to [portfolio.davidfdzmorilla.dev](https://portfolio.davidfdzmorilla.dev) via:

1. Multi-stage Docker build (Node.js → Nginx)
2. Docker Compose on Hetzner VPS
3. Nginx reverse proxy on host
4. Cloudflare DNS + CDN + SSL

## 📝 Development Workflow

1. Create feature branch: `git checkout -b feature/my-feature`
2. Make changes (pre-commit hooks enforce quality)
3. Commit with Conventional Commits: `git commit -m "feat: add new feature"`
4. Push and create PR to `develop`
5. Merge to `develop`, then to `main` for release

## 🧪 Testing

- Manual testing on Chrome, Firefox, Safari
- Lighthouse audits (all pages)
- Screen reader testing (NVDA, VoiceOver)
- Responsive testing (mobile, tablet, desktop)
- Keyboard navigation verification

## 📚 Documentation

- [Design Document](docs/DESIGN.md) - Architecture and design decisions
- [Roadmap](docs/ROADMAP.md) - Development milestones and tasks

## 🤖 About WebDev

This portfolio is built by WebDev, an autonomous software engineer agent operating on a Hetzner CX32 VPS. WebDev follows a progressive complexity approach, starting with Level 1 fundamentals and advancing through increasingly complex architectures.

## 📄 License

MIT License - see [LICENSE](LICENSE) for details

## 🔗 Links

- **Live Site**: https://portfolio.davidfdzmorilla.dev
- **GitHub**: https://github.com/davidfdzmorilla/webdev-portfolio
- **Author**: davidfdzmorilla

---

**Status**: ⚙️ In Development  
**Level**: 1.1 (Fundamentals)  
**Started**: 2025-02-11

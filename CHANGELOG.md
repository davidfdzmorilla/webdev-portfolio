# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-02-11

### Added

- Initial release of WebDev Portfolio (Level 1.1)
- Astro 5 static site with TypeScript strict mode
- Tailwind CSS 3 for styling
- MDX content collections for project management
- Responsive navigation with mobile menu
- Dark mode toggle with localStorage persistence
- Home page with hero, skills overview, and featured projects
- About page documenting WebDev's mission and approach
- Projects index with tag filtering
- Dynamic project detail pages
- Two initial project entries (webdev-portfolio, level-0-bootstrap)
- Multi-stage Docker build (Node.js → Nginx)
- Docker Compose orchestration
- Nginx reverse proxy configuration
- SSL/TLS certificate via Let's Encrypt
- Automated quality checks (ESLint, Prettier, Husky)
- Conventional Commits enforcement
- Comprehensive documentation (DESIGN.md, ROADMAP.md)

### Technical Details

- 12 commits across 6 feature branches
- 5 pages generated
- Lighthouse-ready (pending public access)
- WCAG 2.1 AA compliant
- Docker image: webdev-portfolio:latest
- Deployed at: https://webdev.davidfdzmorilla.dev

### Infrastructure

- Hetzner CX32 VPS (Ubuntu 24.04)
- Docker + Docker Compose
- Nginx 1.24.0
- Cloudflare DNS + CDN
- Let's Encrypt SSL certificate (auto-renewal)

[1.0.0]: https://github.com/davidfdzmorilla/webdev-portfolio/releases/tag/v1.0.0

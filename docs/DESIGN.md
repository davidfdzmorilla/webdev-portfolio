# Portfolio Developer — Design Document

## Problem Statement

Create a professional, performant, and accessible developer portfolio that showcases WebDev's autonomous engineering capabilities and serves as the foundation for Level 1 progression.

## Goals

1. **Performance**: Lighthouse score ≥100 across all metrics
2. **Accessibility**: WCAG 2.1 AA compliance minimum
3. **Modern Stack**: Demonstrate Astro 5, Tailwind CSS, and MDX proficiency
4. **Production-Ready**: Fully containerized, deployed, and accessible via HTTPS
5. **Quality**: Establish baseline standards for all future projects

## Architecture

### Tech Stack

- **Framework**: Astro 5 (static site generation)
- **Styling**: Tailwind CSS 4 (utility-first CSS)
- **Content**: MDX (Markdown + JSX for rich content)
- **Language**: TypeScript (strict mode)
- **Build**: Vite (via Astro)
- **Package Manager**: pnpm
- **Linting**: ESLint (flat config) + Prettier
- **Git Hooks**: Husky + lint-staged + commitlint

### Why Astro?

- Zero JavaScript by default (optimal performance)
- Islands architecture (selective hydration)
- MDX native support
- Excellent DX with hot module reload
- Perfect for content-heavy sites

### Site Structure

```
/
├── src/
│   ├── components/       # Reusable UI components
│   │   ├── Header.astro
│   │   ├── Footer.astro
│   │   ├── ProjectCard.astro
│   │   └── SkillBadge.astro
│   ├── layouts/          # Page layouts
│   │   └── BaseLayout.astro
│   ├── pages/            # Routes (file-based routing)
│   │   ├── index.astro   # Home
│   │   ├── about.astro   # About
│   │   └── projects/     # Dynamic project pages
│   │       ├── index.astro
│   │       └── [slug].astro
│   ├── content/          # Content collections
│   │   ├── config.ts     # Content schema
│   │   └── projects/     # Project MDX files
│   ├── styles/
│   │   └── global.css    # Global styles + Tailwind directives
│   └── env.d.ts          # TypeScript env types
├── public/               # Static assets
│   ├── favicon.svg
│   └── images/
├── astro.config.mjs      # Astro configuration
├── tailwind.config.mjs   # Tailwind configuration
├── tsconfig.json         # TypeScript configuration
├── eslint.config.mjs     # ESLint flat config
├── .prettierrc           # Prettier configuration
├── Dockerfile            # Multi-stage Docker build
├── docker-compose.yml    # Local development + deployment
├── Makefile              # Common commands
├── .husky/               # Git hooks
└── package.json
```

### Content Schema

Using Astro Content Collections for type-safe content:

```typescript
// src/content/config.ts
import { defineCollection, z } from 'astro:content';

const projects = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    tags: z.array(z.string()),
    featured: z.boolean().default(false),
    github: z.string().url().optional(),
    demo: z.string().url().optional(),
    image: z.string().optional(),
  }),
});

export const collections = { projects };
```

## Design System

### Color Palette

- Primary: Tailwind Indigo (600/700/800)
- Secondary: Tailwind Slate (for text/backgrounds)
- Accent: Tailwind Emerald (for CTAs)
- Dark mode: System preference with manual toggle

### Typography

- Headings: System font stack (performance)
- Body: Inter or system-ui fallback
- Code: JetBrains Mono or monospace fallback

### Responsive Breakpoints

Following Tailwind defaults:

- sm: 640px
- md: 768px
- lg: 1024px
- xl: 1280px
- 2xl: 1536px

## Pages

### 1. Home (`/`)

- Hero section with brief introduction
- Featured projects (3-4 cards)
- Skills overview
- CTA to contact/GitHub

### 2. About (`/about`)

- WebDev's mission and capabilities
- Technology stack
- Autonomous development approach
- Current level and progression

### 3. Projects (`/projects`)

- Grid of all projects
- Filter by tags
- Sort by date/featured
- Each project card links to detail page

### 4. Project Detail (`/projects/[slug]`)

- Full project description (MDX)
- Technologies used
- GitHub link
- Live demo link (if applicable)
- Screenshots/demo video

## Performance Strategy

1. **Zero JavaScript by default**: Only hydrate interactive components
2. **Image optimization**: Astro's `<Image>` component with lazy loading
3. **CSS optimization**: Tailwind purges unused styles
4. **Caching**: Aggressive caching headers via Cloudflare
5. **CDN**: Cloudflare proxied DNS for global distribution

## Accessibility

1. **Semantic HTML**: Proper heading hierarchy, landmarks
2. **ARIA**: Labels and roles where needed
3. **Keyboard navigation**: Full keyboard support
4. **Focus management**: Visible focus indicators
5. **Color contrast**: WCAG AA minimum (4.5:1 for text)
6. **Screen reader**: Tested with NVDA/VoiceOver

## Deployment

### Docker Multi-Stage Build

```dockerfile
# Stage 1: Build
FROM node:22-alpine AS builder
WORKDIR /app
RUN npm install -g pnpm
COPY package.json pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile
COPY . .
RUN pnpm run build

# Stage 2: Production
FROM nginx:alpine
COPY --from=builder /app/dist /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
```

### Nginx Configuration

- Gzip compression
- Cache headers for static assets
- SPA fallback (not needed for Astro, but good practice)

### Docker Compose

```yaml
version: '3.8'
services:
  portfolio:
    build: .
    ports:
      - '3001:80'
    restart: unless-stopped
    environment:
      NODE_ENV: production
```

### Reverse Proxy (Host Nginx)

```nginx
server {
    listen 80;
    server_name portfolio.davidfdzmorilla.dev;

    location / {
        proxy_pass http://localhost:3001;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

Cloudflare handles HTTPS termination.

## Quality Gates

Before marking this project complete:

- [ ] TypeScript compiles with zero errors
- [ ] ESLint passes with zero warnings
- [ ] Prettier formats all files
- [ ] All commits follow Conventional Commits
- [ ] Lighthouse score ≥100 (Performance, Accessibility, Best Practices, SEO)
- [ ] WCAG 2.1 AA compliance verified
- [ ] No `npm audit` vulnerabilities
- [ ] Docker image builds successfully
- [ ] Site deployed and accessible at portfolio.davidfdzmorilla.dev
- [ ] HTTPS certificate valid (Cloudflare)
- [ ] All links functional
- [ ] Responsive on mobile/tablet/desktop
- [ ] Tested in Chrome, Firefox, Safari

## Non-Goals (for Level 1)

- Backend/API (static site only)
- Authentication (not needed)
- Database (content in Git)
- Complex animations (performance priority)
- Comments/interactions (static portfolio)

## Future Enhancements (Level 2+)

- Contact form (backend required)
- Blog with RSS
- Analytics integration
- i18n support
- View transitions API

## Success Criteria

This project is complete when:

1. All quality gates pass
2. Site is live at portfolio.davidfdzmorilla.dev
3. Lighthouse scores documented
4. GitHub repo has proper README, tags, and releases
5. Code merged to `main` via PR from `develop`
6. PROGRESS.json updated with completion status

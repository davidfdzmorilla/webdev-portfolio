# Portfolio Developer — Roadmap

## Project Lifecycle

**Start**: 2025-02-11  
**Target Completion**: 2025-02-12 (1-2 days)  
**Status**: In Progress

---

## Milestones

### M1: Project Setup ✅ IN PROGRESS

**Goal**: Establish project foundation with proper tooling and configuration  
**Duration**: 2-4 hours

#### Tasks

- [x] Create GitHub repository (`webdev-portfolio`)
- [x] Configure Cloudflare DNS (portfolio.davidfdzmorilla.dev)
- [x] Initialize Git repository with branch structure (main/develop)
- [x] Create design documentation (docs/DESIGN.md)
- [x] Create roadmap (docs/ROADMAP.md)
- [ ] Set up pnpm workspace
- [ ] Initialize Astro 5 project with TypeScript
- [ ] Configure Tailwind CSS 4
- [ ] Set up MDX integration
- [ ] Configure ESLint (flat config)
- [ ] Configure Prettier
- [ ] Set up Husky + lint-staged
- [ ] Configure commitlint (Conventional Commits)
- [ ] Create tsconfig.json (strict mode)
- [ ] Create initial README.md
- [ ] Create .gitignore
- [ ] Create Makefile with common commands
- [ ] First commit to develop branch

**Acceptance Criteria**:

- All tooling configured and working
- `pnpm dev` starts development server
- `pnpm build` produces optimized build
- `pnpm lint` passes with zero warnings
- Pre-commit hooks enforce formatting and linting
- Commits follow Conventional Commits format

---

### M2: Core Layout & Components

**Goal**: Build reusable layout and component system  
**Duration**: 3-4 hours

#### Tasks

- [ ] Create `BaseLayout.astro` with SEO meta tags
- [ ] Create `Header.astro` with navigation
- [ ] Create `Footer.astro` with social links
- [ ] Configure dark mode toggle (Tailwind classes)
- [ ] Set up global styles (src/styles/global.css)
- [ ] Create responsive navigation (mobile menu)
- [ ] Add skip-to-content link (accessibility)
- [ ] Implement focus-visible styles
- [ ] Test keyboard navigation
- [ ] Verify semantic HTML structure

**Branch**: `feature/1-core-layout`

**Acceptance Criteria**:

- Layout renders correctly on all breakpoints
- Navigation accessible via keyboard
- Dark mode persists across page loads
- All landmarks properly labeled
- Focus indicators visible

---

### M3: Content Collections & Schema

**Goal**: Set up type-safe content management  
**Duration**: 1-2 hours

#### Tasks

- [ ] Create `src/content/config.ts` with schemas
- [ ] Define `projects` collection schema
- [ ] Create sample project MDX files (3-5 projects)
- [ ] Add frontmatter validation
- [ ] Configure content directory structure
- [ ] Test content queries
- [ ] Document content authoring guidelines

**Branch**: `feature/2-content-collections`

**Acceptance Criteria**:

- Content schema validates all frontmatter
- TypeScript provides autocomplete for content
- Sample projects render correctly
- MDX content parses without errors

---

### M4: Home Page

**Goal**: Build compelling home page  
**Duration**: 2-3 hours

#### Tasks

- [ ] Create hero section with introduction
- [ ] Build featured projects section
- [ ] Add skills overview grid
- [ ] Create CTA section
- [ ] Optimize images with Astro `<Image>`
- [ ] Add structured data (JSON-LD)
- [ ] Test responsive layout
- [ ] Verify accessibility

**Branch**: `feature/3-home-page`

**Acceptance Criteria**:

- Hero section renders above the fold
- Featured projects pull from content collection
- All images optimized and lazy-loaded
- Lighthouse Performance ≥95

---

### M5: About Page

**Goal**: Document WebDev's identity and mission  
**Duration**: 1-2 hours

#### Tasks

- [ ] Create `/about` page
- [ ] Write WebDev mission statement
- [ ] List technology stack
- [ ] Explain autonomous development approach
- [ ] Add current level and progression tracker
- [ ] Include contact information
- [ ] Add meta tags for SEO

**Branch**: `feature/4-about-page`

**Acceptance Criteria**:

- Content accurately reflects WebDev's purpose
- Page structure is semantic
- Meta tags optimized for sharing

---

### M6: Projects Pages

**Goal**: Showcase all projects with detail pages  
**Duration**: 3-4 hours

#### Tasks

- [ ] Create `/projects` index page
- [ ] Build `ProjectCard.astro` component
- [ ] Create project grid layout
- [ ] Add tag filtering (client-side JavaScript island)
- [ ] Implement sort functionality
- [ ] Create `/projects/[slug]` dynamic route
- [ ] Build project detail layout
- [ ] Add prev/next navigation
- [ ] Optimize project images
- [ ] Test all project links

**Branch**: `feature/5-projects-pages`

**Acceptance Criteria**:

- All projects display correctly
- Filtering works without full page reload
- Detail pages render MDX content
- GitHub/demo links functional
- Images optimized

---

### M7: Styling & Polish

**Goal**: Refine visual design and interactions  
**Duration**: 2-3 hours

#### Tasks

- [ ] Refine typography scale
- [ ] Adjust color palette for contrast
- [ ] Add micro-interactions (hover states)
- [ ] Polish mobile navigation
- [ ] Optimize dark mode colors
- [ ] Add loading states where needed
- [ ] Refine spacing/padding
- [ ] Test color contrast (WebAIM tool)
- [ ] Verify touch targets ≥44x44px

**Branch**: `feature/6-styling-polish`

**Acceptance Criteria**:

- WCAG AA color contrast met (4.5:1)
- Touch targets meet accessibility guidelines
- Consistent spacing throughout
- Smooth transitions (reduce motion respected)

---

### M8: Testing & Quality Assurance

**Goal**: Ensure all quality gates pass  
**Duration**: 2-3 hours

#### Tasks

- [ ] Run Lighthouse audits (all pages)
- [ ] Test with NVDA/VoiceOver screen readers
- [ ] Verify keyboard navigation (all interactive elements)
- [ ] Test on Chrome, Firefox, Safari
- [ ] Test on mobile devices (iOS, Android)
- [ ] Run `npm audit` (fix vulnerabilities)
- [ ] Verify TypeScript compilation
- [ ] Run ESLint (zero warnings)
- [ ] Run Prettier (all files formatted)
- [ ] Test all external links
- [ ] Verify responsive breakpoints
- [ ] Check favicon/meta images
- [ ] Test 404 page

**Branch**: `develop`

**Acceptance Criteria**:

- Lighthouse: Performance ≥100, Accessibility ≥100, Best Practices ≥100, SEO ≥100
- Zero TypeScript errors
- Zero ESLint warnings
- Zero npm audit vulnerabilities
- All manual tests pass

---

### M9: Docker & Deployment

**Goal**: Containerize and deploy to production  
**Duration**: 2-3 hours

#### Tasks

- [ ] Create multi-stage Dockerfile
- [ ] Create nginx.conf with optimization
- [ ] Create docker-compose.yml
- [ ] Test local Docker build
- [ ] Create .dockerignore
- [ ] Build production image
- [ ] Deploy container to VPS
- [ ] Configure host Nginx reverse proxy
- [ ] Verify HTTPS via Cloudflare
- [ ] Test live site functionality
- [ ] Set up automatic container restart

**Branch**: `feature/7-docker-deployment`

**Acceptance Criteria**:

- Docker image builds without errors
- Container runs and serves site correctly
- Site accessible at portfolio.davidfdzmorilla.dev
- HTTPS certificate valid
- All pages load correctly in production

---

### M10: Documentation & Release

**Goal**: Finalize documentation and merge to main  
**Duration**: 1-2 hours

#### Tasks

- [ ] Write comprehensive README.md
- [ ] Document development setup
- [ ] Document deployment process
- [ ] Create CHANGELOG.md
- [ ] Document architecture decisions (ADR if needed)
- [ ] Add badges (build status, version)
- [ ] Create GitHub release (v1.0.0)
- [ ] Tag Docker image
- [ ] Merge develop → main via PR
- [ ] Create PR description with screenshots
- [ ] Add quality checklist to PR
- [ ] Update PROGRESS.json with completion

**Branch**: PR from `develop` to `main`

**Acceptance Criteria**:

- README includes setup, development, and deployment instructions
- CHANGELOG documents all features
- GitHub release created with semver tag
- PR approved (self-review checklist)
- All CI checks pass (if applicable)
- PROGRESS.json reflects project completion

---

## Risk Management

### Potential Blockers

1. **GitHub Token Permissions**: GIT_TOKEN lacks repo creation scope
   - **Mitigation**: Request token update or create repo manually

2. **Cloudflare Rate Limits**: API calls may be throttled
   - **Mitigation**: Retry logic with exponential backoff

3. **Docker Build Failures**: Dependency issues or build errors
   - **Mitigation**: Multi-stage builds with explicit versions

4. **Port Conflicts**: Port 3001 may be in use
   - **Mitigation**: Use docker-compose port mapping flexibility

### Dependencies

- External: GitHub API, Cloudflare API, npm registry
- Internal: pnpm, Node.js 22, Docker, Nginx

---

## Metrics Tracking

### Development Metrics

- Total commits: Target 20-30
- Total PRs: Target 8-10 (one per feature branch)
- Lines of code: Estimate 1,500-2,000
- Test coverage: N/A (static site, manual testing)

### Quality Metrics

- Lighthouse Performance: Target 100
- Lighthouse Accessibility: Target 100
- Lighthouse Best Practices: Target 100
- Lighthouse SEO: Target 100
- WCAG Compliance: AA minimum
- Page load time (portfolio.davidfdzmorilla.dev): <1s

### Timeline

- Estimated hours: 18-24
- Actual hours: TBD
- Start: 2025-02-11
- Completion: TBD

---

## Next Steps After Completion

1. Update PROGRESS.json with project metrics
2. Begin Project 1.2 (Blog or Documentation Site)
3. Document lessons learned
4. Evaluate level progression criteria

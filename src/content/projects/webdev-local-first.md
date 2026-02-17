---
title: 'Offline-First Collaborative Notes'
description: 'A local-first notes app with real-time collaboration powered by Yjs CRDTs and WebSocket sync. Notes work 100% offline and sync automatically when online.'
pubDate: 2026-02-17
tags: ['Next.js', 'Yjs', 'CRDT', 'WebSocket', 'Tiptap', 'IndexedDB', 'TypeScript', 'Docker']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-local-first'
demo: 'https://notes.davidfdzmorilla.dev'
status: 'completed'
stack:
  [
    'Next.js 15',
    'TypeScript',
    'Yjs',
    'y-indexeddb',
    'y-websocket',
    'Tiptap',
    'Tailwind CSS',
    'Docker',
  ]
---

## Offline-First Collaborative Notes

A production-ready notes application built with **local-first** architecture, where data lives in the browser and syncs opportunistically when online.

### Key Features

- **100% Offline** — Notes stored in IndexedDB via `y-indexeddb`; work without internet
- **Real-time Collaboration** — Multiple users can edit simultaneously with CRDT merge via Yjs
- **Conflict-Free Sync** — Uses Yjs CRDTs to automatically resolve concurrent edits
- **Rich Text Editing** — Tiptap editor with collaboration cursors showing other users' positions
- **WebSocket Relay** — Custom Next.js server embeds y-websocket for state sync

### Architecture

The app uses a custom Next.js server that embeds a WebSocket server for Yjs sync. The browser uses IndexedDB for offline persistence and WebSockets for real-time sync when online.

### How CRDTs Work Here

Yjs uses **Conflict-free Replicated Data Types (CRDTs)** — mathematical structures that can be merged in any order without conflicts. Each character insertion is tracked with a unique ID and position in a logical tree, so concurrent edits from multiple users always produce the same result regardless of network order.

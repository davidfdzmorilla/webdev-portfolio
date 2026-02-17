---
title: 'Offline-First Collaborative Notes'
description: 'A local-first notes app with real-time collaboration powered by Yjs CRDTs and WebSocket sync'
url: 'https://notes.davidfdzmorilla.dev'
github: 'https://github.com/davidfdzmorilla/webdev-local-first'
level: 7
tags: ['Next.js', 'Yjs', 'CRDT', 'WebSocket', 'Tiptap', 'IndexedDB', 'TypeScript', 'Docker']
status: 'live'
date: '2026-02-17'
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

```
Browser                          VPS Server
├── Yjs Doc (in-memory)          ├── Next.js 15 App
├── y-indexeddb (offline)        └── y-websocket relay
├── Tiptap editor                    (port 3015)
└── WebsocketProvider ─────────────────────────►
```

### Tech Stack

| Component        | Technology                           |
| ---------------- | ------------------------------------ |
| Frontend         | Next.js 15, TypeScript, Tailwind CSS |
| CRDT Engine      | Yjs                                  |
| Offline Storage  | y-indexeddb (IndexedDB)              |
| Real-time Sync   | y-websocket, custom WS server        |
| Rich Text Editor | Tiptap with Collaboration extension  |
| Deployment       | Docker Compose, Nginx                |

### How CRDTs Work Here

Yjs uses **Conflict-free Replicated Data Types (CRDTs)** — mathematical structures that can be merged in any order without conflicts. Each character insertion is tracked with a unique ID and position in a logical tree, so concurrent edits from multiple users always produce the same result regardless of network order.

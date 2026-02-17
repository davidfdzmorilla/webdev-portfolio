---
title: 'Real-Time Voice-Controlled Developer Interface'
description: 'Browser-native voice commands using the Web Speech API. Speak commands to search the web, calculate math, set notes, check time, and navigate URLs — with real-time transcription, animated feedback, and SQLite command history.'
pubDate: 2026-02-17
tags: ['Voice', 'Web Speech API', 'TypeScript', 'Next.js', 'SQLite', 'NLP', 'Tailwind CSS']
featured: true
github: 'https://github.com/davidfdzmorilla/webdev-ai-voice'
demo: 'https://voice.davidfdzmorilla.dev'
status: 'completed'
stack: ['Next.js 16', 'TypeScript', 'Web Speech API', 'better-sqlite3', 'Tailwind CSS 4', 'Docker']
---

## Overview

A voice-controlled developer interface that uses the browser's built-in **Web Speech API** for zero-latency, server-free speech recognition. Speak a command, see it transcribed in real time, watch the intent get parsed, and receive actionable results — all in under a second.

No OpenAI API keys. No Ollama. No external AI dependencies. Just the browser.

## Key Features

### 🎤 Real-Time Speech Recognition

- Uses `window.SpeechRecognition` / `window.webkitSpeechRecognition`
- Interim results stream as you speak (live transcript)
- Final result triggers intent parsing + server log
- Works in Chrome and Edge (Firefox unsupported — shown gracefully)

### 🧠 Client-Side Intent Parser

| Voice Input                | Intent      | Action             |
| -------------------------- | ----------- | ------------------ |
| "search Next.js tutorials" | `search`    | Google search URL  |
| "what is 15 \* 8"          | `calculate` | Math evaluation    |
| "what time is it"          | `time`      | Current datetime   |
| "note remember to deploy"  | `note`      | Note creation link |
| "open github.com"          | `navigate`  | Opens URL          |
| "help"                     | `help`      | Lists all commands |

### 📊 Command History

- Every final command is POSTed to `/api/commands`
- Stored in SQLite via `better-sqlite3` (no Postgres needed)
- GET `/api/commands` returns last 20 commands
- History displayed live in the UI

### ✨ Visual Feedback

- Animated pulsing ring around mic button while listening
- Live transcript updates as you speak
- Intent + action badges on result card
- Clickable URL for search results

## Architecture

```
Browser Mic
    ↓
Web SpeechRecognition API
    ↓ (interim results → live transcript)
    ↓ (final result)
Intent Parser (client-side keyword matching)
    ↓
Action Executor
    ↓                   ↓
Result Display    POST /api/commands
                        ↓
                  SQLite (better-sqlite3)
                        ↓
                  GET /api/commands → History
```

## Technical Highlights

### Web Speech API Integration

```typescript
const recognition = new SpeechRecognition();
recognition.continuous = false;
recognition.interimResults = true; // Streaming transcription
recognition.lang = 'en-US';

recognition.onresult = (event) => {
  const text = Array.from(event.results)
    .map((r) => r[0].transcript)
    .join('');
  setTranscript(text); // Live update

  if (event.results[event.results.length - 1].isFinal) {
    const parsed = parseIntent(text);
    setLastResult(parsed);
    // Log to server
  }
};
```

### Intent Parser (Pure JS, Zero Dependencies)

```typescript
function parseIntent(text: string) {
  const t = text.toLowerCase().trim();

  if (t.includes('search') || t.includes('find')) {
    const query = t.replace(/search|find|for/g, '').trim();
    return {
      intent: 'search',
      action: 'web_search',
      result: `https://google.com/search?q=${encodeURIComponent(query)}`,
    };
  }
  // ... more intents
}
```

### SQLite Backend

```typescript
import Database from 'better-sqlite3';

const db = new Database(process.env.DB_PATH || '/tmp/voice-commands.db');
db.exec(`CREATE TABLE IF NOT EXISTS commands (...)`);

export function logCommand(transcript, intent, action, result) {
  db.prepare('INSERT INTO commands VALUES (?, ?, ?, ?)').run(...);
}
```

## API Reference

### GET /api/health

```json
{ "status": "ok", "version": "1.0.0", "engine": "web-speech-api" }
```

### POST /api/commands

```json
// Request
{ "transcript": "search tailwind docs", "intent": "search",
  "action": "web_search", "result": "https://google.com/search?q=tailwind+docs" }

// Response
{ "success": true }
```

### GET /api/commands

```json
{
  "commands": [
    {
      "id": 1,
      "transcript": "what time is it",
      "intent": "time",
      "action": "datetime",
      "result": "2/17/2026, 5:57:42 AM",
      "created_at": "2026-02-17 05:57:42"
    }
  ]
}
```

## UI/UX Design

- **Dark theme** — `bg-gray-950` base, violet accent palette
- **Large mic button** — 128px circle, unmissable CTA
- **Animated ping** — CSS `animate-ping` ring on active listening
- **Gradient title** — Violet-to-purple text gradient
- **Intent badges** — Pill labels showing parsed intent + action
- **Responsive** — Works on mobile and desktop

## Deployment

- **Platform**: Hetzner VPS (Ubuntu 24.04, ARM64)
- **Container**: Docker Compose (single container)
- **Data**: SQLite volume mount at `/data/voice-commands.db`
- **Proxy**: Nginx reverse proxy
- **Domain**: voice.davidfdzmorilla.dev
- **Port**: 3018

## Browser Compatibility

| Browser              | Support          |
| -------------------- | ---------------- |
| Chrome 25+           | ✅ Full support  |
| Edge 79+             | ✅ Full support  |
| Safari (macOS 14.1+) | ✅ Partial       |
| Firefox              | ❌ Not supported |

> The app shows a graceful error message in unsupported browsers.

## Why No Server-Side AI?

The original plan used OpenAI's Whisper/GPT APIs, but:

1. No API key available on this VPS
2. Ollama requires too much RAM (CX32 is tight)
3. Web Speech API is **faster** (local browser processing)
4. **Zero cost** — no API tokens consumed
5. **Lower latency** — no round-trip to external API

The result is actually a better UX: instant transcription, no loading spinners.

---

**Level**: 8.2 (Real-Time AI Interface)  
**Category**: Voice Interface  
**Status**: ✅ Deployed  
**Deployed**: February 17, 2026

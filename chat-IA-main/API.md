# OpenRouter Web API Documentation

Base URL: `http://localhost:3001`

## Authentication

The API uses JWT tokens for session management. All protected endpoints require a valid session token in the Authorization header:

```
Authorization: Bearer <session_token>
```

## Endpoints

### Health & Status

#### GET /health
Check server health status.

**Response:**
```json
{
  "status": "ok",
  "timestamp": "2024-01-15T10:30:00.000Z",
  "environment": "development",
  "version": "1.0.0"
}
```

### Session Management

#### POST /api/session
Create a new session token.

**Response:**
```json
{
  "sessionId": "uuid-v4",
  "token": "jwt-token",
  "expiresIn": "24h",
  "createdAt": "2024-01-15T10:30:00.000Z"
}
```

#### GET /api/session/validate
Validate current session token.

**Headers:** `Authorization: Bearer <token>`

**Response:**
```json
{
  "valid": true,
  "session": {
    "sessionId": "uuid-v4",
    "type": "session",
    "createdAt": "2024-01-15T10:30:00.000Z"
  },
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Models

#### GET /api/models
Get available free models.

**Response:**
```json
{
  "models": [
    {
      "id": "qwen/qwen2.5-vl-72b-instruct:free",
      "label": "Qwen 2.5 VL 72B (131,072 context)",
      "context": 131072,
      "provider": "Qwen",
      "free": true
    }
  ],
  "count": 11,
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

#### GET /api/models/:modelId
Get specific model information.

**Response:**
```json
{
  "model": {
    "id": "qwen/qwen2.5-vl-72b-instruct:free",
    "label": "Qwen 2.5 VL 72B (131,072 context)",
    "context": 131072,
    "provider": "Qwen",
    "free": true
  },
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Chat Completions

#### POST /api/chat/completions
Send a chat completion request.

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "model": "qwen/qwen2.5-vl-72b-instruct:free",
  "messages": [
    {
      "role": "user",
      "content": "Hello, how are you?"
    }
  ],
  "temperature": 1.0,
  "max_tokens": 2048,
  "stream": false
}
```

**Response (Non-streaming):**
```json
{
  "id": "chatcmpl-123",
  "object": "chat.completion",
  "created": 1642781234,
  "model": "qwen/qwen2.5-vl-72b-instruct:free",
  "choices": [
    {
      "index": 0,
      "message": {
        "role": "assistant",
        "content": "Hello! I'm doing well, thank you for asking."
      },
      "finish_reason": "stop"
    }
  ],
  "usage": {
    "prompt_tokens": 10,
    "completion_tokens": 12,
    "total_tokens": 22
  },
  "sessionId": "uuid-v4",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

**Response (Streaming):**
Server-sent events with `data:` prefix:
```
data: {"choices":[{"delta":{"content":"Hello"}}]}
data: {"choices":[{"delta":{"content":"!"}}]}
data: [DONE]
```

### Chat Management

#### GET /api/chats
Get chats for current session.

**Headers:** `Authorization: Bearer <token>`

**Query Parameters:**
- `page` (optional): Page number (default: 1)
- `limit` (optional): Items per page (default: 20)

**Response:**
```json
{
  "chats": [
    {
      "id": "chat-uuid",
      "sessionId": "session-uuid",
      "title": "New Conversation",
      "model": "qwen/qwen2.5-vl-72b-instruct:free",
      "createdAt": "2024-01-15T10:30:00.000Z",
      "updatedAt": "2024-01-15T10:30:00.000Z",
      "messages": []
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 5,
    "pages": 1
  },
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

#### POST /api/chats
Create a new chat.

**Headers:** `Authorization: Bearer <token>`

**Request Body:**
```json
{
  "title": "New Conversation",
  "model": "qwen/qwen2.5-vl-72b-instruct:free"
}
```

**Response:**
```json
{
  "chat": {
    "id": "chat-uuid",
    "sessionId": "session-uuid",
    "title": "New Conversation",
    "model": "qwen/qwen2.5-vl-72b-instruct:free",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z",
    "messages": []
  },
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

#### GET /api/chats/:chatId
Get specific chat with messages.

**Headers:** `Authorization: Bearer <token>`

**Response:**
```json
{
  "chat": {
    "id": "chat-uuid",
    "sessionId": "session-uuid",
    "title": "New Conversation",
    "model": "qwen/qwen2.5-vl-72b-instruct:free",
    "createdAt": "2024-01-15T10:30:00.000Z",
    "updatedAt": "2024-01-15T10:30:00.000Z",
    "messages": [
      {
        "id": 1,
        "role": "user",
        "content": "Hello",
        "timestamp": "2024-01-15T10:30:00.000Z"
      }
    ]
  },
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

#### DELETE /api/chats/:chatId
Delete a chat.

**Headers:** `Authorization: Bearer <token>`

**Response:**
```json
{
  "message": "Chat deleted successfully",
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

### Statistics

#### GET /api/stats
Get API statistics.

**Response:**
```json
{
  "availableModels": 11,
  "freeModelsOnly": true,
  "serverUptime": 3600,
  "nodeVersion": "v18.17.0",
  "database": {
    "sessions": 5,
    "chats": 12,
    "messages": 45,
    "apiUsage": 67
  },
  "timestamp": "2024-01-15T10:30:00.000Z"
}
```

## Error Responses

All error responses follow this format:

```json
{
  "error": "Error message",
  "timestamp": "2024-01-15T10:30:00.000Z",
  "path": "/api/endpoint",
  "method": "POST"
}
```

### Common Error Codes

- `400` - Bad Request (validation errors)
- `401` - Unauthorized (invalid or missing token)
- `403` - Forbidden (access denied)
- `404` - Not Found
- `429` - Too Many Requests (rate limited)
- `500` - Internal Server Error

## Rate Limiting

- **General API**: 100 requests per 15 minutes per IP
- **Chat Completions**: 20 requests per minute per IP

Rate limit headers are included in responses:
- `X-RateLimit-Limit`: Request limit
- `X-RateLimit-Remaining`: Remaining requests
- `X-RateLimit-Reset`: Reset time

## Model-Specific API Keys

The backend supports different API keys for different models:

- **Qwen models**: Uses `QWEN_API_KEY`
- **Gemma models**: Uses `GEMMA_API_KEY`
- **Other models**: Uses `DEFAULT_API_KEY`

This allows for better organization and potentially different billing/usage tracking per model provider.

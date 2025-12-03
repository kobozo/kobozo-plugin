---
description: Docker Compose knowledge and methodology. Use when user mentions containers, docker, compose, multi-service deployment, or needs containerization guidance. This skill teaches Docker best practices and delegates to the docker-agent for actual container operations.
---

# Docker Compose Skill

This skill provides Docker Compose methodology and best practices. When you need to **execute** Docker operations (list containers, view logs, deploy), delegate to the **docker-agent** which has access to the Docker MCP tools.

## When to Use Docker

### Triggers - Use Docker When:
- Setting up multi-service applications (frontend + backend + database)
- Creating reproducible development environments
- Deploying microservices architectures
- Need service isolation and networking
- Setting up reverse proxy (nginx) routing
- Managing databases with persistent storage

### Not Docker:
- Simple script execution
- Single-file utilities
- No service dependencies needed

## Architecture Patterns

### 1. Full-Stack Web Application
```
Internet → nginx:80 → frontend:3000
                   → backend:4000 → postgres:5432
                                  → redis:6379
```

**Services**: nginx, frontend, backend, database, cache
**Use case**: React/Vue + Node.js/Python API + PostgreSQL

### 2. Microservices with API Gateway
```
Internet → nginx:80 → auth-service:3001
                   → user-service:3002
                   → product-service:3003
                   → All services → shared DB or service DBs
```

**Services**: nginx (gateway), multiple API services, databases
**Use case**: Domain-driven microservices

### 3. Simple Development Stack
```
Internet → app:3000 → database:5432
```

**Services**: application, database
**Use case**: Simple apps, prototypes

## Best Practices Checklist

### Service Configuration
- [ ] Named containers for easy identification
- [ ] Health checks for all services
- [ ] Restart policies (`unless-stopped` for prod)
- [ ] Resource limits (CPU, memory)
- [ ] Proper dependency order with `depends_on`

### Networking
- [ ] Named networks (not default)
- [ ] Internal networks for backend services
- [ ] Frontend network for public-facing services
- [ ] No direct port exposure for internal services (use `expose:`)

### Data Persistence
- [ ] Named volumes for databases (NOT bind mounts for data)
- [ ] Bind mounts only for code (development hot reload)
- [ ] Volume backups planned

### Security
- [ ] Secrets in `.env` file (not in compose)
- [ ] `.env.example` for documentation
- [ ] No hardcoded passwords
- [ ] Internal network isolation

### Production Readiness
- [ ] Multi-stage Dockerfile builds
- [ ] Log rotation configured
- [ ] SSL/TLS via nginx
- [ ] Monitoring endpoints (`/health`)

## Docker Compose File Structure

```yaml
version: '3.8'

services:
  # Service definition
  service-name:
    image: image:tag           # OR build: context
    container_name: project-service
    expose:
      - "port"                 # Internal only
    ports:
      - "host:container"       # External exposure
    environment:
      - VAR=${VAR}
    volumes:
      - named-volume:/data
    depends_on:
      other-service:
        condition: service_healthy
    networks:
      - network-name
    restart: unless-stopped
    healthcheck:
      test: ["CMD", "command"]
      interval: 30s
      timeout: 10s
      retries: 3

networks:
  network-name:
    driver: bridge
    internal: true             # No external access

volumes:
  named-volume:
```

## Common Service Templates

### PostgreSQL
```yaml
postgres:
  image: postgres:15-alpine
  environment:
    - POSTGRES_USER=${DB_USER}
    - POSTGRES_PASSWORD=${DB_PASSWORD}
    - POSTGRES_DB=${DB_NAME}
  volumes:
    - postgres-data:/var/lib/postgresql/data
  healthcheck:
    test: ["CMD-SHELL", "pg_isready -U ${DB_USER}"]
    interval: 10s
    timeout: 5s
    retries: 5
```

### Redis
```yaml
redis:
  image: redis:7-alpine
  command: redis-server --appendonly yes
  volumes:
    - redis-data:/data
  healthcheck:
    test: ["CMD", "redis-cli", "ping"]
    interval: 10s
    timeout: 3s
    retries: 5
```

### Nginx Reverse Proxy
```yaml
nginx:
  image: nginx:alpine
  ports:
    - "80:80"
    - "443:443"
  volumes:
    - ./nginx/nginx.conf:/etc/nginx/nginx.conf:ro
  depends_on:
    - frontend
    - backend
```

## Delegating to Docker Agent

When you need to **execute** Docker operations, delegate to the docker-agent:

### Use docker-agent for:
- Listing running containers
- Viewing container logs
- Deploying compose stacks
- Creating/starting/stopping containers
- Health monitoring

### Example delegation:
```
"I need to check what containers are running and view the backend logs.
Let me use the docker-agent to interact with Docker."
```

The docker-agent has access to the Docker MCP with these tools:
- `list_containers` - List all containers
- `list_images` - List available images
- `get_logs` - Get container logs
- `create_container` - Create a new container
- `start_container` / `stop_container` / `remove_container`
- `create_network` / `create_volume`

## Troubleshooting Guide

### Container Won't Start
1. Check logs: `docker-compose logs service-name`
2. Verify dependencies are healthy
3. Check environment variables
4. Verify volume permissions

### Database Connection Issues
1. Ensure database is healthy before app starts
2. Use `condition: service_healthy` in depends_on
3. Verify DATABASE_URL format

### Network Issues
1. All services must be on same network
2. Use service names for DNS (not localhost)
3. Check internal network isn't blocking needed access

### Port Conflicts
1. Use `expose:` for internal services
2. Only use `ports:` for external access
3. Check no host port conflicts

## Quick Reference Commands

```bash
# Start stack
docker-compose up -d

# View logs
docker-compose logs -f [service]

# Check status
docker-compose ps

# Restart service
docker-compose restart [service]

# Rebuild and restart
docker-compose up -d --build

# Stop and remove
docker-compose down

# Full cleanup (including volumes)
docker-compose down -v
```

Remember: This skill provides **knowledge**. For **execution**, delegate to the docker-agent.

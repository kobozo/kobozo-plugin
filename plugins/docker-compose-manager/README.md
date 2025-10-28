# Docker Compose Manager Plugin

> Orchestrate multi-service Docker Compose environments with nginx reverse proxy routing, SSL/TLS setup, and comprehensive service management.

**Version:** 1.0.0
**Author:** Yannick De Backer (yannick@kobozo.eu)
**MCP Integration:** Podman MCP Server (`podman-mcp-server`) - supports both Docker and Podman

## Table of Contents

- [Overview](#overview)
- [Key Features](#key-features)
- [Installation](#installation)
- [MCP Server Integration](#mcp-server-integration)
- [Commands](#commands)
  - [Setup Docker Environment](#setup-docker-environment)
  - [Configure Nginx](#configure-nginx)
- [Agents](#agents)
  - [Service Manager](#service-manager)
  - [Container Orchestrator](#container-orchestrator)
  - [Nginx Configurator](#nginx-configurator)
- [Workflow Examples](#workflow-examples)
- [Docker Compose Best Practices](#docker-compose-best-practices)
- [Nginx Configuration Patterns](#nginx-configuration-patterns)
- [Troubleshooting](#troubleshooting)
- [Best Practices](#best-practices)

## Overview

The Docker Compose Manager plugin provides comprehensive tools for creating, deploying, and managing production-ready Docker Compose environments. It orchestrates multi-service applications with intelligent service configuration, nginx reverse proxy setup, SSL/TLS management, and health monitoring.

This plugin integrates with Podman MCP Server to provide direct container management capabilities for both Docker and Podman runtimes, enabling seamless deployment and monitoring of containerized applications.

## Key Features

- **Multi-Service Orchestration**: Design and deploy complex multi-container architectures
- **Intelligent Service Discovery**: Automatically detect services and dependencies from project structure
- **Nginx Reverse Proxy**: Configure path-based or subdomain-based routing with SSL/TLS
- **SSL/TLS Management**: Self-signed certificates for development, Let's Encrypt for production
- **Health Monitoring**: Track service health, resource usage, and logs
- **Load Balancing**: Configure nginx for horizontal scaling of services
- **Security Best Practices**: Rate limiting, security headers, IP whitelisting
- **Podman MCP Integration**: Direct container management for Docker/Podman via Model Context Protocol
- **Environment Templates**: Pre-configured setups for development and production

## Installation

### Prerequisites

- Claude Code with plugin support
- Docker or Podman and Docker Compose installed
- Node.js and npm (for Podman MCP Server)

### Install Plugin

1. Clone or download this plugin to your Claude plugins directory:
   ```bash
   ~/.config/claude/plugins/docker-compose-manager/
   ```

2. The Podman MCP server will be automatically installed when the plugin is activated:
   ```bash
   npx -y podman-mcp-server@latest
   ```

3. Restart Claude Code to activate the plugin.

## MCP Server Integration

This plugin uses the Podman MCP server to communicate with Docker and Podman:

```json
{
  "mcpServers": {
    "docker": {
      "command": "npx",
      "args": ["-y", "podman-mcp-server@latest"]
    }
  }
}
```

### Available MCP Tools

The Podman MCP server provides comprehensive container management capabilities:

- **list_containers**: List all running and stopped containers
- **run_container**: Create and start new containers with configuration
- **container_logs**: Retrieve and analyze container logs
- **remove_container**: Remove containers (with force option)
- **container_stats**: Monitor resource usage (CPU, memory, disk)
- **Image management**: Pull, list, and manage container images
- **Volume management**: Create and manage persistent volumes
- **Network management**: Configure container networking

## Commands

### Setup Docker Environment

Create a complete production-ready Docker Compose environment with nginx reverse proxy routing.

#### Usage

```bash
/setup-docker-env [project-name] [--type=fullstack|microservices|simple]
```

#### Examples

```bash
# Full-stack application (frontend + backend + database + nginx)
/setup-docker-env my-app

# Microservices architecture
/setup-docker-env my-api --type=microservices

# Simple application (app + database)
/setup-docker-env blog --type=simple
```

#### Workflow Phases

**Phase 1: Discovery**
- Analyze project structure
- Identify application type (web app, API, microservices)
- Detect existing Dockerfiles and package managers
- Determine service requirements

**Phase 2: Architecture Design**
- Launch **container-orchestrator** agent
- Design multi-service architecture
- Plan network configuration and volumes
- Create service dependency graph

**Phase 3: Service Configuration**
- Generate docker-compose.yml with all services
- Create .env and .env.example files
- Configure health checks and resource limits
- Set up proper dependency management

**Phase 4: Nginx Setup**
- Launch **nginx-configurator** agent
- Generate nginx.conf and server blocks
- Configure routing (path-based or subdomain)
- Set up SSL certificates

**Phase 5: Deployment**
- Deploy stack using Podman MCP Server
- Verify all services are running
- Launch **service-manager** agent for monitoring
- Test all endpoints

#### Generated Files

```
project/
├── docker-compose.yml       # Main orchestration file
├── .env                     # Environment variables (gitignored)
├── .env.example            # Template for environment setup
├── nginx/
│   ├── nginx.conf          # Main nginx configuration
│   ├── conf.d/
│   │   └── default.conf    # Server blocks and routing
│   └── ssl/
│       ├── cert.pem        # SSL certificate
│       └── key.pem         # Private key
├── scripts/
│   ├── init-letsencrypt.sh # Let's Encrypt setup
│   └── backup.sh           # Backup script
└── docs/
    └── DOCKER_SETUP.md     # Documentation
```

#### Environment Types

**Development**
- Hot reload enabled
- Exposed database ports
- Verbose logging
- Self-signed SSL (optional)

**Production**
- Optimized builds
- Internal networks
- Resource limits
- Let's Encrypt SSL
- Log rotation

### Configure Nginx

Configure nginx as a reverse proxy for Docker Compose services with flexible routing, SSL/TLS, and security.

#### Usage

```bash
/configure-nginx [--routing=path|subdomain] [--ssl=self|letsencrypt|none] [--load-balance]
```

#### Examples

```bash
# Path-based routing with self-signed SSL
/configure-nginx --routing=path --ssl=self

# Subdomain routing with Let's Encrypt
/configure-nginx --routing=subdomain --ssl=letsencrypt

# Load balanced setup with SSL
/configure-nginx --load-balance --ssl=letsencrypt
```

#### Routing Strategies

**Path-Based Routing**
```
http://localhost/          → Frontend
http://localhost/api       → Backend API
http://localhost/admin     → Admin panel
http://localhost/ws        → WebSocket
```

**Subdomain Routing**
```
http://www.example.com     → Frontend
http://api.example.com     → Backend API
http://admin.example.com   → Admin panel
```

#### SSL/TLS Options

**Self-Signed (Development)**
- Quick setup for local development
- Browser warning expected
- Generated automatically

**Let's Encrypt (Production)**
- Free, trusted certificates
- Automatic renewal with certbot
- Requires valid domain

**None**
- HTTP only
- Development environments only

## Agents

### Service Manager

**Agent**: `service-manager`
**Color**: Cyan
**Model**: Sonnet
**MCP Server**: Podman MCP Server

#### Purpose

Manages Docker Compose service lifecycle including health monitoring, log analysis, scaling, and troubleshooting.

#### Capabilities

- **Health Monitoring**: Track service status and health checks
- **Log Analysis**: View, search, and analyze container logs
- **Service Scaling**: Horizontally scale services
- **Resource Monitoring**: Track CPU, memory, and disk usage
- **Troubleshooting**: Diagnose and fix common issues
- **Backup & Recovery**: Database and volume backups

#### Usage Example

```bash
# The service-manager agent is automatically launched after deployment
# to verify all services are healthy

# You can also invoke it manually:
/agent service-manager
```

#### Key Features

**Health Check Report**
```markdown
## Service Status Overview

Total Services: 5
Running: 4
Unhealthy: 1

### Detailed Status
- Frontend: Running, healthy (2.5% CPU, 128MB RAM)
- Backend: Running, healthy (15.3% CPU, 450MB RAM) ⚠️ High memory
- PostgreSQL: Running, healthy
- Redis: Restarting (health check failing)
- Nginx: Running, healthy
```

**Log Analysis**
- Pattern detection (errors, warnings)
- Performance metrics
- Connection issues
- Memory leaks

**Common Issues Handled**
- Service won't start
- Container restart loops
- Database connection failures
- Volume permission issues
- Network connectivity problems

### Container Orchestrator

**Agent**: `container-orchestrator`
**Color**: Blue
**Model**: Sonnet
**MCP Server**: Podman MCP Server

#### Purpose

Orchestrates Docker Compose environments by analyzing requirements, designing multi-service architectures, and deploying containerized applications.

#### Capabilities

- **Requirements Analysis**: Understand application needs
- **Service Discovery**: Detect existing Docker configurations
- **Architecture Design**: Create optimal service layouts
- **Compose Generation**: Build production-ready docker-compose.yml
- **Deployment**: Deploy via Podman MCP Server
- **Health Verification**: Ensure successful deployment

#### Usage Example

```bash
# Launched automatically by /setup-docker-env
# or invoke directly:
/agent container-orchestrator
```

#### Architecture Patterns

**1. Simple Web Application**
- App + Database
- Basic networking
- Volume persistence

**2. Full-Stack Application**
- Frontend (React/Vue/Angular)
- Backend API (Node.js/Python/Go)
- Database (PostgreSQL/MySQL/MongoDB)
- Cache (Redis)
- Nginx reverse proxy

**3. Microservices**
- Multiple API services
- Shared or separate databases
- Message queue (RabbitMQ/Kafka)
- Service discovery
- API gateway

**4. Development Environment**
- Hot reload support
- Exposed ports for debugging
- Admin tools (pgAdmin, Redis Commander)
- Volume mounts for code

#### Best Practices Implemented

- Service isolation with proper networking
- Health checks for all services
- Dependency management (depends_on with conditions)
- Resource limits and logging
- Named volumes for persistence
- Environment variable management

### Nginx Configurator

**Agent**: `nginx-configurator`
**Color**: Purple
**Model**: Sonnet

#### Purpose

Configures nginx as a reverse proxy for Docker Compose environments with routing, SSL, load balancing, and security.

#### Capabilities

- **Routing Configuration**: Path-based and subdomain routing
- **SSL/TLS Setup**: Self-signed and Let's Encrypt certificates
- **Load Balancing**: Multiple backend instances
- **Caching**: Proxy cache for better performance
- **Security**: Rate limiting, security headers, IP whitelisting
- **WebSocket Support**: Proper upgrade headers

#### Usage Example

```bash
# Launched automatically by /setup-docker-env or /configure-nginx
# or invoke directly:
/agent nginx-configurator
```

#### Configuration Features

**Routing**
- Path-based: `/` → frontend, `/api` → backend
- Subdomain: `www.` → frontend, `api.` → backend
- Custom routes with regex support

**Load Balancing Algorithms**
- Round Robin (default)
- Least Connections
- IP Hash (session persistence)
- Weighted distribution

**Security Headers**
- HSTS (HTTP Strict Transport Security)
- X-Frame-Options (clickjacking prevention)
- X-Content-Type-Options (MIME sniffing prevention)
- Content Security Policy
- Referrer Policy

**Performance**
- Gzip compression
- HTTP/2 support
- Keepalive connections
- Static file caching
- Proxy caching

## Workflow Examples

### Example 1: Full-Stack Application Setup

```bash
# Step 1: Set up complete Docker environment
/setup-docker-env my-fullstack-app

# The command will:
# 1. Analyze your project structure
# 2. Detect React frontend, Node.js backend
# 3. Launch container-orchestrator to design architecture
# 4. Create docker-compose.yml with frontend, backend, postgres, redis, nginx
# 5. Launch nginx-configurator for reverse proxy
# 6. Deploy via Podman MCP Server
# 7. Launch service-manager to verify health

# Step 2: Access your application
# Frontend: http://localhost
# Backend API: http://localhost/api
# Database: localhost:5432 (for development tools)
```

### Example 2: Microservices with Subdomain Routing

```bash
# Set up microservices architecture
/setup-docker-env my-microservices --type=microservices

# Configure subdomain routing
/configure-nginx --routing=subdomain --ssl=letsencrypt

# Result:
# - auth-service at auth.example.com
# - user-service at users.example.com
# - product-service at products.example.com
# - API gateway at api.example.com
```

### Example 3: Adding Load Balancing

```bash
# Configure nginx with load balancing for scaled backend
/configure-nginx --load-balance --ssl=self

# Edit docker-compose.yml to scale backend:
docker-compose up -d --scale backend=3

# Nginx automatically load balances across 3 backend instances
```

### Example 4: Service Health Monitoring

```bash
# Launch service manager to check health
/agent service-manager

# The agent will:
# 1. List all running containers
# 2. Check health status
# 3. Analyze resource usage
# 4. Review logs for errors
# 5. Provide recommendations
```

## Docker Compose Best Practices

### 1. Use Named Volumes

```yaml
volumes:
  postgres-data:        # Managed by Docker
  redis-data:
  # NOT: ./data:/data  # Bind mount causes permission issues
```

### 2. Implement Health Checks

```yaml
services:
  backend:
    healthcheck:
      test: ["CMD", "wget", "--quiet", "--tries=1", "--spider", "http://localhost:3000/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
```

### 3. Proper Dependency Management

```yaml
services:
  backend:
    depends_on:
      db:
        condition: service_healthy  # Wait for DB to be healthy
      redis:
        condition: service_healthy
```

### 4. Network Segmentation

```yaml
networks:
  frontend:
    driver: bridge
  backend:
    driver: bridge
    internal: true  # Not accessible from outside
```

### 5. Resource Limits

```yaml
services:
  backend:
    deploy:
      resources:
        limits:
          cpus: '1.0'
          memory: 1G
        reservations:
          memory: 512M
```

### 6. Logging Configuration

```yaml
services:
  backend:
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"
```

### 7. Environment Variables

```yaml
services:
  backend:
    env_file:
      - .env
    environment:
      - NODE_ENV=${NODE_ENV:-production}
      - DATABASE_URL=${DATABASE_URL}
```

## Nginx Configuration Patterns

### Path-Based Routing

```nginx
server {
    listen 443 ssl http2;
    server_name example.com;

    # Frontend
    location / {
        proxy_pass http://frontend:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # Backend API
    location /api {
        proxy_pass http://backend:4000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    # WebSocket
    location /ws {
        proxy_pass http://backend:4000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

### Load Balancing

```nginx
upstream backend_cluster {
    least_conn;
    server backend-1:4000 weight=3;
    server backend-2:4000 weight=2;
    server backend-3:4000 weight=1;
    keepalive 32;
}

server {
    listen 443 ssl http2;

    location /api {
        proxy_pass http://backend_cluster;
        proxy_http_version 1.1;
        proxy_set_header Connection "";
    }
}
```

### Rate Limiting

```nginx
http {
    limit_req_zone $binary_remote_addr zone=api_limit:10m rate=20r/s;
    limit_req_zone $binary_remote_addr zone=login_limit:10m rate=5r/m;
}

server {
    location /api {
        limit_req zone=api_limit burst=50 nodelay;
        proxy_pass http://backend;
    }

    location /api/auth/login {
        limit_req zone=login_limit burst=5 nodelay;
        proxy_pass http://backend;
    }
}
```

### Caching

```nginx
proxy_cache_path /var/cache/nginx levels=1:2 keys_zone=api_cache:10m max_size=1g;

server {
    location /api/public {
        proxy_cache api_cache;
        proxy_cache_valid 200 10m;
        proxy_cache_use_stale error timeout updating;
        add_header X-Cache-Status $upstream_cache_status;

        proxy_pass http://backend;
    }
}
```

## Troubleshooting

### Common Issues

#### 1. Service Won't Start

**Symptoms**: Container exits immediately after starting

**Diagnosis**:
```bash
# Check logs
docker-compose logs backend

# Try interactive mode
docker-compose run --rm backend sh

# Verify environment variables
docker-compose config
```

**Solutions**:
- Check for missing environment variables in .env
- Verify database is ready before backend starts
- Check for port conflicts
- Review volume permissions

#### 2. Container Restart Loop

**Symptoms**: Service constantly restarting

**Diagnosis**:
```bash
# Check restart count
docker-compose ps

# View crash logs
docker-compose logs --tail=50 worker

# Check resource usage
docker stats
```

**Solutions**:
- Adjust restart policy: `restart: on-failure:3`
- Increase resource limits
- Fix application crash cause
- Add proper health checks

#### 3. Database Connection Issues

**Symptoms**: "Connection refused" or "ECONNREFUSED"

**Solutions**:
```yaml
services:
  backend:
    depends_on:
      db:
        condition: service_healthy
    environment:
      - DATABASE_URL=postgresql://user:pass@db:5432/mydb

  db:
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U user"]
      interval: 10s
      timeout: 5s
      retries: 5
```

#### 4. Nginx 502 Bad Gateway

**Symptoms**: nginx returns 502 error

**Diagnosis**:
```bash
# Check if backend is running
docker-compose ps backend

# Check nginx logs
docker-compose logs nginx

# Test backend directly
curl http://localhost:4000/health
```

**Solutions**:
- Ensure backend service is running
- Verify service names match in nginx config
- Check services are on same network
- Review backend logs for crashes

#### 5. SSL Certificate Issues

**Symptoms**: "Certificate not trusted" or SSL errors

**Development**:
- Self-signed certificates cause browser warnings (expected)
- Add exception in browser or use `curl -k`

**Production**:
```bash
# Verify Let's Encrypt setup
docker-compose logs certbot

# Check certificate files
ls -la nginx/ssl/live/example.com/

# Renew certificate manually
docker-compose run --rm certbot renew
```

### Quick Fixes

```bash
# Rebuild everything from scratch
docker-compose down -v
docker-compose build --no-cache
docker-compose up -d

# Restart specific service
docker-compose restart backend

# View all logs
docker-compose logs -f

# Check service health
docker-compose ps

# Execute command in container
docker-compose exec backend sh

# Clean up unused resources
docker system prune -a
```

## Best Practices

### Security

1. **Never commit .env files**: Add to .gitignore
2. **Use secrets management**: For production credentials
3. **Implement rate limiting**: Prevent abuse
4. **Enable SSL/TLS**: Always in production
5. **Restrict admin access**: Use IP whitelisting
6. **Keep images updated**: Regular security patches
7. **Use non-root users**: In container images
8. **Scan for vulnerabilities**: Use `docker scan`

### Performance

1. **Use multi-stage builds**: Smaller image sizes
2. **Enable caching**: Reduce backend load
3. **Implement health checks**: Quick failure detection
4. **Use connection pooling**: For databases
5. **Enable HTTP/2**: Better performance
6. **Optimize images**: Use Alpine-based images
7. **Set resource limits**: Prevent resource exhaustion

### Maintenance

1. **Document your setup**: Keep README updated
2. **Version your configurations**: Use git
3. **Automate backups**: Regular database backups
4. **Monitor logs**: Set up log aggregation
5. **Track metrics**: Use monitoring tools
6. **Plan for scaling**: Design for growth
7. **Test disaster recovery**: Regular restore tests

### Development Workflow

1. **Use hot reload**: For faster development
2. **Expose ports**: For debugging tools
3. **Mount volumes**: For live code updates
4. **Use override files**: `docker-compose.override.yml`
5. **Create seed data**: For consistent testing
6. **Document ports**: List all exposed ports

### Production Workflow

1. **Use specific versions**: Avoid `latest` tag
2. **Implement CI/CD**: Automated deployments
3. **Use health checks**: For zero-downtime updates
4. **Enable auto-restart**: `restart: unless-stopped`
5. **Set up monitoring**: Datadog, Prometheus, etc.
6. **Configure alerts**: For service failures
7. **Plan rollback strategy**: Quick recovery

## Command Reference

```bash
# Start all services
docker-compose up -d

# Stop all services
docker-compose stop

# Restart service
docker-compose restart backend

# View logs
docker-compose logs -f

# View logs for specific service
docker-compose logs -f backend

# Check status
docker-compose ps

# Scale service
docker-compose up -d --scale backend=3

# Rebuild and restart
docker-compose up -d --build

# Execute command in container
docker-compose exec backend npm run migrate

# Run one-off command
docker-compose run --rm backend npm run seed

# Remove everything
docker-compose down

# Remove with volumes
docker-compose down -v

# Remove with images
docker-compose down --rmi all
```

## Contributing

This plugin is part of the kobozo-plugins collection. For issues, features, or contributions, please visit the main repository.

## License

Copyright (c) 2025 Yannick De Backer

---

**Need Help?**
- Check the [Troubleshooting](#troubleshooting) section
- Review the [Workflow Examples](#workflow-examples)
- Consult the [Best Practices](#best-practices) guide
- Use the `/agent service-manager` for live diagnostics

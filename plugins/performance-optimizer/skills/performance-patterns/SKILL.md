---
name: Performance Patterns
description: This skill should be used when the user asks to "profile performance", "optimize performance", "find bottlenecks", "optimize bundle", "improve speed", "reduce bundle size", or when writing code that involves database queries, loops, data processing, API calls, caching, or any performance-sensitive operations. Provides guidance on avoiding N+1 queries, optimizing loops, efficient data structures, caching strategies, and bundle optimization. Apply proactively when writing code.
version: 1.0.0
---

# Performance Patterns

Apply these patterns automatically when writing code to avoid common performance pitfalls.

## Database Performance

### Avoid N+1 Queries

The N+1 problem: Fetching a list, then querying for each item separately.

```typescript
// BAD: N+1 queries (1 + N separate queries)
const users = await User.findAll();
for (const user of users) {
  user.posts = await Post.findAll({ where: { userId: user.id } });
}

// GOOD: Eager loading (2 queries total)
const users = await User.findAll({
  include: [{ model: Post }]
});

// GOOD: Batch query
const users = await User.findAll();
const userIds = users.map(u => u.id);
const posts = await Post.findAll({ where: { userId: userIds } });
// Then map posts to users in memory
```

### Use Proper Indexes

```sql
-- Index columns used in WHERE, JOIN, ORDER BY
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_posts_user_created ON posts(user_id, created_at);

-- Composite indexes for multi-column queries
-- Order matters: most selective column first
CREATE INDEX idx_orders_status_date ON orders(status, created_at);
```

### Limit Query Results

```typescript
// Always paginate large datasets
const users = await User.findAll({
  limit: 20,
  offset: page * 20,
  order: [['createdAt', 'DESC']]
});

// Select only needed columns
const users = await User.findAll({
  attributes: ['id', 'name', 'email']  // Not SELECT *
});
```

### Batch Operations

```typescript
// BAD: Individual inserts
for (const item of items) {
  await Item.create(item);  // N queries
}

// GOOD: Bulk insert
await Item.bulkCreate(items);  // 1 query

// GOOD: Batch updates
await User.update(
  { status: 'active' },
  { where: { id: userIds } }
);
```

## Loop Optimization

### Move Work Outside Loops

```typescript
// BAD: Repeated work inside loop
for (const item of items) {
  const config = await loadConfig();  // Loaded N times
  process(item, config);
}

// GOOD: Load once
const config = await loadConfig();
for (const item of items) {
  process(item, config);
}
```

### Use Efficient Data Structures

```typescript
// BAD: O(n) lookup in array
const users = await getUsers();
for (const order of orders) {
  const user = users.find(u => u.id === order.userId);  // O(n) each time
}

// GOOD: O(1) lookup with Map
const userMap = new Map(users.map(u => [u.id, u]));
for (const order of orders) {
  const user = userMap.get(order.userId);  // O(1)
}
```

### Avoid Array Methods in Hot Paths

```typescript
// BAD: Multiple array iterations
const result = items
  .filter(x => x.active)
  .map(x => x.value)
  .reduce((a, b) => a + b, 0);  // 3 iterations

// GOOD: Single iteration
let result = 0;
for (const item of items) {
  if (item.active) {
    result += item.value;
  }
}
```

## Async Operations

### Parallelize Independent Operations

```typescript
// BAD: Sequential (total: t1 + t2 + t3)
const users = await getUsers();
const orders = await getOrders();
const products = await getProducts();

// GOOD: Parallel (total: max(t1, t2, t3))
const [users, orders, products] = await Promise.all([
  getUsers(),
  getOrders(),
  getProducts()
]);
```

### Batch API Calls

```typescript
// BAD: Individual API calls
const results = [];
for (const id of ids) {
  results.push(await fetchItem(id));  // N API calls
}

// GOOD: Batch API call
const results = await fetchItems(ids);  // 1 API call

// Or parallel with concurrency limit
import pLimit from 'p-limit';
const limit = pLimit(5);
const results = await Promise.all(
  ids.map(id => limit(() => fetchItem(id)))
);
```

## Caching Strategies

### In-Memory Caching

```typescript
// Simple memoization
const cache = new Map();

async function getUser(id: string): Promise<User> {
  if (cache.has(id)) {
    return cache.get(id);
  }
  const user = await db.user.findById(id);
  cache.set(id, user);
  return user;
}
```

### Cache with TTL

```typescript
interface CacheEntry<T> {
  value: T;
  expiry: number;
}

class TTLCache<T> {
  private cache = new Map<string, CacheEntry<T>>();

  set(key: string, value: T, ttlMs: number): void {
    this.cache.set(key, {
      value,
      expiry: Date.now() + ttlMs
    });
  }

  get(key: string): T | undefined {
    const entry = this.cache.get(key);
    if (!entry || entry.expiry < Date.now()) {
      this.cache.delete(key);
      return undefined;
    }
    return entry.value;
  }
}
```

### Cache Invalidation

```typescript
// Invalidate on write
async function updateUser(id: string, data: UserData): Promise<User> {
  const user = await db.user.update(id, data);
  cache.delete(`user:${id}`);  // Invalidate cache
  return user;
}
```

## Frontend Performance

### Lazy Loading

```typescript
// React: Lazy load components
const HeavyComponent = React.lazy(() => import('./HeavyComponent'));

// Images: Lazy load below fold
<img loading="lazy" src="image.jpg" />

// Routes: Code split by route
const routes = [
  { path: '/dashboard', component: lazy(() => import('./Dashboard')) }
];
```

### Memoization

```typescript
// Memoize expensive calculations
const expensiveResult = useMemo(() => {
  return heavyCalculation(data);
}, [data]);

// Memoize callbacks
const handleClick = useCallback(() => {
  doSomething(id);
}, [id]);

// Memoize components
const MemoizedComponent = React.memo(ExpensiveComponent);
```

### Debounce/Throttle

```typescript
// Debounce: Wait for pause in events
const debouncedSearch = useMemo(
  () => debounce((term: string) => search(term), 300),
  []
);

// Throttle: Limit event frequency
const throttledScroll = useMemo(
  () => throttle(() => handleScroll(), 100),
  []
);
```

## Bundle Optimization

### Tree Shaking

```typescript
// BAD: Import entire library
import _ from 'lodash';
_.map(items, fn);

// GOOD: Import only what you need
import map from 'lodash/map';
map(items, fn);

// Or use lodash-es for better tree shaking
import { map } from 'lodash-es';
```

### Dynamic Imports

```typescript
// Load heavy libraries on demand
async function generatePdf() {
  const pdfLib = await import('pdf-lib');
  // Use pdfLib...
}
```

### Smaller Alternatives

| Heavy Library | Lighter Alternative |
|---------------|---------------------|
| moment.js (300KB) | date-fns (30KB) or dayjs (2KB) |
| lodash (70KB) | lodash-es + tree shaking |
| axios (13KB) | native fetch |

## Quick Reference

### Database Checklist
- [ ] No N+1 queries (use eager loading)
- [ ] Indexes on WHERE/JOIN/ORDER columns
- [ ] Pagination for large datasets
- [ ] SELECT specific columns, not *
- [ ] Bulk operations for batch writes

### Code Checklist
- [ ] Expensive operations outside loops
- [ ] Maps for O(1) lookups
- [ ] Parallel async operations
- [ ] Appropriate caching
- [ ] Debounce/throttle user events

### Bundle Checklist
- [ ] Tree-shakeable imports
- [ ] Lazy load routes/components
- [ ] Smaller library alternatives
- [ ] Dynamic imports for heavy libs

## Invoke Full Workflow

For comprehensive performance optimization with specialized agents:

**Use the Task tool** to launch performance optimizer agents:

1. **Performance Analysis**: Launch `performance-optimizer:performance-analyzer` to identify bottlenecks
2. **Bundle Optimization**: Launch `performance-optimizer:bundle-optimizer` to reduce JavaScript bundle sizes
3. **Query Optimization**: Launch `performance-optimizer:query-optimizer` to optimize database queries

**Example prompt for agent:**
```
Profile the application performance and identify bottlenecks.
Focus on database queries and bundle size optimization.
```

## Additional Resources

- [Web Vitals](https://web.dev/vitals/)
- [React Performance](https://reactjs.org/docs/optimizing-performance.html)

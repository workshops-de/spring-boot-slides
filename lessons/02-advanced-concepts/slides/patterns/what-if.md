---
layout: cover
background: https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=1920
---

# What If...?

Advanced scenarios and alternatives

---

# Combining Patterns

<div class="grid grid-cols-2 gap-6">

<div>

## Observer + Strategy

```typescript
interface NotificationStrategy {
  send(message: string): void;
}

class NotificationService {
  private strategy: NotificationStrategy;
  private observers: Observer[] = [];

  setStrategy(s: NotificationStrategy) {
    this.strategy = s;
  }

  notify(message: string) {
    this.strategy.send(message);
    this.observers.forEach((o) => o.update(message));
  }
}
```

</div>

<div>

## When to Combine

- Complex notification systems
- Flexible processing pipelines
- Plugin architectures

<div class="mt-4 p-3 bg-yellow-500 bg-opacity-20 rounded">
  <strong>⚠️ Warning:</strong> Don't over-engineer. Add patterns when needed.
</div>

</div>

</div>

---

# Anti-Patterns to Avoid

| Anti-Pattern               | Problem                      | Solution                       |
| -------------------------- | ---------------------------- | ------------------------------ |
| **God Object**             | One class does everything    | Split responsibilities         |
| **Spaghetti Code**         | No clear structure           | Apply appropriate patterns     |
| **Golden Hammer**          | Using one pattern everywhere | Choose pattern for the problem |
| **Premature Optimization** | Patterns before need         | Start simple, refactor later   |

<br>

<div class="p-4 bg-red-500 bg-opacity-20 rounded-lg">
  <strong>🚫 Remember:</strong> Patterns solve problems. No problem = no pattern needed.
</div>

---

# Modern Alternatives

<div class="grid grid-cols-3 gap-4">

<div class="p-4 bg-blue-500 bg-opacity-20 rounded-lg">
  <h3>🔄 RxJS</h3>
  <p class="text-sm">Reactive extensions replace many behavioral patterns</p>
</div>

<div class="p-4 bg-green-500 bg-opacity-20 rounded-lg">
  <h3>📦 Dependency Injection</h3>
  <p class="text-sm">Framework-level solution for creational patterns</p>
</div>

<div class="p-4 bg-purple-500 bg-opacity-20 rounded-lg">
  <h3>🎯 Functional Programming</h3>
  <p class="text-sm">Composition over inheritance</p>
</div>

</div>

<br>

```typescript
// Modern approach: Functional composition
const processUser = pipe(validate, transform, save, notify);

await processUser(userData);
```

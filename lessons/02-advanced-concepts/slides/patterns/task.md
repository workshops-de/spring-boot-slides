---
layout: cover
background: https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=1920
class: text-center
---

# Exercise: Design Patterns

Apply what you've learned!

---

# Your Task

<div class="grid grid-cols-2 gap-8">

<div>

## Objectives

1. **Implement** the Observer pattern
2. **Create** multiple observers
3. **Test** the notification flow
4. **Extend** with unsubscribe logic

## Time

⏱️ **20 minutes**

</div>

<div>

## Starting Point

```typescript
// Implement this interface
interface Subject<T> {
  subscribe(obs: Observer<T>): void;
  unsubscribe(obs: Observer<T>): void;
  notify(data: T): void;
}

// Your implementation
class Store<T> implements Subject<T> {
  // TODO: Implement
}
```

</div>

</div>

---

# Requirements

<div class="grid grid-cols-2 gap-6">

<div>

## Must Have

- [ ] `subscribe()` adds observers
- [ ] `unsubscribe()` removes observers
- [ ] `notify()` calls all observers
- [ ] Observers receive correct data

</div>

<div>

## Bonus

- [ ] Prevent duplicate subscriptions
- [ ] Add `once()` for single notification
- [ ] Type-safe with generics
- [ ] Memory leak prevention

</div>

</div>

<br>

<div class="p-4 bg-orange-500 bg-opacity-20 rounded-lg">
  <strong>💡 Hint:</strong> Use a <code>Set</code> instead of an array for automatic deduplication.
</div>

---
layout: center
class: text-center
---

# Start Coding!

<div class="text-2xl mt-8">
  Implement the Observer pattern in your project
</div>

<div class="mt-12 text-gray-400">
  Solution: <code>git checkout solution-observer-pattern</code>
</div>

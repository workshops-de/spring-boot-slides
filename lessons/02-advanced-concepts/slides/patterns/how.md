---
layout: cover
background: https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=1920
---

# How to Implement Patterns

Practical examples step by step

---

# Observer Pattern: Step 1

Define the interfaces:

```typescript {1-3|5-10}
// Observer interface
interface Observer<T> {
  update(data: T): void;
}

// Subject interface
interface Subject<T> {
  subscribe(observer: Observer<T>): void;
  unsubscribe(observer: Observer<T>): void;
  notify(data: T): void;
}
```

---

# Observer Pattern: Step 2

Implement the Subject:

```typescript {2-3|5-7|9-13|15-17}
class EventEmitter<T> implements Subject<T> {
  private observers: Set<Observer<T>> = new Set();

  subscribe(observer: Observer<T>): void {
    this.observers.add(observer);
  }

  unsubscribe(observer: Observer<T>): void {
    this.observers.delete(observer);
  }

  notify(data: T): void {
    this.observers.forEach((obs) => obs.update(data));
  }
}
```

---
layout: two-cols
---

# Step 3: Usage

```typescript
// Create subject
const userEvents = new EventEmitter<User>();

// Create observers
const logger: Observer<User> = {
  update: (user) => {
    console.log('User changed:', user);
  },
};

const analytics: Observer<User> = {
  update: (user) => {
    trackEvent('user_update', user);
  },
};

// Subscribe
userEvents.subscribe(logger);
userEvents.subscribe(analytics);

// Trigger
userEvents.notify(currentUser);
```

::right::

<div class="pl-4">

## Benefits

- ✅ Loose coupling
- ✅ Easy to add new observers
- ✅ Single responsibility
- ✅ Open for extension

## Use Cases

- Event systems
- State management
- Real-time updates
- Pub/sub messaging

</div>

---
layout: cover
background: https://images.unsplash.com/photo-1558494949-ef010cbdcc31?w=1920
---

# Why Design Patterns?

Building maintainable and scalable applications

---
layout: two-cols
---

# The Challenge

As applications grow, developers face:

- **Complexity**: Code becomes hard to understand
- **Duplication**: Same solutions reimplemented
- **Maintenance**: Changes ripple through the codebase
- **Onboarding**: New team members struggle

::right::

<div class="flex items-center justify-center h-full">
  <img src="https://images.unsplash.com/photo-1504639725590-34d0984388bd?w=600" class="rounded-lg shadow-xl" />
</div>

---

# The Solution: Patterns

<div class="grid grid-cols-2 gap-8">

<div>

## Without Patterns

```typescript
// Scattered, inconsistent code
class UserManager {
  private users = [];

  add(user) {
    /* ... */
  }
  remove(user) {
    /* ... */
  }
  notify(message) {
    /* ... */
  }
}
```

</div>

<div>

## With Patterns

```typescript
// Clear, consistent structure
class UserRepository {
  private store: Store<User>;

  save(user: User) {
    /* ... */
  }
  delete(id: string) {
    /* ... */
  }
}
```

</div>

</div>

<div class="mt-8 p-4 bg-blue-500 bg-opacity-20 rounded-lg">
  <strong>💡 Key Insight:</strong> Patterns provide a shared vocabulary and proven solutions.
</div>

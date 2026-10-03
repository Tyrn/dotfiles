# The Function Applicative `((->) r)` in Haskell

## Introduction

Among all the `Applicative` instances in Haskell, `((->) r)` — the instance
for functions — is arguably the most conceptually illuminating and the most
frequently misunderstood. It is the instance that powers the `Reader` monad,
it explains why `<$>` and `<*>` behave the way they do for functions, and it
reveals a deep connection between applicative functors and the simple act of
passing a shared argument to several computations.

This document is a complete, self-contained walkthrough of `((->) r)`: its
definition, its laws, its intuition, its idioms, and its relationship to the
`Reader` monad.

---

## 1. The Instance Definition

```haskell
instance Functor ((->) r) where
    fmap = (.)              -- i.e. fmap f g = f . g

instance Applicative ((->) r) where
    pure x  = \_ -> x       -- i.e. const x
    f <*> g = \x -> f x (g x)   -- i.e. \x -> (f x) (g x)
```

Read `((->) r)` as **"functions from `r`"** — a type constructor
that is _partially applied_. So:

- `((->) r) a` = `r -> a`
- `((->) r) b` = `r -> b`
- etc.

In other words, `((->) r)` is a
**functor/applicative whose values are functions that all share
the same input type `r`**.

---

## 2. The Core Idea: A Shared Environment

Think of `r` as a **read-only environment** — some value that is available to
every computation in the chain. Each `r -> a` is "a computation that reads
the environment and produces an `a`."

- **`pure x`** = a computation that ignores the environment and
  just returns `x`.
- **`f <*> g`** = a computation that reads the environment once,
  feeds it to both `f` and `g`, and combines the results.

This is why the same `5` in the example below gets fed to `(+3)`,
`(*2)`, and `(/2)` — they all live in the same environment.

```haskell
ghci> (\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5
[8.0,10.0,2.5]
```

---

## 3. Anatomy of `f <*> g = \x -> f x (g x)`

Let's annotate the types. Suppose:

- `f :: r -> (b -> c)` — a function that reads the env and returns a _function_
- `g :: r -> b` — a function that reads the env and returns a value

Then:

```haskell
f <*> g :: r -> c
f <*> g = \x -> f x (g x)
--              └─┬─┘ └─┬─┘
--                │     │
--                │     └── g x  :: b       (g reads the env)
--                └──────── f x  :: b -> c  (f reads the env, returns a function)
--                          f x (g x) :: c  (apply that function)
--       \x -> ...  :: r -> c
```

The environment `x` is **duplicated**: once for `f`, once for `g`.
That's the whole trick.

### 3.1 `f x (g x)` is Not a Parameter List

It is easy to misread `f x (g x)` as a function call with a parameter
list `x, (g x)`. It is not. It is nested function application:

```haskell
f x (g x)   ≡   (f x) (g x)
```

Two separate applications:

1. `f x` — apply `f` to `x`.
2. `(f x) (g x)` — take the **result** of step 1 (which must be a
   function) and apply it to `(g x)`.

This works because of **currying**. In Haskell, every function
takes exactly one argument. A function "of two arguments" is really
a function returning a function:

```haskell
add :: Int -> Int -> Int
add x y = x + y

-- These are identical:
add 3 4       -- (add 3) 4
```

- `add 3` returns `\y -> 3 + y`.
- That function is then applied to `4`.

For `f <*> g` to typecheck, `f` must have type `r -> (b -> c)`:

- `f x :: b -> c` — a function.
- `(f x) (g x) :: c` — the final value.

The applicative instance relies entirely on this fact:
**a partially applied function is itself a value**, and
that value can be applied to another argument.

---

## 4. Why the Chain Works: `f <$> g <*> h <*> i`

Let's build up the type of a chain, step by step. Start
with four functions all sharing input type `r`:

```haskell
f :: a -> b -> c -> d
g :: r -> a
h :: r -> b
i :: r -> c
```

### Step 1: `f <$> g`

```haskell
f <$> g = f . g
        :: r -> (b -> c -> d)
```

`f . g` reads the env, produces `a` via `g`, then
applies `f` to get a function `b -> c -> d`.

### Step 2: `(f <$> g) <*> h`

```haskell
(f <$> g) <*> h
= \x -> (f <$> g) x (h x)
= \x -> (f (g x)) (h x)
= \x -> f (g x) (h x)
:: r -> (c -> d)
```

Now the env `x` is fed to both `g` and `h`. The
result is still waiting for one more argument.

### Step 3: `((f <$> g) <*> h) <*> i`

```haskell
= \x -> ((f <$> g) <*> h) x (i x)
= \x -> (f (g x) (h x)) (i x)
= \x -> f (g x) (h x) (i x)
:: r -> d
```

The environment `x` is fed to **all three** functions
`g`, `h`, `i`, and their results are collected by `f`.

---

## 5. Visualizing the Environment Threading

```
                    ┌──► g ──► a ──┐
                    │              │
   r  ──── x ───────┼──► h ──► b ──┼──► f ──► d
                    │              │
                    └──► i ──► c ──┘
```

The environment `x :: r` is the _single_ value that
flows into every branch. Each function `g`, `h`, `i`
reads it independently, and `f` combines the three results.

---

## 6. The Applicative Laws for `((->) r)`

The `Applicative` class comes with four laws. For `((->) r)`,
they translate into familiar properties of functions.

### Identity

```haskell
pure id <*> v = v
```

For functions: `pure id = const id`, so

```haskell
(const id) <*> v = \x -> (const id) x (v x) = \x -> id (v x) = v
```

Holds.

### Composition

```haskell
pure (.) <*> u <*> v <*> w = u <*> (v <*> w)
```

Both sides reduce to `\x -> u x (v x (w x))`. Holds.

### Homomorphism

```haskell
pure f <*> pure x = pure (f x)
```

`const f <*> const x = \_ -> f x = const (f x)`. Holds.

### Interchange

```haskell
u <*> pure y = pure ($ y) <*> u
```

Both sides reduce to `\x -> u x y`. Holds.

All four laws hold, which is why `((->) r)` is a lawful `Applicative`.

---

## 7. The Functor Instance and Composition

The `Functor` instance is worth pausing on:

```haskell
instance Functor ((->) r) where
    fmap = (.)
```

`fmap` for functions is just **composition**. This is
why `<$>` and `.` are interchangeable in function-land:

```haskell
f <$> g   ==   f . g
```

So the applicative chain

```haskell
f <$> g <*> h <*> i
```

can be rewritten as

```haskell
(f . g) <*> h <*> i
```

and the `<*>` steps handle the multi-argument plumbing.

---

## 8. The Reader Monad

`((->) r)` also has a `Monad` instance:

```haskell
instance Monad ((->) r) where
    return = const
    m >>= k = \x -> k (m x) x
```

In `do`-notation:

```haskell
do
  a <- g   -- g :: r -> a
  b <- h   -- h :: r -> b
  c <- i   -- i :: r -> c
  return (f a b c)
```

desugars to:

```haskell
\env -> f (g env) (h env) (i env)
```

Same thing! The monad just gives you `do`-notation
sugar for the same environment-threading pattern.
This is exactly the **Reader monad** from
`mtl` — `Reader r a` is just a `newtype` around `r -> a`.

The `Monad` instance is more powerful than the
`Applicative` instance because `>>=` can **choose**
the next computation based on a previous result:

```haskell
\x -> let a = m x
      in (k a) x
```

Notice that the environment `x` is still threaded to both `m`
and the continuation. The monad does not add new environment-passing
behavior; it just allows data-dependent branching.

---

## 9. Useful Idioms

### 9.1 `sequenceA` with functions

```haskell
ghci> sequenceA [(+1), (*2), (/2)] 5
[6.0, 10.0, 2.5]
```

Each function in the list gets the same `5`.
The list applicative combines the results into a list.

### 9.2 `liftA2` with functions

```haskell
ghci> liftA2 (+) (*2) (+3) 5
18
```

- `(*2) 5 = 10`
- `(+3) 5 = 8`
- `(+) 10 8 = 18`

### 9.3 `zipWith` via applicative

```haskell
ghci> (,) <$> (+1) <*> (*10) $ 5
(6, 50)
```

### 9.4 Fan-out to a tuple

```haskell
ghci> (,,) <$> (+1) <*> (*2) <*> (^2) $ 5
(6, 10, 25)
```

### 9.5 Fan-out to a list

```haskell
ghci> (\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5
[8.0,10.0,2.5]
```

### 9.6 Using the environment as a record

```haskell
data Config = Config { host :: String, port :: Int }

serverUrl :: Config -> String
serverUrl = \c -> host c ++ ":" ++ show (port c)

-- Applicative style:
serverUrl' :: Config -> String
serverUrl' = (\h p -> h ++ ":" ++ show p) <$> host <*> port
```

Here `host` and `port` are the "computations" that read the same `Config` environment.

---

## 10. Key Takeaways

| Concept         | Meaning                                                  |
| --------------- | -------------------------------------------------------- |
| `((->) r) a`    | A computation reading an `r` and producing an `a`        |
| `pure x`        | Ignore the environment, return `x`                       |
| `fmap f g`      | Compose: read env, apply `g`, then `f`                   |
| `f <*> g`       | Read env once, feed it to _both_ `f` and `g`, then apply |
| `<*>` chain     | Broadcasts the same environment to every branch          |
| Monad `>>=`     | Same idea, with `do`-notation sugar                      |
| Real-world name | The **Reader monad**                                     |

---

## 11. Common Confusions

1. **"Is `f x (g x)` a parameter list?"**
   No — it is nested function application, made possible by currying.

2. **"Why does `x` appear twice in the definition of `<*>`?"**
   Because `<*>` must feed the environment to both the function and its argument.

3. **"Why does `<$>` use composition?"**
   Because `fmap` for functions _is_ `(.)` — read env, apply inner, then outer.

4. **"Can the environment be a tuple or record?"**
   Absolutely — `((->) (Env, Config))` and similar work fine; that is how
   the Reader pattern scales in real code.

5. **"Is `((->) r)` the same as `Reader r`?"**
   Essentially yes. `Reader r a` is a `newtype` wrapper around `r -> a` with
   the same instances. The wrapper exists mainly to give clearer type errors
   and a distinct name.

---

## 12. Where You'll See This in Practice

- **Reader monad** in `mtl`/`transformers`.
- **Configuration passing** without explicit parameters.
- **Dependency injection** in Haskell.
- **`zipWithN`-style** code in `Data.List` (via `ZipList`).
- **Parsers** — `Parser a = String -> [(a, String)]` is
  a function applicative at heart, though not exactly
  `((->) r)` because of the extra structure.
- **Teaching example** in every serious Haskell course.

---

## 13. Type Summary Table

| Expression            | Type                                    | Notes              |
| --------------------- | --------------------------------------- | ------------------ |
| `pure`                | `a -> (r -> a)`                         | returns `const`    |
| `(<$>)`               | `(b -> c) -> (r -> b) -> (r -> c)`      | is `(.)`           |
| `(<*>)`               | `(r -> b -> c) -> (r -> b) -> (r -> c)` | duplicates the env |
| `g :: r -> a`         | reads env, produces `a`                 | a "computation"    |
| `f <$> g`             | `r -> (b -> c -> d)`                    | composition        |
| `f <$> g <*> h`       | `r -> (c -> d)`                         | two branches       |
| `f <$> g <*> h <*> i` | `r -> d`                                | three branches     |

---

## 14. Relationship to Other Instances

It is worth contrasting `((->) r)` with the other common applicatives:

- **`Maybe`**: combines by short-circuiting on `Nothing`.
- **`[]`**: combines by taking the Cartesian product.
- **`Either e`**: combines by short-circuiting on `Left`.
- **`((->) r)`**: combines by **sharing the environment** and applying the function.

The unifying idea is that `<*>` combines two "effects." For `((->) r)`, the effect
is _reading from a shared environment_.

---

## 15. Conclusion

The `((->) r)` applicative instance is not an obscure curiosity.
It is the formal underpinning of the Reader monad, it explains why
`<$>` for functions is composition, and it gives a precise answer to the
question "why does the same argument get fed to several partially applied functions?"

The answer is that `<*>` for functions **duplicates the environment**.
Every step in an applicative chain reads the same input and combines the
results. Currying makes this possible: a partially applied function is a value,
and that value can be applied to another argument. Once you see this pattern,
the `Reader` monad, configuration-passing idioms, and a great deal of idiomatic
Haskell all snap into focus.

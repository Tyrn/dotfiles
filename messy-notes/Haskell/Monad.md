# Why the Monad Exists

## The essential difference: sequencing with context

In most languages, you can write a sequence of operations and they
just happen in order:

    x = read_input()
    y = parse(x)
    z = compute(y)
    print(z)

Each line runs, produces a value, and the next line uses it.
Simple. The catch: this only works if every operation has the same
_kind_ of effect. All these operations can fail by throwing, all
can do IO, all are pure. There's no way to mix "this might fail"
with "this is pure" without some machinery.

The monad is that machinery. It says: **here's a way to sequence
operations that each carry a context, and the context is threaded
through automatically.**

The context is the essential idea. Not the bind operator, not the
laws, not `return`. The context. Everything else is plumbing.

## What "context" means

A monadic value `m a` is not just an `a`. It's an `a` _with
something else attached_:

- `Maybe a` — an `a` that might not be there.
- `Either e a` — an `a` that might have failed with an error `e`.
- `[a]` — several possible `a`s (nondeterminism).
- `IO a` — an `a` produced by an effectful action.
- `Reader r a` — an `a` computed with access to an environment `r`.
- `State s a` — an `a` computed while threading a mutable state `s`.
- `Writer w a` — an `a` computed alongside an accumulating log `w`.
- `Parser a` — an `a` parsed from input, possibly consuming it.

The `a` inside is the ordinary value. The `m` is the context. The
monad is the _protocol_ that lets you work with the `a` inside
while the context is handled for you.

## Why this matters, non-technically

In a language without monads, if you want to combine two operations
that each carry a context, you must handle the context at every
step:

    case readInput of
        Nothing -> Nothing
        Just x ->
            case parse x of
                Nothing -> Nothing
                Just y ->
                    case compute y of
                        Nothing -> Nothing
                        Just z -> Just z

Every `case` is bookkeeping. The interesting logic — read, parse,
compute — is buried under context handling. Add a second kind of
context, and the bookkeeping multiplies.

The monad collapses that. The same program in `do` notation:

    do
        x <- readInput
        y <- parse x
        z <- compute y
        return z

The `Nothing` propagation is handled by the monad's bind. The
program reads like the pure version. **The context is invisible at
the point of use, but present at the point of definition.** That's
the whole point.

## The fundamental reason for existence

Here is the answer, in one sentence:

> The monad exists to let you _sequence_ operations that carry a
> context, so that the context is composed automatically by the
> sequencing, and each operation can be written as if the context
> weren't there.

Everything else follows:

- **The laws** (left identity, right identity, associativity) exist
  so that the sequencing is _predictable_ — the same program always
  means the same thing, regardless of how you group the steps.
  Without the laws, "sequencing" would be ambiguous.
- **`return`/`pure`** exists so that a plain value can enter the
  monadic world — a step that does nothing to the context.
- **`>>=` (bind)** exists as the primitive that combines a monadic
  value with a function that produces another monadic value,
  running the second only when the first has produced its `a`.
  This is the operation that threads the context.
- **`do` notation** exists as syntactic sugar for chains of `>>=`,
  so the sequencing reads like ordinary imperative code.

## What makes it different from other abstractions

Compare with the alternatives in other languages:

**Exceptions.** An exception is a context — "might fail" — but
it's _implicit_ and _untyped_. You can't tell from
`parse :: String -> Tree` whether it throws. And you can't have a
"list of possible results" context, or a "state-threading" context,
in the same way. Exceptions are one hard-coded context.

**Null/Option.** `Option`/`Optional`/`?` types also carry "might
not be there," but they only handle that one context. You can't
generalize `?.` to work over any context — the chaining operator is
hard-wired to nullability.

**Promises/Futures.** Async is another context — "will be available
later" — but the `then`/`await` machinery is fixed. You can't reuse
it for a different context.

**Interfaces/generics.** A `Monad` typeclass is a _generic_
interface for "things that can be sequenced while carrying a
context." This is the key difference: monads are not a particular
context, they're a **pattern that any context can follow**. Maybe
is a monad, list is a monad, IO is a monad, parser is a monad,
state is a monad — all sharing the same sequencing protocol.

That's why Haskell's `do` notation works over all of them
uniformly:

    do
        x <- something
        y <- somethingElse
        return (x, y)

works whether `something` is in `Maybe`, `[]`, `IO`, `State s`, or
your own monad. The `do` block is the same. Only the context
differs.

## The philosophical core

In a language without monads, effects and contexts tend to be
**hard-wired into the language**. IO is a language feature.
Exceptions are a language feature. Null is a language feature.
Async is a language feature. Each one has its own syntax, its own
chaining operator, its own rules.

In Haskell, contexts are **ordinary types** and the sequencing is
**an ordinary typeclass**. IO, `Maybe`, `[]`, `State`, `Reader`,
`Parser`, and any context you can imagine all use the same
protocol, the same `do` notation, the same laws. The language
doesn't need a special feature for each effect. It has one feature
— the monad — that any effect can implement.

That's the fundamental reason the monad exists: to make
**sequencing with context** a first-class, user-definable, uniform
concept, rather than a collection of built-in, ad-hoc language
features.

## A short analogy

Think of `do` notation as a _template_. The template says "do
this, then this, then this, threading whatever is in the
background." The monad is the _interface_ that says what
"threading" means for a particular context. A `Maybe` monad
threads "might fail." A `[]` monad threads "multiple
possibilities." An `IO` monad threads "the real world."

The template is the same. The threading differs. That's why the
newcomer's instinct — "what's the point?" — is hard to answer from
the definitions alone: the definitions describe _how_, but the
_why_ is that the template is reusable, and that reusability is
what other languages lack.

## Why this is hard to see from tutorials

Most tutorials explain the mechanics: here's `>>=`, here's
`return`, here are the laws, here's `do`. That's fine as far as it
goes, but it answers "what is a monad" without answering "why
would anyone want one." The answer to the second question is:
**because you want one mechanism for sequencing with context, and
you want to be able to define new contexts without changing the
language.**

Everything else — the laws, the operator names, the `do` notation
— is engineering that makes that one idea precise and usable.

## A footnote: on the notion of steps

"Step" is the right word for what a monad sequences. It carries
exactly the right connotations:

- **Order** — steps happen one after another.
- **Dependency** — a later step can use what an earlier step
  produced.
- **Sequence** — steps form a chain, not a batch.

And it pairs naturally with the vocabulary of the three
abstractions:

- **Functor** — transforms the _contents_ of a structure. No
  steps.
- **Applicative** — combines _independent_ steps. The steps are
  side by side, neither determining the other.
- **Monad** — sequences _dependent_ steps. Each step can decide
  the next.

That's a clean three-level ladder, and "step" fits each rung:

- `fmap` doesn't sequence steps; it just maps over what's already
  there.
- `<*>` composes steps whose _structure_ is fixed in advance.
- `>>=` composes steps whose _structure_ depends on earlier
  results.

The word also avoids the pitfalls of both "event" (which suggests
asynchrony or callbacks) and "action" (which suggests IO
specifically — but `Maybe`, `State`, `Reader`, and `Parser` are
all monads without being actions). "Step" is neutral across
contexts. A `Maybe` step is "produce a value or fail." A `State`
step is "read/modify state and produce a value." An `IO` step is
"interact with the world." Same word, different context.

When the book says "monadic computation,"
reading it as "a step in a dependent sequence" will keep the
intuition grounded.

## When to reach for a monad

Recognize the shape, not the monad.

### You're in monad territory when three things hold at once

- **The steps form a chain, not a batch.** Each step depends on
  the result of the previous one — step _n+1_ is chosen or
  parameterized by step _n_'s output. This is sequencing, not
  mapping.

- **Each step carries an extra context that must be threaded
  through the whole chain.** Some examples:
  - a possible failure (`Maybe`, `Either e`)
  - a read-only environment (`Reader`)
  - a mutable state (`State`)
  - an effect on the world (`IO`)
  - a stream of consumed input (`Parser`)
  - a set of alternatives (`[]`)

- **That context has rules for how it combines.** The rules are
  what make the threading mechanical rather than ad hoc:
  - failure short-circuits the rest of the chain
  - state threads left to right
  - the environment is read-only and shared by all steps
  - effects happen in order
  - alternatives multiply, or short-circuit, depending on the
    context

When all three hold, you have a monad, whether or not you call it
one.

### The practical tell: bookkeeping you'd otherwise write

- Without a monad, you write the same unpack-repack pattern at
  every step:
  - `case ... of Nothing -> Nothing; Just x -> ...`
  - `let (a, s') = step s in let (b, s'') = step' a s' in ...`
  - passing `config` into every function and repeating it at
    every call site
  - checking that a parse succeeded before proceeding

- If you find yourself writing that pattern over and over, it _is_
  a monad in disguise. Naming it collapses the boilerplate into
  `do` notation and a bind.

- The signal is repetition, not complexity. A single unpack is
  fine. Ten of them in the same shape is a monad waiting to be
  named.

### The reason to use it

- **Uniformity, not power.** The same `do` block sequences
  `Maybe`, `IO`, `State`, `Reader`, `[]`, a parser, and any monad
  you write yourself.

- **One syntax, one mental model.** Learn "a step in a dependent
  chain, with a context," and it applies to every context you
  meet. `do`, `>>=`, `return`/`pure`, and the laws do not change
  between contexts.

- **A new context costs an instance, not a language feature.**
  Write a `Monad` instance for your own type, and it immediately
  gets `do` notation, `for`/`traverse`/`replicateM`, and
  everything else built on the interface.

### Why the alternative doesn't scale

Without a monad, each context gets its own hard-coded chaining
mechanism:

- `?.` for null
- `try`/`catch` for exceptions
- `await`/`then` for async
- explicit state passing for state
- explicit config passing for config
- explicit backtracking for parsing

- Each works. None generalizes.
- A new effect requires a new language feature, a new operator,
  and new rules to learn.
- Effects don't compose: you can't easily mix "might fail" with
  "reads config" with "does IO" without writing the plumbing by
  hand.

The monad is what you get when you notice that all of these are
the same pattern — sequencing with a context — and give the
pattern one name, one interface, and one notation.

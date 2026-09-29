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

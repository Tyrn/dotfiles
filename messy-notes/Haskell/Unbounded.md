# Bounded vs Unbounded Generation in QuickCheck

## Unbounded generation

An `Arbitrary` instance is **unbounded** when the recursive call to
`arbitrary` does not shrink the size budget. The canonical example,
from a hand-written list type:

    instance Arbitrary a => Arbitrary (List a) where
        arbitrary = do
            a <- arbitrary
            as <- arbitrary      -- no size reduction
            elements [Nil, Cons a as]

Here, `as <- arbitrary` generates a `List a` of whatever size
QuickCheck currently wants. That `List a`'s own `arbitrary` will
_again_ call `arbitrary` for its tail, and so on. The recursion
terminates only by luck — when `elements` happens to pick `Nil`.
There's no structural guarantee of termination.

QuickCheck does pass a **size parameter** to `arbitrary`, but it
only has effect if the instance _uses_ it. The plain `arbitrary`
call ignores it. `[]`'s own `Arbitrary` instance uses `sized`
internally (that's why `[Int]` is bounded), but a hand-written
recursive instance that doesn't use `sized` will keep growing.

## Bounded generation

A **bounded** `Arbitrary` instance explicitly consumes the size
budget and shrinks it on each recursive call:

    instance Arbitrary a => Arbitrary (List a) where
        arbitrary = sized go
          where
            go 0 = pure Nil
            go n = do
                a  <- arbitrary
                as <- go (n `div` 2)   -- budget halved
                elements [Nil, Cons a as]

Now `sized` captures the current budget `n`, and each recursive
call halves it. When `n` reaches `0`, `go` returns `Nil`
unconditionally. Depth is bounded by `log2 n`, so for QuickCheck's
default max size of 100, the deepest list is about 7 elements.

The `sized` function is the mechanism:

    sized :: (Int -> Gen a) -> Gen a

It hands you the current size and lets you decide how to spend it.

## Why QuickCheck's size grows during a run

QuickCheck doesn't use a fixed size. It **ramps up** over the
course of a property's 100 tests, from 0 to a maximum (100 by
default). The idea is to start with tiny values to catch trivial
bugs fast, and grow toward larger values to exercise edge cases.

That ramp is what turns an unbounded generator from "slow" into
"hangs." Early tests are tiny, so the recursion bottoms out
quickly by luck. As the size grows, each successive test generates
a bigger and bigger structure. By the time you're at test 60 or
70, the generated value is enormous, and the property that
_processes_ it becomes proportionally slower.

## Why `sequenceA composition` in particular blows up

`foldMap` and `fmap` traverse the structure once, so their cost is
linear in the structure's size. `sequenceA composition` does
something worse: it _reconstructs_ the structure wrapped in a
composed applicative, usually `Compose f g`. For a list of length
`n`, the composed form has `n` levels of nesting, and rebuilding
it requires traversing it while accumulating effects from both
applicatives. The cost can be quadratic in `n`, sometimes worse.

So an unbounded generator that produces a list of length 20 under
`foldMap` takes negligible time, but under `sequenceA composition`
takes seconds. And since QuickCheck keeps growing the size, the
time per test grows without bound, which is exactly the "slower
and slower until killed" pattern.

## What "budget" means in practice

The size parameter is just an `Int`. Its meaning is entirely up
to the instance:

- For `[]`, `size` controls the expected list length.
- For `Tree`, `size` controls depth (via `n div 2` at each level).
- For a fixed-arity type like `Three a b c`, `size` is irrelevant
  — the generator is bounded by construction.
- For a numeric type like `Int`, `size` bounds the magnitude
  (roughly, values in `[-size, size]`).

There's no universal rule for how much to shrink per recursive
call. The common choices are `n div 2` (depth `log2 n`),
`n div 3` (shallower), or `n - 1` (depth exactly `n`, linear —
fine for small `n` but expensive for larger types). `div` is the
safe default because it gives logarithmic depth, which stays small
even for large `n`.

## Recognizing the pattern

A useful diagnostic heuristic:

- **QuickCheck hangs or slows down over the course of a run** →
  suspect an unbounded `Arbitrary` for a recursive type.
- **It hangs in a _law_ that reconstructs the structure**
  (`sequenceA composition`, in particular) → confirm the
  suspicion.
- **The fix** → wrap the generator in `sized` and shrink the
  budget on each recursive call.

## The subtler case: bounded generator, expensive property

There's a second, rarer cause of the same symptom: the generator
is fine, but the _property itself_ is superlinear in the
structure's size, and the size ramp makes the later tests
expensive. This is what you'd hit if, say, `sequenceA composition`
on a depth-7 tree with 3 constructors per node were still slow —
`3^7` is about 2187 nodes, and the composed traversal of that is
genuinely heavy.

The fix for that case is different: reduce the maximum size
(`resize 20` around the generator) or lower the test count
(`-a 30`). It's a band-aid rather than a cure, and it's only
needed when the generator is already bounded but the property is
still expensive.

## A rule of thumb

If a type has a constructor that contains a value of the same
type (or of a type whose `Arbitrary` is recursive), its
`Arbitrary` instance must be written with `sized` or `resize`.
There is no exception. Any hand-written recursive `arbitrary`
that doesn't do this is a latent hang waiting for a slower
machine or a heavier law.

The corollary: if you're copying `Arbitrary` instances from a
book or tutorial, and the book's examples hang on your machine,
this is the first thing to check. The book's instances were
probably fine when written against an older QuickCheck, but the
size ramp and the default maximum have changed over the years,
and what passed then can fail now.

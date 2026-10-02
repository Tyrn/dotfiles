# NF and WHNF

Haskell evaluates lazily, which means two questions about a value
can have different answers:

- **Is it evaluated at all?**
- **How far has it been evaluated?**

Normal form (NF) and weak head normal form (WHNF) name two
different "how far" answers. The distinction matters because GHCi,
`seq`, `foldl'`, strict data fields, and performance reasoning all
depend on knowing which one is being asked for.

## Terms and thunks

When you write:

    let xs = [1, 2, 3]

nothing is computed yet. `xs` is a **thunk** — a suspended
computation plus the environment it needs. If you then ask for
`head xs`, the thunk is forced enough to produce `1`, and the rest
of the list remains a thunk.

A thunk is "not yet evaluated." The two forms below describe how
far a thunk has been driven once someone demands its value.

## Weak head normal form (WHNF)

An expression is in **WHNF** when the outermost constructor is
known. The parts inside may still be thunks.

Examples in WHNF:

    1                          -- a literal
    \x -> x + 1                -- a lambda
    Just (1 + 1)               -- constructor known; payload unevaluated
    1 : 2 : []                 -- first cons known; tail may be a thunk
    (1 + 1) :: Int             -- NO: outermost is (+), not a value

The last line is not in WHNF: `1 + 1` still has a function
application at the top, so its outermost constructor is unknown.
Once GHC evaluates it to `2`, it's in WHNF.

The key phrase: **WHNF stops at the first constructor.** For a
list, that means the first `:` (or `[]`). For a pair, that means
the outer `(,)`. For a `Maybe`, that means `Just` or `Nothing`.
Everything below the constructor is untouched.

## Normal form (NF)

An expression is in **NF** when it is _fully_ evaluated: no thunks
anywhere, at any depth.

Examples in NF:

    1
    \x -> x + 1                -- lambdas are already NF
    Just 2                     -- payload computed
    1 : 2 : 3 : []             -- all elements computed
    (1, 2)                     -- both components computed

Examples not in NF but in WHNF:

    Just (1 + 1)               -- WHNF; payload is a thunk
    1 : 2 : (3 + 3) : []       -- WHNF; the third element is a thunk
    (1, 1 + 1)                 -- WHNF; second component is a thunk

So NF is strictly stronger than WHNF: everything in NF is in WHNF,
but not conversely. WHNF is "outermost constructor known," NF is
"nothing left to compute."

## Why the distinction matters

The functions that force evaluation differ in how much they force.

- `seq a b` forces `a` to **WHNF**, then returns `b`.
- `a `deepseq` b` forces `a` to **NF**, then returns `b`.
- `foldl'` forces its accumulator to **WHNF** at each step.
- `foldr` forces nothing by itself; the combining function decides.

And `undefined` behaves differently depending on how far you look:

    ghci> let xs = [1, undefined, 3]
    ghci> head xs           -- 1     (tail untouched)
    ghci> length xs         -- 3     (elements untouched; spine forced)
    ghci> print xs          -- error (print forces every element)

`length` only walks the spine, so it never evaluates the
`undefined`. `print` shows every element, so it forces the whole
list to NF — and hits the `undefined`.

## GHCi and WHNF

GHCi evaluates each expression to **WHNF** before printing it. So:

    ghci> let xs = [1, 2, undefined]
    ghci> xs
    [1,2,*** Exception: Prelude.undefined

The result is shown as a list, but the third element blew up when
`print` tried to render it. GHCi's `:sprint` shows the thunks
without forcing them:

    ghci> :sprint xs
    xs = 1 : 2 : _

The `_` is an unevaluated thunk. `:sprint` is the tool for seeing
WHNF-level structure without committing to NF.

## The strictness story

Strictness is about _forcing_. A function `f` is strict in its
argument if `f undefined` is also `undefined` — that is, if `f`
forces the argument far enough to notice it's bottom.

- `seq` makes things strict in WHNF.
- `deepseq` makes things strict in NF.
- A `!` on a data field forces the field to WHNF when the
  constructor is built.
- `{-# LANGUAGE StrictData #-}` makes all fields strict (WHNF).
- `{-# LANGUAGE Strict #-}` makes all pattern matches and lets
  strict (WHNF).

None of these force to NF unless you ask with `deepseq` or
`force`.

## A practical rule

- Use **WHNF reasoning** when you care about whether a
  computation has started: does this `foldl'` avoid a chain of
  thunks, does this `seq` short-circuit, is this accumulator
  evaluated.
- Use **NF reasoning** when you care about whether a computation
  has _finished_: does this data structure still contain thunks
  that will bite later, does this `deepseq` actually eliminate the
  space leak, does serializing this value force everything.

Most performance bugs in lazy Haskell are either:

- a thunk chain building up because nothing forced to WHNF (fix
  with `seq` or `foldl'`), or
- a structure half-evaluated because nothing forced to NF, so
  later code pays the evaluation cost unexpectedly (fix with
  `deepseq` or `force`).

## The one-line summary

**WHNF** stops at the first constructor; **NF** goes all the way
down. `seq`, `foldl'`, and GHCi's print go to WHNF; `deepseq` and
`force` go to NF. Knowing which one a function forces is most of
lazy evaluation in practice.

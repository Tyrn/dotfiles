# Lists, `concatMap`, and Combinations

## The shape of a list

A list is either empty or a cons:

    data [a] = [] | a : [a]

This is the canonical recursive data type. Its `Monad`/`Applicative`
instances are built from that structure, and everything interesting
about `concatMap` follows from them.

## `concatMap`

    concatMap :: (a -> [b]) -> [a] -> [b]
    concatMap f xs = concat (map f xs)

Apply `f` to each element, getting a list of lists, then flatten.
That's the whole definition. But the interesting fact is that
`concatMap` is **`>>=` for lists**:

    instance Monad [] where
        xs >>= f = concatMap f xs

So `concatMap` is not just some helper — it _is_ the bind operation
of the list monad. Whenever you write `do` notation over lists, or
`>>=`, you're invoking `concatMap`. This is the key to its role in
combinations.

## The nondeterminism reading

The list monad is often described as **nondeterminism**: a list `[a]`
represents "a choice among several `a`s." Under that reading:

- `return x = [x]` — one choice, namely `x`.
- `xs >>= f` — for each choice in `xs`, run `f`, and collect _all_
  the resulting choices.

`concatMap` is exactly that: for each element of the input list,
generate a _list_ of possibilities, then concatenate them all. Each
element branches into several outcomes, and `concatMap` collects the
outcomes of all branches into a single flat list.

## Combinations via `do`

Suppose you want all pairs `(x, y)` with `x` from `[1,2,3]` and `y`
from `[4,5,6]`. In `do` notation over lists:

    pairs = do
        x <- [1,2,3]
        y <- [4,5,6]
        return (x, y)

Desugared, this is:

    [1,2,3] >>= \x -> [4,5,6] >>= \y -> return (x, y)

which expands to:

    concatMap (\x -> concatMap (\y -> [(x, y)]) [4,5,6]) [1,2,3]

Each `concatMap` introduces a new "loop": for each `x`, for each `y`,
produce one pair. The result is the Cartesian product, 9 pairs.

This is the fundamental pattern: **nested `concatMap` = nested loops
= combinations**. A `do` block over lists with `n` binds produces an
`n`-fold Cartesian product. Add a fourth bind, and you get quadruples.
Remove one, and you get singles.

## `Applicative` is the same thing, spelled differently

`<*>` for lists is also the Cartesian product:

    instance Applicative [] where
        pure x = [x]
        fs <*> xs = [f x | f <- fs, x <- xs]

So `(,) <$> [1,2,3] <*> [4,5,6]` is the same 9 pairs. And
`liftA2 (,) xs ys` is the same. All three spellings — `do`, `>>=`,
`<*>` — express the same operation, because the list `Monad` and the
list `Applicative` are consistent:

    mf <*> mx = mf >>= \f -> mx >>= \x -> return (f x)

You saw this in the `Reader` chapter's `sequenceA [x, y]` test, where
`sequenceA` over lists gives the Cartesian product of the elements'
possibilities:

    sequenceA [[1,2,3], [4,5,6]]
    -- [[1,4],[1,5],[1,6],[2,4],...,[3,6]]

That's `concatMap` at work again: for each way of picking an element
from the first list, for each way of picking from the second, produce
a pair.

## `sequenceA` and `traverse` are built on this

`sequenceA` for lists is defined by the same pattern:

    sequenceA :: Applicative f => [f a] -> f [a]
    sequenceA []     = pure []
    sequenceA (x:xs) = (:) <$> x <*> sequenceA xs

For the list applicative, this recursively builds all combinations:
for each value produced by `x`, for each combination produced by
`sequenceA xs`, prepend. That's `concatMap`-shaped recursion. For
`Maybe`, it short-circuits on `Nothing`; for `Either`, on `Left`.
Same structure, different applicative.

And `traverse f = sequenceA . map f`, so `traverse` over lists is
also `concatMap`-shaped.

## Why this is "fundamental"

Three reasons:

1. **It's the monadic bind of the list type.** Every use of list
   `do`-notation, `>>=`, `<*>`, `sequenceA`, `traverse`, `liftA2`,
   `replicateM`, `filterM`, and so on, ultimately reduces to nested
   `concatMap`. Understanding `concatMap` is understanding list
   monadic composition.

2. **It captures "for each ... for each ..." loops.** Any time you
   want to enumerate combinations — pairs, triples, all subsets, all
   arrangements, all paths through a tree — you're writing nested
   `concatMap`, whether you spell it that way or not. The `do` block
   over lists is the syntactic sugar for it.

3. **It generalizes.** The same pattern appears in:
   - **`traverse`** over a data structure (for each element of a
     structure, an effectful computation, and combine).
   - **parser combinators** (for each way of parsing the first part,
     try each way of parsing the second).
   - **logic programming** (each variable ranges over its domain, and
     constraints prune the products).
   - **SQL joins** (`FROM a, b` is Cartesian product, filtered by
     `WHERE`).
   - **list comprehensions**: `[(x, y) | x <- xs, y <- ys]` is
     `concatMap` in surface syntax.

So `concatMap` isn't just one function among many. It's the _list
monad's bind_, and once you see list comprehensions and `do` blocks
over lists as nested `concatMap`s, the whole family of "generate all
combinations" operations becomes one idea in different clothes.

## A small worked example

To generate all subsets of a list:

    subsets :: [a] -> [[a]]
    subsets []       = [[]]
    subsets (x:xs)   = concatMap (\rest -> [rest, x : rest]) (subsets xs)

For each subset `rest` of the tail, produce two possibilities: `rest`
(without `x`) and `x : rest` (with `x`). `concatMap` collects them
all. This is the same pattern as before: for each possibility in the
recursive result, branch into several alternatives, and flatten.

And to generate all permutations:

    perms :: [a] -> [[a]]
    perms []     = [[]]
    perms xs     = concatMap (\x -> map (x :) (perms (remove x xs))) xs

For each choice of first element `x`, for each permutation of the
rest, prepend `x`. That's `concatMap` again.

## The takeaway

`concatMap` is:

- syntactically, `concat . map`,
- semantically, the list monad's `>>=`,
- conceptually, "for each element, branch into possibilities, and
  collect all branches."

Once you internalize that, the `sequenceA` and `traverse` laws you
were testing in the `Traversable` chapter stop being separate facts
and become instances of one idea: the list applicative/monad is
combination, and `traverse`/`sequenceA` walk a structure while
performing that combination at each step.

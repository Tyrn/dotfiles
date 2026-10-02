# Reader

## The type

Start with an ordinary function:

    r -> a

Given an `r`, it produces an `a`. That's the raw material.

Now wrap it in a newtype and give it a name:

    newtype Reader r a = Reader { runReader :: r -> a }

Three things happened:

1. **We named the pattern.** "A function that reads from an `r`" is
   now a type called `Reader r a`, rather than an anonymous
   `r -> a`. Naming a pattern lets us talk about it, give it
   instances, and put it in a module.

2. **We added a constructor and a field.** `Reader` wraps the
   function; `runReader` unwraps it. They're inverses:

        Reader    :: (r -> a) -> Reader r a
        runReader :: Reader r a -> (r -> a)

   So `Reader` and `runReader` are just packaging and unpackaging.
   No computation happens at either step.

3. **We hid the function behind the wrapper.** Callers see a value
   of type `Reader r a`, not a bare `r -> a`. That matters because
   `r -> a` already has `Functor`, `Applicative`, and `Monad`
   instances, and wrapping gives us a _distinct_ type with its own
   instances, its own API, and a name we can use in type
   signatures without ambiguity.

The last point is the reason for the newtype. If `Reader r a` were
just a type synonym for `r -> a`, its instances would be the
function monad's, its API would collide with every other use of
`r -> a`, and it couldn't be a monad transformer (`ReaderT`). The
newtype makes it its own thing, at zero runtime cost.

So: `Reader r a` is a function `r -> a`, wrapped so that we can
give it a name and a set of instances. That's the whole
definition. The rest of this essay is about why anyone would want
that.

## The function monad, briefly

Step 3 above says `r -> a` "already has `Functor`, `Applicative`,
and `Monad` instances." Let me spell that out, because it's the
key fact behind `Reader` and it's easy to miss.

A value of type `r -> a` is a function that needs an `r`. Write it
as `g`. If you have two such functions, `g :: r -> a` and
`f :: a -> r -> b`, there's a natural way to combine them: run `g`
with the environment to get an `a`, then run `f` with that `a` and
the _same_ environment to get a `b`. That's the bind:

    instance Monad ((->) r) where
        g >>= f = \r -> f (g r) r

Read it left to right: `g >>= f` is a function that takes `r`,
applies `g` to it, then applies `f` to both the result and `r`.
The environment `r` is threaded to both `g` and `f`
automatically.

The other two instances are simpler:

    instance Functor ((->) r) where
        fmap f g = f . g

    instance Applicative ((->) r) where
        pure x = \_ -> x
        fg <*> gx = \r -> fg r (gx r)

`fmap` composes; `pure` ignores the environment; `<*>` runs both
functions on the same environment and combines the results.

This is the **function monad**: the monad structure on `r -> a`
that threads a shared environment through a chain of dependent
functions. It exists in `base`, it's fully lawful, and it's what
`Reader` wraps.

Once you see it, `ask` is trivial:

    ask :: Reader r r
    ask = Reader id

`id :: r -> r` is the function that returns its environment.
Wrapped in `Reader`, it's a computation that "reads" the
environment and returns it. That's the whole definition of `ask`.

## Why it exists

Suppose several functions all need the same configuration:

    data Config = Config
        { prefix  :: String
        , verbose :: Bool
        }

Without `Reader`, you pass `Config` explicitly everywhere:

    renderName :: Config -> String -> String
    renderName cfg s = prefix cfg ++ s

    renderAll :: Config -> [String] -> [String]
    renderAll cfg = map (renderName cfg)

Every function gains a `Config ->` parameter, and every call site
repeats `cfg`. The parameter is bookkeeping, not logic.

With `Reader`, the environment is implicit:

    renderName :: String -> Reader Config String
    renderName s = do
        cfg <- ask
        pure (prefix cfg ++ s)

    renderAll :: [String] -> Reader Config [String]
    renderAll = traverse renderName

At the top, you supply the environment once:

    runReader (renderAll ["a", "b"]) (Config ">> " False)

That's the point: the environment flows through the computation
without being mentioned at each step.

## The essential idea

Strip away the newtype, the instances, and the API, and `Reader`
comes down to one thing: **every function in the computation
receives the same extra parameter, the environment.**

Without `Reader`, you write that parameter by hand:

    renderName :: Config -> String -> String
    renderName cfg s = prefix cfg ++ s

    renderAll :: Config -> [String] -> [String]
    renderAll cfg = map (renderName cfg)

`cfg` appears in every signature and at every call site. That's
the parameter, made explicit.

With `Reader`, the parameter is still there — it has to be, because
the computation genuinely depends on it — but you don't write it.
The monad threads it through:

    renderName :: String -> Reader Config String
    renderName s = do
        cfg <- ask
        pure (prefix cfg ++ s)

    renderAll :: [String] -> Reader Config [String]
    renderAll = traverse renderName

At the top, `runReader m env` supplies the environment, and it
flows into every `ask` without being mentioned between them.

So the correct statement is:

> A `Reader r a` is a function `r -> a`, and a chain of `Reader`
> computations is a chain of functions that all take the same `r`.
> The monad exists so that the `r` is passed implicitly, rather
> than written into every signature and every call.

The parameter is the substance; the monad is the plumbing that
hides it. Both are true, and the second is why the first is worth
having a name for.

## The API

- `ask` — read the environment.
- `asks f` — read the environment and apply `f`.
- `local f m` — run `m` with a modified environment.
- `runReader m r` — run the computation with environment `r`.

The last one is the only way to get the result out; a `Reader` on
its own is just a suspended computation waiting for an
environment.

## From (->) to Reader

The function type `(->) r` is already a `Functor`, `Applicative`,
and `Monad`, as shown above. So `Reader r a` is `(->) r a` under a
newtype, with `ask` defined as `Reader id`, and `local` defined as:

    local :: (r -> r) -> Reader r a -> Reader r a
    local f m = Reader (\r -> runReader m (f r))

Reading it: `local f m` is a `Reader` that, given an environment
`r`, first applies `f` to get a modified environment, then runs
`m` with that modified environment. The modification is scoped to
`m`; when `m` returns, the outer environment is untouched.

The name `local` is apt: it makes a change to the environment that
is local to the computation it wraps.

## A short example

    module ReaderDemo where

    import Control.Monad.Reader

    data Config = Config
        { greeting :: String
        , excited  :: Bool
        } deriving (Eq, Show)

    greet :: String -> Reader Config String
    greet name = do
        cfg <- ask
        let mark = if excited cfg then "!" else "."
        pure (greeting cfg ++ ", " ++ name ++ mark)

    greetAll :: [String] -> Reader Config [String]
    greetAll = traverse greet

    -- local: temporarily change the environment
    greetLoudly :: String -> Reader Config String
    greetLoudly name = local (\c -> c { excited = True }) (greet name)

Running it:

    runReader (greetAll ["Ada", "Alan"]) (Config "Hello" False)
    -- ["Hello, Ada.", "Hello, Alan."]

    runReader (greetLoudly "Ada") (Config "Hello" False)
    -- "Hello, Ada!"

## Testing with Hspec

The tests are ordinary — `Reader` is a pure computation, so
`runReader m env` produces a plain value that Hspec can compare.

    module ReaderDemoSpec where

    import Test.Hspec
    import Control.Monad.Reader
    import ReaderDemo

    cfg :: Config
    cfg = Config "Hello" False

    spec :: Spec
    spec = do
        describe "greet" $ do
            it "uses the greeting from the environment" $
                runReader (greet "Ada") cfg `shouldBe` "Hello, Ada."

            it "appends '.' when not excited" $
                runReader (greet "Ada") cfg `shouldBe` "Hello, Ada."

            it "appends '!' when excited" $
                runReader (greet "Ada") (cfg { excited = True })
                    `shouldBe` "Hello, Ada!"

        describe "greetAll" $ do
            it "greets every name" $
                runReader (greetAll ["Ada", "Alan"]) cfg
                    `shouldBe` ["Hello, Ada.", "Hello, Alan."]

            it "respects the environment" $
                runReader (greetAll ["Ada"]) (cfg { excited = True })
                    `shouldBe` ["Hello, Ada!"]

        describe "local" $ do
            it "temporarily overrides the environment" $
                runReader (greetLoudly "Ada") cfg
                    `shouldBe` "Hello, Ada!"

            it "does not affect the outer environment" $ do
                let pair = do
                        a <- greet "Ada"
                        b <- greetLoudly "Alan"
                        c <- greet "Bob"
                        pure [a, b, c]
                runReader pair cfg
                    `shouldBe` ["Hello, Ada.", "Hello, Alan!", "Hello, Bob."]

The last test is the important one: it checks that `local` is
scoped. Inside `greetLoudly`, `excited` is `True`; after it
returns, the environment is unchanged. That's the property that
makes `local` useful and that distinguishes `Reader` from a
global variable.

## Why Reader is worth knowing

- **It names a pattern.** "Functions that all need the same
  configuration" is common enough to deserve a type.
- **It composes.** `Reader Config` is a monad, so you can
  sequence reads, combine them with `traverse`, and nest them in
  transformers (`ReaderT`).
- **It generalizes.** The function monad `(->) r` is the same
  thing, and once you see `Reader` as `(->) r`, the two stop
  feeling like separate ideas.
- **It has a clean testing story.** Run the computation with a
  fixed environment and compare the result. No mocks, no state to
  reset, no IO.

## The one-line summary

`Reader r a` is `r -> a`. The monad is the function monad, `ask`
is `id`, and `local` is `\f m -> Reader (\r -> runReader m (f r))`.
It exists so that a shared environment can be threaded through a
computation without being mentioned at every step, and it is
tested by running the computation with a chosen environment and
comparing the plain value that comes out.

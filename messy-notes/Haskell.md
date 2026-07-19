## Haskell

### Resources

#### Essential tutorials

-[Allen & Moronuki, Haskell programming from first principles](https://github.com/larrybotha/haskell-book) GitHub

-[Learn You a Haskell for Great Good!](http://learnyouahaskell.com/chapters)

-[Functors, Applicatives, And Monads In Pictures](http://adit.io/posts/2013-04-17-functors,_applicatives,_and_monads_in_pictures.html)

#### Misc

-[GitHub resources](https://github.com/chemouna/HaskellResources)

-[Fold, or Reduce](https://wiki.haskell.org/Fold), Wiki

-[Packages by category](http://hackage.haskell.org/packages/)

-[Applications and libraries/Data structures](https://wiki.haskell.org/Applications_and_libraries/Data_structures)

-[Awesome Haskell](https://github.com/krispo/awesome-haskell), GitHub

-[Turtle usage](https://stackoverflow.com/questions/35463892/haskell-turtle-command-line-parser)

-[What is () in Haskell, exactly?](https://stackoverflow.com/questions/16892570/what-is-in-haskell-exactly)

### Tools

-[Haskell Docker image by FP Complete](https://hub.docker.com/r/fpco/stack-build/); [Docker integration](https://docs.haskellstack.org/en/stable/docker_integration/)

-[template-haskell](https://github.com/jonascarpay/template-haskell)

#### [GHCup](https://github.com/haskell/ghcup-hs)

- Relevant paths: `~/.ghcup`, `~/.zshenv`

- Intro

```
$ yay -S ghcup-hs-bin
$ ghcup -h
$ ghcup tui
```

The essentials: `ghc`, `hls`, `stack`, `cabal`; Neovim may need
`cabal`, and have it's own `hls`

- Command line usage, examples

```
ghcup set ghc <version>
ghcup set stack <version>
ghcup set hls <version>
ghcup install cabal latest
```

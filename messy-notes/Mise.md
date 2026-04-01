# Mise tool manager

[:github:](https://github.com/jdx/mise)

## Tips and tricks

- Why is it slow?

```
MISE_TRACE=1 mise hook-env
```

- If `eval "$(mise activate zsh)"` is really slow,
  one can change it to

```
export PATH="$HOME/.local/share/mise/shims:$PATH"
```

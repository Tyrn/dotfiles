# Fonts

## Notes

- As long as Alacritty is configured for
  `FiraCode Nerd Font`, `extra/ttf-firacode-nerd`
  is enough

```
sudo pacman -S ttf-firacode-nerd
```

## Howto

- See the golden star

```
echo -e "\u2B50\uFE0F"
```

- Get some info about what you have

```
fc-list : family | grep -i "nerd" | uniq
```

```
fc-list : family | grep -i "nerd"
```

```
fc-match -s "monospace" | head -n 20
```

- Update cache

```
fc-cache -fv
```

```
fc-cache -rfv
```

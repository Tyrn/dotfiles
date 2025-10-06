# Husky GitHub Hook

## Remove Husky from a JS project

- Force a commit, if necessary

```
git commit -am 'First commit' --no-verify
```

- Remove the package and configuration

```
pnpm remove husky
git rm -rf .husky/
```

- Clean up `husky` traces from `package.json`

Minimal reproduction repository for https://github.com/renovatebot/renovate/discussions/29237

## Context

My overall goal is that I want to pull in multiple package updates from the
[catppuccin-toolbox](https://github.com/catppuccin/toolbox) monorepo.

I have multiple custom tags/releases being published. E.g.
[whiskers-v2.3.0](https://github.com/catppuccin/toolbox/releases/tag/whiskers-v2.3.0)
and
[catwalk-v1.3.0](https://github.com/catppuccin/toolbox/releases/tag/catwalk-v1.3.1).
I have been able to identify these tags/releases with my renovate.json shown
below:

## `renovate.json` Config

Shown below is the configuration of [renovate.json](./renovate.json).

```json
{
  "$schema": "https://docs.renovatebot.com/renovate-schema.json",
  "extends": ["config:recommended"],
  "packageRules": [
    {
      "matchPackageNames": ["catppuccin/toolbox"],
      "versioning": "regex:^(?<depName>\\w+-)?v(?<major>\\d+)\\.(?<minor>\\d+)\\.(?<patch>\\d+)?$"
    }
  ]
}
```

## Actual Behaviour

- **Detected Dependencies**

  ```md
  <details><summary>Formula/catwalk.rb</summary>

  - `catppuccin/toolbox catwalk-v1.3.0`

  </details>

  <details><summary>Formula/whiskers.rb</summary>

  - `catppuccin/toolbox whiskers-v2.1.0`

  </details>
  ```

- **Branches Created**

  - `renovate/catppuccin-toolbox-2.x`
  - `renovate/catppuccin-toolbox-1.x`

- **Pull Requests Created**

  - `chore(deps): update homebrew formula catppuccin/toolbox to vwhiskers-v2.3.0`: This is incorrect as it updates both `whiskers.rb` and `catwalk.rb`, also starts with prefix `v`.
  - `chore(deps): update homebrew formula catppuccin/toolbox to catwalk-v1.3.1`

## Expected Behaviour

- **Detected Dependencies**

  ```md
  <details><summary>Formula/catwalk.rb</summary>

  - `whiskers catwalk-v1.3.0`

  </details>

  <details><summary>Formula/whiskers.rb</summary>

  - `catwalk whiskers-v2.1.0`

  </details>
  ```

- **Branches Created**

  - `renovate/whiskers-2.x`
  - `renovate/catwalk-1.x`

- **Pull Requests Created**

  - `chore(deps): update homebrew formula whiskers to whiskers-v2.3.0`: This
    should only update `whiskers.rb`
  - `chore(deps): update homebrew formula catwalk to catwalk-v1.3.1`: This
    should only update `catwalk.rb`

## What I've Tried

- I've tried to change the `<depName>` from the `versioning` key to
  `packageName`. Observed no change in behaviour.

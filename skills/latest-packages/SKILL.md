---
name: latest-packages
version: 1.0.0
description: Ensure agents always reference the latest package versions
triggers:
  - install
  - package
  - dependency
  - npm install
  - pip install
  - version
---

# Latest Package Versions

Always use the `lucid_check_package` tool before recommending or installing any package.

## When to activate

- User asks to install a package
- User asks about package versions or compatibility
- Writing dependency files (package.json, requirements.txt, Cargo.toml)
- Recommending libraries or frameworks

## Required behavior

1. Call `lucid_check_package` with the package name before suggesting a version
2. Always recommend the latest stable version unless the user specifies otherwise
3. Flag any known deprecations or breaking changes
4. Include version constraints appropriate for the ecosystem

## Examples

- `lucid_check_package({ name: "next", registry: "npm" })`
- `lucid_check_package({ name: "fastapi", registry: "pypi" })`
- `lucid_check_package({ name: "tokio", registry: "cargo" })`

## Anti-patterns

- Never hardcode a package version from training data
- Never assume a package is still maintained without checking
- Never recommend a version without verifying it exists
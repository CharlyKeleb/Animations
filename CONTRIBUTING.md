# Contributing

Thanks for taking a look! This repository is a collection of Flutter UI / CustomPaint demos.

## Project structure (high level)

- `lib/app/` — app shell: theme, routing, demo catalog.
- `lib/<demo>/` — individual demos (legacy layout; incremental cleanup).
- `assets/` — images & lottie files.

## Adding a new demo

1. Create a new folder under `lib/` (or `lib/features/<your_demo>/...` if you follow the new structure).
2. Expose a single **entry widget** (prefer `SomethingPage` or `SomethingHome`).
3. Register it in `lib/app/demo_registry.dart`.
4. (Optional) Add tags for search.

## Style guidelines

- Prefer `const` widgets when possible.
- Avoid creating a nested `MaterialApp` inside a demo.
- Keep files in `lower_snake_case.dart`.

## Quality gates

Before opening a PR:

- `flutter analyze`
- `flutter test`


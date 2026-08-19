---
name: ulx-lab-handoff
description: Structure ulx-lab screens so a developer can copy presentational .gjs into Eventz without regenerating the UI. Use when adding screens, reviewing transfer readiness, or documenting Eventz copy steps.
---

# ULX Lab handoff

## Goal

Designer/PM prompts produce **one** presentational screen. A developer copies that file into Eventz and only wires data, save, and i18n. Do not regenerate the layout in Eventz.

## Lab shape (keep this)

```
app/components/screens/<name>.gjs   # transferable
app/components/commons/             # page chrome (home/event top + left bars)
app/mocks/<name>.js                 # lab-only fixture
app/templates/screens/<name>.gjs    # lab-only glue (toasts, mock wiring)
app/data/screens.js                 # register the screen
```

Wrap new full pages in `HomePageTemplate` or `EventPageTemplate` from `app/components/commons/`.

Presentational component args:

- `@model` — plain object (Eventz will pass a real model with the same fields)
- `@onSave` — called with the payload; lab may toast, Eventz saves
- `@onCancel` — discard; Eventz closes the overlay
- Tunable ULX args such as `@size` and `@width` — lab controls bind these; Eventz can pass them or rely on the default
- Add more args only when the screen needs them (`@onDelete`, `@isSubmitting`, …)

Lab-only inspector (do not copy):

```
app/components/lab/app-bar.gjs
app/components/lab/arg-controls.gjs
app/data/controls/<screen>.js
app/data/screen-settings.js
app/data/uls-tokens/
```

The demo route is the screen. Configure it from **Settings** in the application top bar (opens a slide pane). When a designer changes a control, `/__lab/persist-args` updates the `SCREEN_DEFAULTS` block in the presentational `.gjs`. That file is what Eventz copies. Do not regenerate the screen.

## What transfers

- `app/components/screens/*.gjs` layout, ULX usage, utilities, `@dataQa` names
- Keep `@dataQa` values stable across the copy

## What the Eventz developer does (do not do this in the lab)

1. Copy the screen `.gjs` into the target Eventz Ember app (usually `webapps/applications/editor/app/components/`).
2. Rewrite barrel imports to Eventz deep paths, for example:
   `import UlxButton from "ulx-components/components/ulx-button/index";`
3. Replace English literals with Eventz i18n keys.
4. Wire `@model` to Ember Data / existing objects. Keep field names aligned with the mock.
5. Make `@onSave` **return a promise** when used as `UlxSlidePane` `@onDone` (full save chain, no fire-and-forget).
6. Do not re-prompt an AI to rebuild the same screen in Eventz.

## What never transfers

- `app/mocks/`
- Lab routes, `app/data/screens.js`, application chrome
- Ember 6.8-only APIs if they appear — avoid them in screens so copy stays small

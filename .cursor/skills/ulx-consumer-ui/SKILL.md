---
name: ulx-consumer-ui
description: Build or style application UI that consumes ULX (not implementing the component library source). Use when wiring screens, layouts, or demos with ULX components, design-system utilities, and approved overrides while avoiding unnecessary custom CSS or brittle selectors.
---

# ULX consumer UI

## Use this skill when

- Building or updating **lab screens** that **import and use** ULX components
- Choosing layout, spacing, feedback, and wrapper markup around ULX components
- Styling on the **consumer** side (`app/` templates), not inside `ulx-components`

## Do not use this skill when

- Implementing or refactoring components inside the ULX library source tree — do not edit `ulx-components`

## Required context

1. Read **`.cursor/rules/lab-essentials.mdc`** and **`.cursor/rules/ulx-ui.mdc`**.

## Workflow

1. Clarify the interaction: form, dense data, or general interactive UI.
2. If the right control is unclear, use **`ulx-component-discovery`** first.
3. Then follow the matching pattern skill:
   - **Forms** → `ulx-form-patterns`
   - **Overlays, navigation, selection, feedback, loading** → `ulx-ui-patterns`
   - **Tables, lists, cards, media, toolbars** → `ulx-data-display-patterns`
4. Prefer ULX component arguments and existing utilities. Do not add new CSS files or inline styles.
5. Put transferable UI in `app/components/screens/`. Put static data in `app/mocks/`. Register the screen in `app/data/screens.js`.

## Named Blocks

- **Only use named blocks when a component explicitly requires them** (e.g. `<:header>`, `<:footer>`, `<:icon>`, `<:actions>`).
- Do **not** wrap simple content in a named block when the component accepts it as a plain argument (`@label`, `@value`, etc.) or plain yielded default content.
- If any named block exists, body goes in `<:default>`.

## Checklist

- No unnecessary new CSS files or inline styles when a component API or utility already exists
- No brittle app CSS targeting undocumented internal ULX structure
- Lab screens use plain English literals (Eventz i18n is a later handoff step)
- No named blocks used where a plain argument or default yield is sufficient
- No Eventz models, routes, or APIs

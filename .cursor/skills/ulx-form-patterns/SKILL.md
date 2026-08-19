---
name: ulx-form-patterns
description: Build forms with ulx-components using established composition patterns. Use when creating or updating forms with UlxForm, UlxFieldSet, UlxField, UlxInput, UlxTextarea, UlxDropdown, UlxMultiSelect, validation, labels, errors, and grouped field layouts.
---

# ULX Form Patterns

## Use this skill when

- Creating or updating a form in this Ember lab app
- Wiring labels, errors, validation, and submit behavior
- Grouping related fields into clear sections
- Choosing between ULX form controls for a field

## Lab contract

- Presentational form in `app/components/screens/`.
- Args: `@model`, `@onSave`, `@onCancel` (add more only when the screen needs them).
- Static fixture in `app/mocks/`. Route template shows toasts or other lab-only glue.
- Plain English labels. No Eventz i18n keys in the lab.

## Core composition model

- `UlxForm` is the outer form container (`@onSubmit`, optional `<:actions>`)
- `UlxFieldSet` groups related controls into a semantic section
- `UlxField` wraps one labeled and validated field
- The actual control receives the yielded `field` object from `UlxField`

## Standard workflow

1. Clone `app/components/screens/ticket-class-form.gjs` when adding a similar form.
2. Start with `UlxForm` for submit behavior, form sizing, and actions.
3. Use `UlxFieldSet` for grouped sections such as profile, billing, location, or permissions.
4. Use `UlxField` for each field that needs labels, errors, tooltip text, rules, or yielded field wiring.
5. Choose the control that matches the input shape and interaction model.
6. Use tracked state and `@action` handlers for updates.
7. Check labels, helper text, placeholders, disabled states, validation, and keyboard flow.

## Common patterns

- `UlxField` + `UlxInput`
- `UlxField` + `UlxTextarea`
- `UlxField` + `UlxDropdown`
- `UlxField` + `UlxMultiSelect`
- `UlxField` + `UlxCheckbox`
- `UlxField` + `UlxRadio`
- `UlxField` + `UlxToggle`
- `UlxField` + `UlxPassword`
- `UlxFieldSet @customClass="ulx-grid ..."` (e.g. column templates and gap) for denser layouts
- `UlxFieldSet @customClass="flex flex-col ..."` for simpler vertical groups

## Verification

1. Submit, reset, and validation flows still behave correctly.
2. The field label, description, error, and control stay connected semantically.
3. Grouped fields use `UlxFieldSet` where the section has a meaningful legend.
4. The component choice still fits the data shape and the number of choices.

# ULX Lab agent guide

This repository is an Ember 6.8 **consumer** of `ulx-components`. It is not Eventz and it is not the component library.

## Do

- Implement only under `ulx-lab`.
- Put transferable UI in `app/components/screens/*.gjs` with args (`@model`, `@onSave`, `@onCancel`, plus tunable ULX args such as `@size`).
- Put shared page chrome in `app/components/commons/` (`home-page-template`, `event-page-template`, plus home/event top and left bars). New pages yield into those templates.
- Put static data in `app/mocks/`.
- Register new screens in `app/data/screens.js` and `app/router.js`.
- Put live property controls in the application Settings slide pane (`app/components/lab/app-bar.gjs`, `app/data/controls/` + `app/data/screen-settings.js`). Demo pages stay demos. `LabArgControls` `@screenId` writes `SCREEN_DEFAULTS` in the screen `.gjs`. Do not regenerate a screen to change size, variant, or width. Modal sizes come from ULS `dialog.less` (`optionsFrom: 'dialog.sizes'`), not a hardcoded list.
- Use barrel imports: `import { UlxButton } from 'ulx-components';`
- Use ULS/ULX utility classes only. No new CSS files or inline styles.
- Use plain English literals and `@dataQa` on interactive controls.
- Follow `.cursor/rules/lab-essentials.mdc` and `.cursor/rules/ulx-ui.mdc`.

## Do not

- Edit Eventz or `ulx-components/src`.
- Call real APIs or use Ember Data on screens.
- Regenerate a lab screen after it is copied into Eventz — hand off the file.

## Skills

- `ulx-component-discovery` — which ULX control
- `ulx-consumer-ui` — layout and utilities
- `ulx-form-patterns` — forms
- `ulx-ui-patterns` — overlays, menus, feedback
- `ulx-data-display-patterns` — tables, lists, cards
- `ulx-lab-handoff` — Eventz copy contract

Sibling demos (read-only): `../ulx-components/ulx/src/demo/ulx-ember/app/components/Demo/`.

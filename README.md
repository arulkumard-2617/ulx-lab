# ULX Lab

Ember 6.8 app for **presentational ULX screens** with static data. Designers and PMs prompt here. Developers later **copy** `app/components/screens/*.gjs` into Eventz instead of regenerating the UI.

This repo is parallel to `ulx-components`. Do not edit Eventz or the component library from this workspace.

A designer/PM wrapper app (hosted preview, no terminal) is later work. v1 is `ember serve` plus Cursor prompts.

## Setup

Sibling layout (local development):

```text
ulx/
  ulx-components/   # library (already built / npm installed)
  ulx-lab/          # this app
```

```sh
cd ulx-lab
npm install
npm start
```

Open [http://localhost:4200](http://localhost:4200).

`ulx-components` is `file:../ulx-components`. For a clone that is not a sibling, switch that dependency to the same git URL Eventz uses:

`git+https://zrepository.zohocorpcloud.in/zohocorp/eventz/ulx-components.git#master`

LESS compiles the **editor** theme (`ulx-editor.less`) so screens match Eventz editor.

## Example prompts

- Build a ticket class form with static data (see the seed screen).
- Add a session list using `UlxTable` and a mock array.
- Add a confirm delete modal around the ticket class form; keep the form presentational.

The agent should write `app/components/screens/`, `app/mocks/`, a route, `app/data/controls/` when the screen has tunable ULX args, and an entry in `app/data/screens.js`.

## Settings (writes code)

Demo pages are demos. Use **Settings** in the thin top bar (every page). It opens a slide pane for the current screen.

The inspector saves into the screen file (a `SCREEN_DEFAULTS` block in `app/components/screens/*.gjs`). Modal size options come from ULS `dialog.less` (xs through huge), generated at build into `app/data/uls-tokens/dialog.js`. After you change a property, open the screen file: `@size` default is the value you picked. Copy that file to Eventz.

Requires `npm start` (`ember serve`). The save endpoint is `/__lab/persist-args`.

## Layout

```text
app/components/screens/   transferable presentational .gjs
app/components/lab/       lab-only chrome (top bar, settings pane; do not copy)
app/mocks/                static fixtures (lab only)
app/data/screens.js       home-page registry
app/data/controls/        live property schemas (lab only)
app/data/screen-settings.js  maps screens to schemas
app/data/uls-tokens/      generated from uls_v2 (do not edit)
app/templates/screens/    lab-only glue (toasts, mock wiring)
```

Seed screen: [Ticket class form](http://localhost:4200/screens/ticket-class-form).

## Copy into Eventz

1. Copy `app/components/screens/<name>.gjs` into the Eventz Ember app.
2. Rewrite barrel imports to Eventz deep paths (`ulx-components/components/ulx-button/index`).
3. Replace English literals with i18n keys.
4. Wire `@model` / `@onSave` / `@onCancel` to real data. If the screen sits in `UlxSlidePane`, `@onSave` must return the save promise.
5. Keep `@dataQa` names. Do not regenerate the layout in Eventz.

See `.cursor/skills/ulx-lab-handoff/SKILL.md`.

## Out of scope (later)

- Designer/PM wrapper around this same Ember app
- Automated copy into Eventz
- Matching Eventz Ember 3.28 in this lab

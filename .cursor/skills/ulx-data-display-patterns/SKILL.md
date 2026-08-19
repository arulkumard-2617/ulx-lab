---
name: ulx-data-display-patterns
description: Present structured data and content with ulx-components. Use when building lists, tables, cards, timelines, toolbars, avatars, images, or data-heavy screens and choosing the right ULX display pattern.
---

# ULX Data Display Patterns

## Use this skill when

- Building a list, grid, card view, or table
- Presenting records, entities, or timeline data
- Choosing between dense and lightweight data layouts
- Composing supporting display elements around structured content

## Covered components

- `UlxTable`
- `UlxDataView`
- `UlxCard`
- `UlxToolbar`
- `UlxTimeline`
- `UlxAvatar`
- `UlxAvatarGroup`
- `UlxImage`

## Workflow

1. Start from the data shape: rows, cards, media, timeline entries, or a mixed detail view.
2. Choose the densest component that still preserves readability and interaction clarity.
3. Look at existing lab screens or sibling demos before inventing a layout.
4. Use toolbars, cards, avatars, and images to support the primary data view instead of building one-off wrappers.
5. Keep loading, empty, progress, and message states consistent with `ulx-ui-patterns`.
6. If the main question is which component best fits the use case, switch to `ulx-component-discovery`.
7. Feed tables and lists from `app/mocks/`, not Ember Data.

## Decision hints

- Large or sortable tabular datasets usually fit `UlxTable`
- Repeated card or tile layouts usually fit `UlxDataView` or `UlxCard`
- Chronological or milestone content usually fit `UlxTimeline`
- Entity identity and presence cues usually fit `UlxAvatar` or `UlxAvatarGroup`
- Standalone media presentation usually fit `UlxImage`

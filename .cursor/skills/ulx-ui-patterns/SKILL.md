---
name: ulx-ui-patterns
description: Build interactive ULX application UI outside basic form composition. Use when choosing or wiring ULX components for selection, overlays, menus, navigation, messaging, loading states, actions, or small status displays.
---

# ULX UI Patterns

## Use this skill when

- Building non-form interactive UI with ulx-components
- Choosing between segmented selection, menus, overlays, and navigation components
- Adding status, feedback, loading, or lightweight display elements
- Replacing raw HTML controls or ad hoc widgets with ULX equivalents

## Covered component families

- Selection and choice: `UlxOptionSegment`, `UlxSelectButton`, `UlxSegment`, `UlxSegmentsGroup`, `UlxSlider`, `UlxRating`, `UlxSorter`
- Overlays and containers: `UlxModal`, `UlxSlidePane`, `UlxPopup`, `UlxTooltip`, `UlxAccordion`
- Menus and navigation: `UlxPanelmenu`, `UlxTieredmenu`, `UlxTabmenu`, `UlxSteps`, `UlxSplitButton`, `UlxButton`, `UlxIconButton`
- Feedback and micro-display: `UlxToast`, `UlxMessage`, `UlxBannerMessage`, `UlxBadge`, `UlxChip`, `UlxTag`, `UlxEmptyState`, `UlxSkeleton`, `UlxProgressBar`, `UlxProgressspinner`, `UlxDivider`

## Workflow

1. Identify the interaction model first: choose, reveal, navigate, notify, or show loading/state.
2. Search existing lab screens or sibling demos before inventing a new pattern.
3. Prefer the highest-level ULX component that already matches the behavior.
4. Keep the control semantics correct: buttons act like buttons, menus behave like menus, and overlays manage focus responsibly.
5. Reuse existing ULX subcomponents instead of composing raw HTML plus classes where a first-class component exists.
6. Prefer direct component APIs such as `@iconLeft`, `@iconRight`, `@label`, and similar affordances before reaching for named blocks.
7. Use named blocks only when the component needs custom markup or composition beyond what direct arguments support.
8. If the UI is primarily data presentation, switch to `ulx-data-display-patterns`.
9. If the right component is unclear, switch to `ulx-component-discovery`.

## Decision hints

- Many options with filtering or large lists usually point to form or data patterns, not segmented controls.
- Full-page or task-blocking content usually points to `UlxModal` or `UlxSlidePane`.
- Contextual, lightweight actions usually point to `UlxPopup`, `UlxTooltip`, or menu components.
- Status pills, inline metadata, and lightweight notices should use the existing feedback/display components instead of custom markup.

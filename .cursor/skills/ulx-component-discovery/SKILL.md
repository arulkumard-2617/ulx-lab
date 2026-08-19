---
name: ulx-component-discovery
description: Recommend the right ulx-components component for a UI use case. Use when the user is unsure which ULX component to choose, wants alternatives compared, or needs guidance based on behavior, layout, interaction, and accessibility needs.
---

# ULX Component Discovery

## Use this skill when

- The user describes a UI problem but not a specific ULX component
- Multiple ULX components seem plausible
- A team wants help choosing the best interaction model before implementation

## Workflow

1. Search existing lab screens and sibling demos first:
   - `app/components/screens/`
   - `../ulx-components/ulx/src/demo/ulx-ember/app/components/Demo/`
2. Identify the primary need: form input, selection, overlay, navigation, feedback, or data display.
3. Recommend the best-fit ULX component first.
4. Mention at most 1-2 alternatives when the tradeoff is real.
5. Explain the recommendation in terms of behavior, scale, complexity, and accessibility.
6. Route the follow-up work to the matching skill:
   - **Application UI consumption** → `ulx-consumer-ui` and `.cursor/rules/lab-essentials.mdc`
   - `ulx-form-patterns`
   - `ulx-ui-patterns`
   - `ulx-data-display-patterns`

## Recommendation format

- Best fit component
- Why it fits
- Main tradeoff or limitation
- Next skill or implementation path to follow

## Common comparisons

- `UlxDropdown` vs `UlxMultiSelect`
- `UlxOptionSegment` vs `UlxSelectButton`
- `UlxCheckbox` group vs `UlxOptionSegment`
- `UlxModal` vs `UlxSlidePane` vs `UlxPopup`
- `UlxTable` vs `UlxDataView` vs `UlxCard`

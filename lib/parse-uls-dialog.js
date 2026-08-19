'use strict';

const fs = require('fs');
const path = require('path');

const SIZE_LABELS = {
  'xs-size': 'XS',
  's-size': 'S',
  'm-size': 'M',
  'l-size': 'L',
  'xl-size': 'XL',
  'xxl-size': '2XL',
  'xxxl-size': '3XL',
  'big-size': 'Big',
  'huge-size': 'Huge',
};

function sizeLabel(value) {
  if (SIZE_LABELS[value]) {
    return SIZE_LABELS[value];
  }

  return value
    .replace(/-size$/, '')
    .split('-')
    .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
    .join(' ');
}

function resolveDialogLess(projectRoot) {
  const candidates = [
    path.resolve(
      projectRoot,
      '../uls_v2/src/styles/uls-styles/less/modules/dialog.less',
    ),
    path.resolve(
      projectRoot,
      'node_modules/ulx-components/node_modules/uls_v2/src/styles/uls-styles/less/modules/dialog.less',
    ),
    path.resolve(
      projectRoot,
      'node_modules/uls_v2/src/styles/uls-styles/less/modules/dialog.less',
    ),
  ];

  return candidates.find((candidate) => fs.existsSync(candidate));
}

function parseDialogSizes(source) {
  const sizesByValue = new Map();
  const pattern = /dialog\.([a-z0-9-]+-size)/g;
  let match;

  while ((match = pattern.exec(source))) {
    const value = match[1];

    if (sizesByValue.has(value)) {
      continue;
    }

    const widthMatch = source
      .slice(match.index, match.index + 800)
      .match(/width:\s*(\d+px)/);

    if (!widthMatch) {
      continue;
    }

    const width = widthMatch[1];
    const name = sizeLabel(value);

    sizesByValue.set(value, {
      value,
      width,
      label: `${name} (${width})`,
    });
  }

  return [...sizesByValue.values()].sort(
    (left, right) =>
      Number.parseInt(left.width, 10) - Number.parseInt(right.width, 10),
  );
}

function parseDialogPositions(source) {
  const positions = [];
  const pattern = /dialog\.position-([a-z-]+)/g;
  let match;

  while ((match = pattern.exec(source))) {
    const value = match[1];

    if (!positions.some((item) => item.value === value)) {
      positions.push({
        value,
        label: value
          .split('-')
          .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
          .join(' '),
      });
    }
  }

  return positions;
}

function buildDialogTokens(projectRoot) {
  const lessPath = resolveDialogLess(projectRoot);

  if (!lessPath) {
    return null;
  }

  const source = fs.readFileSync(lessPath, 'utf8');
  const sizes = parseDialogSizes(source);

  if (!sizes.length) {
    return null;
  }

  return {
    source: path.relative(projectRoot, lessPath),
    sizes,
    sizeOptions: sizes.map((size) => ({
      label: size.label,
      value: size.value,
    })),
    positions: parseDialogPositions(source),
  };
}

function writeDialogTokens(projectRoot) {
  const tokens = buildDialogTokens(projectRoot);

  if (!tokens) {
    return null;
  }

  const outputPath = path.join(projectRoot, 'app/data/uls-tokens/dialog.js');
  const contents = `/* Generated from ${tokens.source}. Do not edit. */
export const DIALOG_SIZES = ${JSON.stringify(tokens.sizes, null, 2)};

export const DIALOG_SIZE_OPTIONS = ${JSON.stringify(tokens.sizeOptions, null, 2)};

export const DIALOG_POSITIONS = ${JSON.stringify(tokens.positions, null, 2)};
`;

  fs.mkdirSync(path.dirname(outputPath), { recursive: true });

  if (
    fs.existsSync(outputPath) &&
    fs.readFileSync(outputPath, 'utf8') === contents
  ) {
    return outputPath;
  }

  fs.writeFileSync(outputPath, contents);
  return outputPath;
}

module.exports = {
  buildDialogTokens,
  writeDialogTokens,
};

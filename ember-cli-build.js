'use strict';

const EmberApp = require('ember-cli/lib/broccoli/ember-app');
const Funnel = require('broccoli-funnel');
const mergeTrees = require('broccoli-merge-trees');
const path = require('path');
const { writeDialogTokens } = require('./lib/parse-uls-dialog');
const { resolveUlsHome } = require('./lib/uls-assets');

module.exports = function (defaults) {
  writeDialogTokens(__dirname);

  const app = new EmberApp(defaults, {
    emberData: {
      deprecations: {
        DEPRECATE_STORE_EXTENDS_EMBER_OBJECT: false,
      },
    },
    lessOptions: {
      paths: [
        path.resolve(__dirname, 'node_modules/ulx-components/styles'),
        path.resolve(__dirname, 'node_modules'),
        path.resolve(__dirname, 'node_modules/ulx-components/node_modules'),
      ],
    },
  });

  app.import('node_modules/sortablejs/Sortable.js');
  app.import('node_modules/flatpickr/dist/flatpickr.min.css');
  app.import('node_modules/quill/dist/quill.snow.css');

  const trees = [app.toTree()];
  const ulsHome = resolveUlsHome(__dirname);

  if (ulsHome) {
    trees.push(
      new Funnel(path.join(ulsHome, 'fonts'), {
        destDir: '/fonts',
        annotation: 'ULS fonts',
      }),
      new Funnel(path.join(ulsHome, 'images'), {
        destDir: '/images',
        annotation: 'ULS images',
      }),
      new Funnel(path.join(ulsHome, 'styles'), {
        destDir: '/styles',
        include: ['uls-editor-new-style.css', 'guls-style.css'],
        annotation: 'ULS compiled CSS',
      }),
    );
  } else {
    console.warn(
      'ULS fonts/images/css were not found. Set ULS_HOME or clone Eventz so webapps/applications/uls exists.',
    );
  }

  return mergeTrees(trees, { overwrite: true });
};

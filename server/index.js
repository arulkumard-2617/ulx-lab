'use strict';

const fs = require('fs');
const path = require('path');

const PROJECT_ROOT = path.resolve(__dirname, '..');

const LAB_SCREENS = {
  'create-event': {
    componentFile: 'app/components/screens/create-event-modal.gjs',
    controlsFile: 'app/data/controls/create-event.js',
  },
  'ticket-list': {
    componentFile: 'app/components/screens/ticket-list.gjs',
    controlsFile: 'app/data/controls/ticket-list.js',
  },
};

const DEFAULTS_BLOCK =
  /\/\* lab-defaults:start \*\/[\s\S]*?\/\* lab-defaults:end \*\//;

function resolveProjectFile(relativePath) {
  const absolutePath = path.resolve(PROJECT_ROOT, relativePath);

  if (!absolutePath.startsWith(PROJECT_ROOT + path.sep)) {
    throw new Error('Invalid lab persist path.');
  }

  return absolutePath;
}

function serializeJsString(value) {
  if (typeof value === 'boolean' || typeof value === 'number') {
    return String(value);
  }

  return `'${String(value).replace(/\\/g, '\\\\').replace(/'/g, "\\'")}'`;
}

function replaceDefaultsBlock(source, values) {
  if (!DEFAULTS_BLOCK.test(source)) {
    throw new Error('Missing lab-defaults block in screen file.');
  }

  const block = `/* lab-defaults:start */
const SCREEN_DEFAULTS = ${JSON.stringify(values, null, 2)};
/* lab-defaults:end */`;

  return source.replace(DEFAULTS_BLOCK, block);
}

function replaceControlDefaults(source, values) {
  let next = source;

  for (const [id, value] of Object.entries(values)) {
    if (!/^[a-zA-Z][a-zA-Z0-9]*$/.test(id)) {
      throw new Error(`Invalid control id: ${id}`);
    }

    const idPattern = new RegExp(
      `(id:\\s*'${id}'[\\s\\S]*?defaultValue:\\s*)(?:'[^']*'|"[^"]*"|true|false|\\d+)`,
    );

    if (!idPattern.test(next)) {
      throw new Error(`No defaultValue found for ${id}.`);
    }

    next = next.replace(idPattern, `$1${serializeJsString(value)}`);
  }

  return next;
}

function readJsonBody(req) {
  return new Promise((resolve, reject) => {
    let body = '';

    req.on('data', (chunk) => {
      body += chunk;
    });
    req.on('end', () => {
      try {
        resolve(JSON.parse(body || '{}'));
      } catch (error) {
        reject(error);
      }
    });
    req.on('error', reject);
  });
}

module.exports = function (app) {
  app.post('/__lab/persist-args', async (req, res) => {
    try {
      const payload = await readJsonBody(req);
      const screenId = payload.screenId;
      const values = payload.values;
      const screen = LAB_SCREENS[screenId];

      if (!screen || !values || typeof values !== 'object') {
        res.status(400).json({ ok: false, error: 'Unknown screen or values.' });
        return;
      }

      const componentPath = resolveProjectFile(screen.componentFile);
      const controlsPath = resolveProjectFile(screen.controlsFile);
      const componentSource = fs.readFileSync(componentPath, 'utf8');
      const controlsSource = fs.readFileSync(controlsPath, 'utf8');

      fs.writeFileSync(
        componentPath,
        replaceDefaultsBlock(componentSource, values),
      );
      fs.writeFileSync(
        controlsPath,
        replaceControlDefaults(controlsSource, values),
      );

      res.json({
        ok: true,
        files: [screen.componentFile, screen.controlsFile],
      });
    } catch (error) {
      res.status(500).json({ ok: false, error: error.message });
    }
  });
};

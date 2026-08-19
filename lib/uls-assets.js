'use strict';

const fs = require('fs');
const path = require('path');

function resolveUlsHome(projectRoot) {
  const candidates = [
    process.env.ULS_HOME,
    path.resolve(projectRoot, '../../eventz/webapps/applications/uls'),
    path.resolve(projectRoot, '../eventz/webapps/applications/uls'),
    path.resolve(projectRoot, '../uls'),
  ].filter(Boolean);

  return candidates.find((candidate) => {
    return (
      fs.existsSync(path.join(candidate, 'fonts')) &&
      fs.existsSync(path.join(candidate, 'images'))
    );
  });
}

module.exports = { resolveUlsHome };

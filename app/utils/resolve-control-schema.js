import { DIALOG_SIZE_OPTIONS } from 'ulx-lab/data/uls-tokens/dialog';

const OPTION_CATALOGS = {
  'dialog.sizes': DIALOG_SIZE_OPTIONS,
};

export function resolveControlSchema(schema = []) {
  return schema.map((control) => {
    const options = control.optionsFrom
      ? OPTION_CATALOGS[control.optionsFrom]
      : control.options;

    return {
      ...control,
      options: options ?? control.options ?? [],
    };
  });
}

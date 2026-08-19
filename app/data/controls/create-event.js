export const createEventArgControls = [
  {
    id: 'size',
    type: 'select',
    label: 'Modal size',
    help: 'UlxModal @size from ULS dialog.less.',
    defaultValue: 'huge-size',
    optionsFrom: 'dialog.sizes',
  },
  {
    id: 'width',
    type: 'text',
    label: 'Modal width',
    help: 'Optional UlxModal @width (for example 1080px or 90%). Overrides size when set.',
    placeholder: '1080px',
    defaultValue: '1024px',
  },
];

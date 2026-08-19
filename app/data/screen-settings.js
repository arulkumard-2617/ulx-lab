import { SCREENS } from 'ulx-lab/data/screens';
import { createEventArgControls } from 'ulx-lab/data/controls/create-event';
import { ticketListArgControls } from 'ulx-lab/data/controls/ticket-list';
import { resolveControlSchema } from 'ulx-lab/utils/resolve-control-schema';

const SCREEN_CONTROL_SCHEMAS = {
  'create-event': createEventArgControls,
  'ticket-list': ticketListArgControls,
};

export function screenIdFromRouteName(routeName) {
  if (routeName?.startsWith('screens.')) {
    return routeName.slice('screens.'.length);
  }

  return null;
}

export function configurableScreens() {
  return SCREENS.filter((screen) => SCREEN_CONTROL_SCHEMAS[screen.id]);
}

export function settingsForScreen(screenId) {
  if (!screenId) {
    return {
      screenId: null,
      screen: null,
      schema: [],
      hasControls: false,
    };
  }

  const screen = SCREENS.find((item) => item.id === screenId) ?? null;
  const schema = resolveControlSchema(SCREEN_CONTROL_SCHEMAS[screenId] ?? []);

  return {
    screenId,
    screen,
    schema,
    hasControls: schema.length > 0,
  };
}

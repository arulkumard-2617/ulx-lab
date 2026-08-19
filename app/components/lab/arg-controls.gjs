import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { fn, get } from '@ember/helper';
import { eq } from 'ember-truth-helpers';
import { registerDestructor } from '@ember/destroyable';
import { UlxField, UlxDropdown, UlxInput, UlxToggle } from 'ulx-components';

function defaultValues(schema) {
  const values = {};

  for (const control of schema) {
    values[control.id] =
      control.defaultValue ?? (control.type === 'boolean' ? false : '');
  }

  return values;
}

async function persistArgs(screenId, values) {
  const response = await fetch('/__lab/persist-args', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ screenId, values }),
  });
  const payload = await response.json().catch(() => ({}));

  if (!response.ok || !payload.ok) {
    throw new Error(payload.error || 'Could not save properties to code.');
  }

  return payload;
}

/**
 * Lab-only property panel. Writes SCREEN_DEFAULTS in the presentational
 * screen file so Eventz copy includes the adjusted values.
 */
export default class LabArgControls extends Component {
  @tracked values = defaultValues(this.args.schema ?? []);
  @tracked persistStatus = '';
  @tracked persistError = '';

  persistTimer = null;
  lastPersisted = JSON.stringify(this.values);

  constructor(owner, args) {
    super(owner, args);

    registerDestructor(this, () => {
      if (this.persistTimer) {
        clearTimeout(this.persistTimer);
      }
    });
  }

  get canPersist() {
    return Boolean(this.args.screenId);
  }

  @action
  updateSelect(id, value) {
    this.setValue(id, value);
  }

  @action
  updateText(id, value) {
    this.setValue(id, value);
  }

  @action
  updateBoolean(id, checked) {
    this.setValue(id, checked);
  }

  setValue(id, value) {
    this.values = { ...this.values, [id]: value };
    this.queuePersist();
  }

  queuePersist() {
    if (!this.canPersist) {
      return;
    }

    this.persistStatus = 'Saving to code…';
    this.persistError = '';

    if (this.persistTimer) {
      clearTimeout(this.persistTimer);
    }

    this.persistTimer = setTimeout(() => {
      this.persist();
    }, 400);
  }

  @action
  async persist() {
    const serialized = JSON.stringify(this.values);

    if (serialized === this.lastPersisted) {
      this.persistStatus = '';
      return;
    }

    try {
      const result = await persistArgs(this.args.screenId, this.values);
      this.lastPersisted = serialized;
      this.persistStatus = `Saved to ${result.files[0]}`;
    } catch (error) {
      this.persistStatus = '';
      this.persistError = error.message;
    }
  }

  <template>
    <section data-qa="lab-arg-controls">
      <div class="ulx-form m-size flex flex-col gap-4">
        {{#each @schema as |control|}}
          {{#if (eq control.type "select")}}
            <UlxField
              @fieldId="lab-control-{{control.id}}"
              @label={{control.label}}
              @helpText={{control.help}}
              @fieldClass="col-12"
              @dataQa="lab-control-{{control.id}}-field"
              as |field|
            >
              <UlxDropdown
                @field={{field}}
                @options={{control.options}}
                @value={{get this.values control.id}}
                @onChange={{fn this.updateSelect control.id}}
                @optionLabel="label"
                @placeholder={{control.placeholder}}
                @dataQa="lab-control-{{control.id}}"
              />
            </UlxField>
          {{else if (eq control.type "text")}}
            <UlxField
              @fieldId="lab-control-{{control.id}}"
              @label={{control.label}}
              @helpText={{control.help}}
              @fieldClass="col-12"
              @dataQa="lab-control-{{control.id}}-field"
              as |field|
            >
              <UlxInput
                @field={{field}}
                @value={{get this.values control.id}}
                @onInput={{fn this.updateText control.id}}
                @size="m-size"
                placeholder={{control.placeholder}}
                @dataQa="lab-control-{{control.id}}"
              />
            </UlxField>
          {{else if (eq control.type "boolean")}}
            <UlxField
              @fieldId="lab-control-{{control.id}}"
              @label={{control.label}}
              @helpText={{control.help}}
              @fieldClass="col-12"
              @dataQa="lab-control-{{control.id}}-field"
            >
              <:default>
                <UlxToggle
                  @checked={{get this.values control.id}}
                  @onCheckedChange={{fn this.updateBoolean control.id}}
                  @dataQa="lab-control-{{control.id}}"
                  aria-label={{control.label}}
                />
              </:default>
            </UlxField>
          {{/if}}
        {{/each}}
      </div>
      {{#if this.persistStatus}}
        <p class="text-secondary mt-4" data-qa="lab-arg-controls-status">
          {{this.persistStatus}}
        </p>
      {{/if}}
      {{#if this.persistError}}
        <p class="fg-red mt-4" data-qa="lab-arg-controls-error">
          {{this.persistError}}
        </p>
      {{/if}}
    </section>
    {{yield this.values}}
  </template>
}

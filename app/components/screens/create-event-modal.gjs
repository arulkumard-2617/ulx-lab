import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import {
  UlxModal,
  UlxOptionSegment,
  UlxField,
  UlxInput,
  UlxDropdown,
  UlxDatePicker,
  UlxTimePicker,
  UlxIcon,
  UlxButton,
} from 'ulx-components';
import {
  eventCategories,
  sourceLanguages,
} from 'ulx-lab/mocks/create-event';

const EVENT_NAME_MAX_LENGTH = 255;

/* lab-defaults:start */
const SCREEN_DEFAULTS = {
  "size": "huge-size",
  "width": "1024px"
};
/* lab-defaults:end */

export default class CreateEventModal extends Component {
  @tracked eventType = this.args.model?.eventType ?? 'in-person';
  @tracked eventName = this.args.model?.eventName ?? '';
  @tracked category = this.args.model?.category ?? 'OTHERS';
  @tracked startDate = this.args.model?.startDate ?? new Date(2026, 8, 16);
  @tracked endDate = this.args.model?.endDate ?? new Date(2026, 8, 16);
  @tracked startTime = this.args.model?.startTime ?? '0800';
  @tracked endTime = this.args.model?.endTime ?? '1700';
  @tracked language = this.args.model?.language ?? 'en';
  @tracked eventNameError = null;

  eventNameRules = {
    required: true,
    maxLength: { value: EVENT_NAME_MAX_LENGTH },
  };

  get categories() {
    return eventCategories;
  }

  get languages() {
    return sourceLanguages;
  }

  get modalSize() {
    return this.args.size ?? SCREEN_DEFAULTS.size;
  }

  get modalWidth() {
    const width = this.args.width ?? SCREEN_DEFAULTS.width;

    if (typeof width === 'string' && width.trim()) {
      return width.trim();
    }

    return undefined;
  }

  get eventTypeItems() {
    return [
      {
        label: 'In-person',
        value: 'in-person',
        message:
          'Manage attendees, exhibitors and more with our all-in-one event platform.',
        iconName: 'location-icon',
        id: 'create-event-type-in-person',
        dataQa: 'create-event-type-in-person',
        selected: this.eventType === 'in-person',
      },
      {
        label: 'Virtual',
        value: 'virtual',
        message:
          'Host a digital event and engage your attendees with our virtual event tools.',
        iconName: 'video-icon',
        id: 'create-event-type-virtual',
        dataQa: 'create-event-type-virtual',
        selected: this.eventType === 'virtual',
      },
      {
        label: 'Hybrid',
        value: 'hybrid',
        message:
          'Extend your in-person event to a global audience with a hybrid event.',
        iconName: 'live-icon',
        id: 'create-event-type-hybrid',
        dataQa: 'create-event-type-hybrid',
        selected: this.eventType === 'hybrid',
      },
    ];
  }

  get payload() {
    return {
      ...this.args.model,
      eventType: this.eventType,
      eventName: this.eventName.trim(),
      category: this.category,
      startDate: this.startDate,
      endDate: this.endDate,
      startTime: this.startTime,
      endTime: this.endTime,
      language: this.language,
    };
  }

  @action
  onEventTypeSelect(_selected, value) {
    this.eventType = value;
  }

  @action
  updateEventName(value) {
    this.eventName = value;
    this.eventNameError = null;
  }

  @action
  setCategory(value) {
    this.category = value;
  }

  @action
  setLanguage(value) {
    this.language = value;
  }

  @action
  updateStartDate(selectedDates) {
    const value = selectedDates?.[0];

    if (value) {
      this.startDate = value;
    }
  }

  @action
  updateEndDate(selectedDates) {
    const value = selectedDates?.[0];

    if (value) {
      this.endDate = value;
    }
  }

  @action
  updateStartTime(selected) {
    const value = Array.isArray(selected) ? selected[0] : selected;

    if (value != null && value !== '') {
      this.startTime = value;
    }
  }

  @action
  updateEndTime(selected) {
    const value = Array.isArray(selected) ? selected[0] : selected;

    if (value != null && value !== '') {
      this.endTime = value;
    }
  }

  @action
  submit() {
    if (!this.eventName?.trim()) {
      this.eventNameError = 'This field is required.';
      return;
    }

    return this.args.onSave?.(this.payload);
  }

  @action
  closeModal() {
    this.eventName = this.args.model?.eventName ?? '';
    this.eventNameError = null;
    this.args.onCancel?.();
  }

  <template>
    <UlxModal
      @visible={{@isOpen}}
      @title="Create Event"
      @size={{this.modalSize}}
      @width={{this.modalWidth}}
      @onHide={{this.closeModal}}
      @onCancel={{this.closeModal}}
      @onDone={{this.submit}}
      @doneButtonLabel="Create"
      @cancelButtonLabel="Cancel"
      @autoCloseOnDone={{false}}
      @closeOnBackdrop={{false}}
      @closeOnEscape={{false}}
      @dataQa="create-event-modal"
      @maskQa="create-event-modal-mask"
      class="ulx-panel-modal"
    >
      <:body>
        <div data-qa="create-event-modal-body">
          <div class="panel-container">
            <div class="panel-content">
              <div class="ulx-form fluid m-size">
                <UlxOptionSegment
                  @type="radio"
                  @selection="center"
                  @items={{this.eventTypeItems}}
                  @onSelect={{this.onEventTypeSelect}}
                  @ariaLabel="Event type"
                  @customClass="ulx-grid gap-2"
                  @itemClass="col-4 h-full"
                >
                  <:title as |eventType|>
                    <div class="flex justify-between items-center">
                      <span class="medium-font h7-font">{{eventType.label}}</span>
                      <UlxIcon
                        @type="font"
                        @componentClass="bs-icons1"
                        @iconName={{eventType.iconName}}
                        @size="s24"
                        aria-hidden="true"
                      />
                    </div>
                  </:title>
                  <:description as |eventType|>
                    <div class="text-small mt-1 text-secondary">
                      {{eventType.message}}
                    </div>
                  </:description>
                </UlxOptionSegment>

                <UlxField
                  @fieldId="create_event_name"
                  @label="Event Name"
                  @rules={{this.eventNameRules}}
                  @error={{this.eventNameError}}
                  @showCharacterCount={{true}}
                  @value={{this.eventName}}
                  @dataQa="create-event-name-field"
                  as |field|
                >
                  <UlxInput
                    @field={{field}}
                    @value={{this.eventName}}
                    @size="m-size"
                    @onInput={{this.updateEventName}}
                    data-qa="create-event-name"
                  />
                </UlxField>

                <UlxField
                  @fieldId="create-event-category"
                  @label="Category"
                  @tooltipMessage="Use a category to filter and report on this event."
                  @dataQa="create-event-category-field"
                  as |field|
                >
                  <UlxDropdown
                    @field={{field}}
                    @key="create-event-category"
                    @dataQa="create-event-category"
                    @options={{this.categories}}
                    @value={{this.category}}
                    @onChange={{this.setCategory}}
                    @optionLabel="label"
                    @placeholder="Select a category"
                    @customClass="fluid"
                    @context="body"
                    aria-label="Category"
                  />
                </UlxField>

                <div class="ulx-grid gap-4">
                  <UlxField
                    @fieldId="create_event_start_date"
                    @label="Start Date"
                    @fieldClass="col-3"
                  >
                    <:default>
                      <UlxDatePicker
                        @placeholder="Start Date"
                        @value={{this.startDate}}
                        @onChange={{this.updateStartDate}}
                        @dateFormat="M j, Y"
                        @showIcon={{true}}
                        @readOnlyInput={{true}}
                        @size="m-size"
                        data-qa="create-event-start-date"
                      />
                    </:default>
                  </UlxField>
                  <UlxField
                    @fieldId="create_event_start_time"
                    @label="Start Time"
                    @fieldClass="col-3"
                  >
                    <:default>
                      <UlxTimePicker
                        @internalTimeValue={{this.startTime}}
                        @emitInternalTime={{true}}
                        @onChange={{this.updateStartTime}}
                        @size="m-size"
                        @minuteIncrement={{15}}
                        @hourFormat="12"
                        @showIcon={{true}}
                        @readOnlyInput={{true}}
                        data-qa="create-event-start-time"
                      />
                    </:default>
                  </UlxField>
                  <UlxField
                    @fieldId="create_event_end-date"
                    @label="End Date"
                    @fieldClass="col-3"
                  >
                    <:default>
                      <UlxDatePicker
                        @placeholder="End Date"
                        @value={{this.endDate}}
                        @onChange={{this.updateEndDate}}
                        @dateFormat="M j, Y"
                        @minDate={{this.startDate}}
                        @showIcon={{true}}
                        @readOnlyInput={{true}}
                        @size="m-size"
                        data-qa="create-event-end-date"
                      />
                    </:default>
                  </UlxField>
                  <UlxField
                    @fieldId="create_event_end_time"
                    @label="End Time"
                    @fieldClass="col-3"
                  >
                    <:default>
                      <UlxTimePicker
                        @internalTimeValue={{this.endTime}}
                        @emitInternalTime={{true}}
                        @onChange={{this.updateEndTime}}
                        @size="m-size"
                        @minuteIncrement={{15}}
                        @hourFormat="12"
                        @showIcon={{true}}
                        @readOnlyInput={{true}}
                        data-qa="create-event-end-time"
                      />
                    </:default>
                  </UlxField>
                </div>

                <UlxField
                  @fieldId="create-event-source-language"
                  @label="Source Language"
                  @tooltipMessage="This is the base language for your event content."
                  @dataQa="create-event-language-field"
                  as |field|
                >
                  <UlxDropdown
                    @field={{field}}
                    @key="create-event-source-language"
                    @dataQa="create-event-language"
                    @filterDataQa="sourcelanguage-search"
                    @options={{this.languages}}
                    @value={{this.language}}
                    @onChange={{this.setLanguage}}
                    @optionLabel="label"
                    @filter={{true}}
                    @placeholder="Select a language"
                    @customClass="fluid"
                    @context="body"
                    aria-label="Source Language"
                  />
                </UlxField>
              </div>
            </div>
            <div class="panel-nav bg-layer1">
              <div class="mt-6">
                <UlxIcon
                  @type="font"
                  @componentClass="bs-icons1"
                  @iconName="calendar-icon02"
                  @size="s48"
                  aria-hidden="true"
                />
              </div>
              <div class="ms-3">
                <h3 class="mt-1 medium-font">Create your event</h3>
                <div class="mt-2 h7-font">
                  Start creating your event by providing the basic details now
                  and fill in what your event is all about later.
                </div>
              </div>
              <div class="ms-3 mt-2">
                <UlxButton
                  @href="#"
                  @text={{true}}
                  @label="See our complete Plan Comparison"
                  @dataQa="create-event-plan-comparison"
                />
              </div>
            </div>
          </div>
        </div>
      </:body>
    </UlxModal>
  </template>
}

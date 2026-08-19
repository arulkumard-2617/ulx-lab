import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import {
  UlxEmptyState,
  UlxButton,
  UlxToolbar,
  UlxTable,
  UlxSlidePane,
  UlxForm,
  UlxFieldSet,
  UlxField,
  UlxInput,
} from 'ulx-components';

/* lab-defaults:start */
const SCREEN_DEFAULTS = {
  size: 'm-size',
};
/* lab-defaults:end */

const TICKET_COLUMNS = [
  { field: 'name', header: 'Name' },
  { field: 'quantity', header: 'Quantity' },
  { field: 'price', header: 'Price' },
];

export default class TicketList extends Component {
  @tracked tickets = [...(this.args.model?.tickets ?? [])];
  @tracked isPaneOpen = false;
  @tracked name = this.args.model?.draft?.name ?? '';
  @tracked quantity = this.args.model?.draft?.quantity ?? '';
  @tracked price = this.args.model?.draft?.price ?? '';
  @tracked nameError = null;

  columns = TICKET_COLUMNS;
  nameRules = { required: true };

  get hasTickets() {
    return this.tickets.length > 0;
  }

  get paneSize() {
    return this.args.size ?? SCREEN_DEFAULTS.size;
  }

  resetDraft() {
    this.name = this.args.model?.draft?.name ?? '';
    this.quantity = this.args.model?.draft?.quantity ?? '';
    this.price = this.args.model?.draft?.price ?? '';
    this.nameError = null;
  }

  @action
  openPane() {
    this.resetDraft();
    this.isPaneOpen = true;
  }

  @action
  closePane() {
    this.isPaneOpen = false;
    this.resetDraft();
  }

  @action
  handleNameInput(value) {
    this.name = value;
    this.nameError = null;
  }

  @action
  handleQuantityInput(value) {
    this.quantity = value;
  }

  @action
  handlePriceInput(value) {
    this.price = value;
  }

  @action
  saveTicket() {
    if (!this.name?.trim()) {
      this.nameError = 'This field is required.';
      return Promise.reject(new Error('Ticket name is required.'));
    }

    const ticket = {
      id: `ticket-${Date.now()}`,
      name: this.name.trim(),
      quantity: this.quantity,
      price: this.price,
    };

    this.tickets = [...this.tickets, ticket];
    this.isPaneOpen = false;
    this.resetDraft();

    return Promise.resolve(this.args.onSave?.(ticket));
  }

  <template>
    {{#if this.hasTickets}}
      <UlxToolbar aria-label="Tickets" @dataQa="ticket-list-toolbar">
        <:end>
          <UlxButton
            @label="Add ticket"
            @variant="primary"
            @onClick={{this.openPane}}
            @dataQa="ticket-list-add"
          />
        </:end>
      </UlxToolbar>
      <div class="mt-4">
        <UlxTable
          @value={{this.tickets}}
          @columns={{this.columns}}
          @dataKey="id"
          @dataQa="ticket-list-table"
        />
      </div>
    {{else}}
      <UlxEmptyState
        @headerText="No tickets yet"
        @subHeaderText="Add a ticket to start selling."
        @iconName="event-past-icon"
        @dataQa="ticket-list-empty"
      >
        <UlxButton
          @label="Add ticket"
          @variant="primary"
          @onClick={{this.openPane}}
          @dataQa="ticket-list-add"
        />
      </UlxEmptyState>
    {{/if}}

    <UlxSlidePane
      @visible={{this.isPaneOpen}}
      @title="Ticket details"
      @position="right"
      @size={{this.paneSize}}
      @doneButtonLabel="Save"
      @cancelButtonLabel="Cancel"
      @autoCloseOnDone={{false}}
      @onHide={{this.closePane}}
      @onCancel={{this.closePane}}
      @onDone={{this.saveTicket}}
      @dataQa="ticket-details-pane"
      @doneButtonDataQa="ticket-details-save"
      @cancelButtonDataQa="ticket-details-cancel"
    >
      <:body>
        <UlxForm
          @size="m-size"
          @onSubmit={{this.saveTicket}}
          @dataQa="ticket-details-form"
          aria-label="Ticket details"
        >
          <UlxFieldSet
            @legend="Ticket details"
            @customClass="ulx-grid gap-6"
            @dataQa="ticket-details-fields"
          >
            <UlxField
              @label="Name"
              @fieldId="ticket-details-name"
              @fieldClass="col-12"
              @error={{this.nameError}}
              @rules={{this.nameRules}}
              @dataQa="ticket-details-name-field"
              as |field|
            >
              <UlxInput
                @field={{field}}
                @value={{this.name}}
                @onInput={{this.handleNameInput}}
                @size="m-size"
                @dataQa="ticket-details-name"
                placeholder="Enter ticket name"
              />
            </UlxField>
            <UlxField
              @label="Quantity"
              @fieldId="ticket-details-quantity"
              @fieldClass="col-12"
              @dataQa="ticket-details-quantity-field"
              as |field|
            >
              <UlxInput
                @field={{field}}
                @value={{this.quantity}}
                @onInput={{this.handleQuantityInput}}
                @size="m-size"
                @dataQa="ticket-details-quantity"
                placeholder="Enter quantity"
              />
            </UlxField>
            <UlxField
              @label="Price"
              @fieldId="ticket-details-price"
              @fieldClass="col-12"
              @dataQa="ticket-details-price-field"
              as |field|
            >
              <UlxInput
                @field={{field}}
                @value={{this.price}}
                @onInput={{this.handlePriceInput}}
                @size="m-size"
                @dataQa="ticket-details-price"
                placeholder="Enter price"
              />
            </UlxField>
          </UlxFieldSet>
        </UlxForm>
      </:body>
    </UlxSlidePane>
  </template>
}

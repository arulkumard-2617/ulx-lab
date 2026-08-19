import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import {
  UlxForm,
  UlxFieldSet,
  UlxField,
  UlxInput,
  UlxButton,
} from 'ulx-components';

export default class TicketClassForm extends Component {
  @tracked name = this.args.model?.name ?? '';
  @tracked quantity = this.args.model?.quantity ?? '';
  @tracked price = this.args.model?.price ?? '';
  @tracked nameError = null;

  nameRules = { required: true };

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
  submit() {
    if (!this.name?.trim()) {
      this.nameError = 'This field is required.';
      return;
    }

    this.args.onSave?.({
      ...this.args.model,
      name: this.name.trim(),
      quantity: this.quantity,
      price: this.price,
    });
  }

  @action
  cancel() {
    this.name = this.args.model?.name ?? '';
    this.quantity = this.args.model?.quantity ?? '';
    this.price = this.args.model?.price ?? '';
    this.nameError = null;
    this.args.onCancel?.();
  }

  <template>
    <UlxForm
      @size="m-size"
      @onSubmit={{this.submit}}
      @dataQa="ticket-class-form"
      aria-label="Ticket class form"
    >
      <:default>
        <UlxFieldSet
          @legend="Ticket class"
          @customClass="ulx-grid gap-6"
          @dataQa="ticket-class-details"
        >
          <UlxField
            @label="Name"
            @fieldId="ticket-class-name"
            @fieldClass="col-4"
            @error={{this.nameError}}
            @rules={{this.nameRules}}
            @dataQa="ticket-class-name-field"
            as |field|
          >
            <UlxInput
              @field={{field}}
              @value={{this.name}}
              @onInput={{this.handleNameInput}}
              @size="m-size"
              @dataQa="ticket-class-name"
              placeholder="Enter ticket class name"
            />
          </UlxField>
          <UlxField
            @label="Quantity"
            @fieldId="ticket-class-quantity"
            @fieldClass="col-4"
            @dataQa="ticket-class-quantity-field"
            as |field|
          >
            <UlxInput
              @field={{field}}
              @value={{this.quantity}}
              @onInput={{this.handleQuantityInput}}
              @size="m-size"
              @dataQa="ticket-class-quantity"
              placeholder="Enter quantity"
            />
          </UlxField>
          <UlxField
            @label="Price"
            @fieldId="ticket-class-price"
            @fieldClass="col-4"
            @dataQa="ticket-class-price-field"
            as |field|
          >
            <UlxInput
              @field={{field}}
              @value={{this.price}}
              @onInput={{this.handlePriceInput}}
              @size="m-size"
              @dataQa="ticket-class-price"
              placeholder="Enter price"
            />
          </UlxField>
        </UlxFieldSet>
      </:default>
      <:actions>
        <UlxButton
          @type="submit"
          @label="Save"
          @variant="primary"
          @dataQa="ticket-class-save"
        />
        <UlxButton
          @type="button"
          @label="Cancel"
          @variant="secondary"
          @text={{true}}
          @onClick={{this.cancel}}
          @dataQa="ticket-class-cancel"
        />
      </:actions>
    </UlxForm>
  </template>
}

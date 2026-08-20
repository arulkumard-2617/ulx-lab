import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { fn } from '@ember/helper';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';
import {
  UlxButton,
  UlxIconButton,
  UlxButtonGroup,
  UlxTabmenu,
  UlxInput,
  UlxIconInput,
  UlxTag,
  UlxIcon,
  UlxCard,
  UlxSplitButton,
  UlxAvatar,
  UlxImage,
} from 'ulx-components';
import { EVENT_TABS, eventsMock } from 'ulx-lab/mocks/events';

export default class EventListing extends Component {
  @service router;
  @service currentEvent;

  @tracked activeTab = this.args.model?.activeTab ?? 'running';
  @tracked query = '';

  manageItems = [{ label: 'Preview' }, { label: 'View Website' }];

  get eventRoute() {
    return this.args.eventRoute ?? 'event-home.manage.event-info';
  }

  get events() {
    return this.args.model?.events ?? eventsMock;
  }

  get brandName() {
    return this.args.model?.brandName ?? 'Default Space';
  }

  get tabItems() {
    return EVENT_TABS.map((tab) => ({
      id: tab.id,
      label: tab.label,
    }));
  }

  get activeTabIndex() {
    const index = EVENT_TABS.findIndex((tab) => tab.id === this.activeTab);
    return index === -1 ? 0 : index;
  }

  get visibleEvents() {
    const query = this.query.trim().toLowerCase();
    return this.events.filter((event) => {
      const matchesTab =
        this.activeTab === 'all'
          ? event.tab !== 'trash'
          : event.tab === this.activeTab;
      const matchesQuery =
        !query || event.name.toLowerCase().includes(query);
      return matchesTab && matchesQuery;
    });
  }

  @action
  changeTab(event) {
    const tab = EVENT_TABS[event.index];
    if (tab) {
      this.activeTab = tab.id;
    }
  }

  @action
  search(value) {
    this.query = value;
  }

  @action
  createEvent() {
    this.args.onCreateEvent?.();
  }

  @action
  openEvent(eventId) {
    this.currentEvent.select(eventId);
    this.router.transitionTo(this.eventRoute);
  }

  @action
  selectEvent(eventId) {
    this.currentEvent.select(eventId);
  }

  <template>
    <div data-qa="event-listing">
      <div class="flex items-center justify-between mb-4">
        <h1 class="text-h3 medium-font">Event - {{this.brandName}}</h1>
        <UlxButton
          @label="Create Event"
          @variant="primary"
          @size="l-size"
          @onClick={{this.createEvent}}
          @dataQa="event-listing-create"
        />
      </div>

      <UlxTabmenu
        @items={{this.tabItems}}
        @activeIndex={{this.activeTabIndex}}
        @onTabChange={{this.changeTab}}
        @ariaLabel="Event status"
        @dataQa="event-listing-tabs"
      />

      <div class="flex items-center gap-3 mt-4 mb-4">
        <div>
          <UlxIconInput
            @iconLeft="search-icon"
            @iconType="font"
            @iconClass="bs-icons1"
            @iconSize="s16"
            @size="m-size"
            
          >
            <UlxInput
              @placeholder="Search"
              @value={{this.query}}
              @onInput={{this.search}}
              @size="m-size"
              @customClass="w-300"
              @dataQa="event-listing-search"
            />
          </UlxIconInput>
        </div>
        <div class="flex items-center gap-2 ms-auto shrink-0">
          <UlxButtonGroup @orientation="horizontal" @size="m-size">
            <UlxIconButton
              @iconLeft="filter-icon"
              @variant="basic"
              @size="m-size"
              aria-label="Filter"
              @dataQa="event-listing-filter"
            />
            <UlxIconButton
              @iconLeft="sort-icon"
              @variant="basic"
              @size="m-size"
              aria-label="Sort"
              @dataQa="event-listing-sort"
            />
          </UlxButtonGroup>
          <UlxIconButton
            @label="List View"
            @iconLeft="list-view-icon"
            @variant="basic"
            @size="m-size"
            @dataQa="event-listing-view"
          />
        </div>
      </div>

      <div class="flex flex-col gap-4">
        {{#each this.visibleEvents as |event|}}
          <UlxCard
            @appearance="outlined"
            @dataQa="event-listing-card-{{event.id}}"
          >
            <:content>
              <div class="flex gap-6 items-start">
                <div class="relative shrink-0 w-248 h-168">
                  <UlxImage
                    @src={{event.thumbnail}}
                    @alt=""
                    @objectFit="cover"
                    @shape="rounded"
                    @customClass=""
                    @dataQa="event-listing-thumb-{{event.id}}"
                  />
                  <UlxTag
                    @value={{event.typeBadge}}
                    @size="xs-size"
                    @variant="color-hybrid"
                    @customClass="absolute top-4 right-4"
                    @dataQa="event-listing-type-{{event.id}}"
                  />
                </div>
                <div class="flex flex-col grow gap-4">
                  <div class="flex items-center gap-2">
                    <LinkTo
                      @route={{this.eventRoute}}
                      @activeClass=""
                      {{on "click" (fn this.selectEvent event.id)}}
                      data-qa="event-listing-title-{{event.id}}"
                    >
                      <h2 class="text-h5 bold-font">{{event.name}}</h2>
                    </LinkTo>
                    <UlxTag
                      @value={{event.status}}
                      @size="xxs-size"
                      @rounded={{true}}
                      @variant={{event.statusVariant}}
                      @dataQa="event-listing-status-{{event.id}}"
                    />
                  </div>
                  <div class="flex flex-wrap items-center gap-4">
                    <span class="flex items-center gap-1">
                      <UlxIcon
                        @type="font"
                        @iconName="calendar-icon"
                        @size="s18"
                      />
                      {{event.dates}}
                    </span>
                    <span class="flex items-center gap-1">
                      <UlxIcon
                        @type="font"
                        @iconName={{event.typeIcon}}
                        @size="s18"
                      />
                      {{event.type}}
                    </span>
                    <span class="flex items-center gap-1">
                      <UlxIcon
                        @type="font"
                        @iconName="location-icon"
                        @size="s18"
                      />
                      {{event.location}}
                    </span>
                  </div>
                  <div class="flex items-center gap-4">
                    <span class="flex items-center gap-1">
                      <UlxIcon
                        @type="font"
                        @iconName="brand-members-icon"
                        @size="s18"
                      />
                      {{event.organizers}}
                    </span>
                    <span class="flex items-center gap-1">
                      <UlxIcon
                        @type="font"
                        @iconName="attendees-icon"
                        @size="s18"
                      />
                      {{event.attendees}}
                    </span>
                  </div>
                  <div class="flex items-center gap-2">
                    <UlxAvatar
                      @type="text"
                      @label={{event.userInitials}}
                      @size="s-size"
                      @shape="circle"
                      @ariaLabel={{event.userInitials}}
                      @dataQa="event-listing-avatar-{{event.id}}"
                    />
                    {{event.lastModified}}
                  </div>
                </div>
                <div class="flex flex-col items-end gap-4 shrink-0 self-stretch">
                  <UlxSplitButton
                    @label="Manage"
                    @variant="basic"
                    @size="m-size"
                    @items={{this.manageItems}}
                    @onClick={{fn this.openEvent event.id}}
                    @dataQa="event-listing-manage-{{event.id}}"
                  />
                  <div class="flex items-center gap-2">
                    <UlxIconButton
                      @label="Preview"
                      @iconLeft="preview-icon"
                      @iconSize="s18"
                      @variant="link on-hover"
                      @text={{true}}
                      @size="s-size"
                      @dataQa="event-listing-preview-{{event.id}}"
                    />
                    <span class="text-secondary" aria-hidden="true">•</span>
                    <UlxIconButton
                      @label="View Website"
                      @iconLeft="website-icon"
                      @iconSize="s18"
                      @variant="link on-hover"
                      @text={{true}}
                      @size="s-size"
                      @dataQa="event-listing-website-{{event.id}}"
                    />
                  </div>
                </div>
              </div>
            </:content>
          </UlxCard>
        {{else}}
          <p class="text-secondary">No events in this list.</p>
        {{/each}}
      </div>
    </div>
  </template>
}

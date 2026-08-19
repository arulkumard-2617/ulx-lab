import EventTopBar from 'ulx-lab/components/commons/event-top-bar';
import EventLeftBar from 'ulx-lab/components/commons/event-left-bar';

<template>
  <div data-qa="event-page-template">
    <div class="fxgrow">
      <EventTopBar @model={{@model}} />
      <div class="uls-page old-ui-view hgt-topbar">
        <EventLeftBar @model={{@model}} />
        <main tabindex="0" class="page-content-panel">
          {{yield}}
        </main>
      </div>
    </div>
  </div>
</template>

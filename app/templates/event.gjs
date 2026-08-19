import pageTitle from 'ember-page-title/helpers/page-title';
import EventTopBar from 'ulx-lab/components/commons/event-top-bar';
import EventLeftBar from 'ulx-lab/components/commons/event-left-bar';

<template>
  {{pageTitle @model.eventName}}
  <div data-qa="event-page">
    <div class="fxgrow">
      <EventTopBar @model={{@model}} />
      <div class="uls-page old-ui-view hgt-topbar">
        <EventLeftBar @model={{@model}} />
        <main tabindex="0" class="page-content-panel">
          {{outlet}}
        </main>
      </div>
    </div>
  </div>
</template>

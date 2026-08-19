import EventPageTemplate from 'ulx-lab/components/commons/event-page-template';
import EventInfo from 'ulx-lab/components/screens/event-info';

<template>
  <EventPageTemplate @model={{@model}}>
    <EventInfo @model={{@model.event}} />
  </EventPageTemplate>
</template>

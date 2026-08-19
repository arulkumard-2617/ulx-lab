import HomePageTemplate from 'ulx-lab/components/commons/home-page-template';
import EventListing from 'ulx-lab/components/screens/event-listing';

<template>
  <HomePageTemplate @model={{@model}}>
    <EventListing
      @model={{@model}}
      @onCreateEvent={{@onCreateEvent}}
      @eventRoute={{@eventRoute}}
    />
  </HomePageTemplate>
</template>

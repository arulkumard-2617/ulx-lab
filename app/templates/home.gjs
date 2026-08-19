import pageTitle from 'ember-page-title/helpers/page-title';
import HomeTopBar from 'ulx-lab/components/commons/home-top-bar';
import HomeLeftBar from 'ulx-lab/components/commons/home-left-bar';

<template>
  {{pageTitle "Home"}}
  <div id="oe-service-root" class="fxb" data-qa="home-page">
    <div class="fxgrow">
      <HomeTopBar @model={{@model}} />
      <div class="uls-page old-ui-view hgt2 page-event-listing">
        <HomeLeftBar @model={{@model}} />
        <main tabindex="0" class="page-content-panel uls-container-old">
          {{outlet}}
        </main>
      </div>
    </div>
  </div>
</template>

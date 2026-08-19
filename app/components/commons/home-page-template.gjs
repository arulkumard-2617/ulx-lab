import HomeTopBar from 'ulx-lab/components/commons/home-top-bar';
import HomeLeftBar from 'ulx-lab/components/commons/home-left-bar';

<template>
  <div id="oe-service-root" class="fxb" data-qa="home-page-template">
    <div class="fxgrow">
      <HomeTopBar @model={{@model}} />
      <div class="uls-page old-ui-view hgt2 page-event-listing">
        <HomeLeftBar @model={{@model}} />
        <main tabindex="0" class="page-content-panel uls-container-old">
          {{yield}}
        </main>
      </div>
    </div>
  </div>
</template>

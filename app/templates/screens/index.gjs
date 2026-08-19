import { LinkTo } from '@ember/routing';
import { SCREENS } from 'ulx-lab/data/screens';
import pageTitle from 'ember-page-title/helpers/page-title';

<template>
  {{pageTitle "Screens"}}
  <h1 class="h7-font mb-2">Screens</h1>
  <p class="text-secondary mb-6">
    Presentational ULX screens with static data. Copy a screen into Eventz; do
    not regenerate it there.
  </p>
  <ul class="flex flex-col gap-4">
    {{#each SCREENS as |screen|}}
      <li>
        {{#if screen.model}}
          <LinkTo
            @route={{screen.route}}
            @model={{screen.model}}
            class="medium-font"
          >
            {{screen.title}}
          </LinkTo>
        {{else}}
          <LinkTo @route={{screen.route}} class="medium-font">
            {{screen.title}}
          </LinkTo>
        {{/if}}
        <p class="text-secondary">{{screen.description}}</p>
      </li>
    {{/each}}
  </ul>
</template>

import { LinkTo } from '@ember/routing';
import {
  UlxIconButton,
  UlxAvatar,
} from 'ulx-components';

<template>
  <header class="uls-main-menu" id="top-bar" data-qa="home-top-bar">
    <div class="left-menu">
      <h1>
        <LinkTo
          @route="home.event-listing"
          class="menu-item bs-logo"
          aria-label="Backstage"
        >
          <svg class="s32" aria-hidden="true">
            <use href="#bs-home-logo" xlink:href="#bs-home-logo"></use>
          </svg>
        </LinkTo>
      </h1>
      <div class="menu-item">
        <LinkTo @route="home.event-listing" class="menu-link">Home</LinkTo>
      </div>
      <div class="menu-item">
        <span class="menu-link">Portal Settings</span>
      </div>
    </div>
    <div class="right-menu gp4">
      <div class="fxb fcol fhc menu-item">
        <div class="branding-dropdown st1 fxb fvc right">
          <div class="grb gp1 fvc">
            <div class="selected text">{{@model.brandName}}</div>
            <i class="down-arrow-icon bs-icons1 s20" aria-hidden="true"></i>
          </div>
        </div>
      </div>
      <div class="menu-item">
        <UlxIconButton
          @iconLeft="question-icon"
          @iconComponentClass="bs-icons1"
          @iconSize="s22"
          @size="s-size"
          @variant="white"
          @dataQa="home-top-bar-help"
        />
      </div>
      <div class="menu-item">
        <UlxIconButton
          @iconLeft="announcement-icon"
          @iconComponentClass="bs-icons1"
          @iconSize="s22"
          @size="s-size"
          @variant="white"
          @dataQa="home-top-bar-announcements"
        />
      </div>
      <div class="menu-item">
        <UlxAvatar
          @type="text"
          @label={{@model.userInitials}}
          @size="s-size"
          @shape="circle"
          @ariaLabel="User profile"
          @dataQa="home-top-bar-avatar"
        />
      </div>
    </div>
  </header>
</template>

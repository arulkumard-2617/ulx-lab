import { LinkTo } from '@ember/routing';
import { UlxButton, UlxIconButton, UlxAvatar, UlxTag, UlxIcon } from 'ulx-components';

<template>
  <div
    class="uls-top-bar old-ui-view top-fixed"
    data-qa="event-top-bar"
  >
    <div class="uls-grid">
      <div class="col-6 col-md-5">
        <div class="top-bar-header">
          <div class="fxb fvc mgl2">
            <LinkTo
              @route="home.index"
              aria-label="Back to home"
              data-qa="event-top-bar-home"
            >
              <svg class="logo-img ui s24">
                  <use xlink:href="#svgBsLogo2"></use>
                </svg>
            </LinkTo>
          </div>
          <div>
            <div class="fxb fvc gp1">
              <h5 class="ellipsis header">{{@model.eventName}}</h5>
              <UlxTag
                @value={{@model.status}}
                @size="xxs-size"
                @dataQa="event-top-bar-status"
              />
            </div>
            <div class="fxb fvc gp3">
              <div class="fxb fvc gp2">
                <div class="text-small text-fit">{{@model.eventWhen}}</div>
                <div class="uls-label empty xxs-size bg-layer6 rds"></div>
                <UlxButton
                  @variant="white"
                  @text={{true}}
                  @size="s-size"
                  @dataQa="event-top-bar-language"
                >
                  <:prefix>
                    <UlxIcon
                      @type="font"
                      @iconName="language-icon"
                      @componentClass="bs-icons1 me-1"
                    />
                  </:prefix>
                  <:default>{{@model.language}}</:default>
                  <:suffix>
                    <UlxIcon
                      @type="font"
                      @iconName="down-arrow-bounded-icon"
                      @componentClass="bs-icons1 ms-1"
                    />
                  </:suffix>
                </UlxButton>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="col-6 fxb fhe fvc col-md-7">
        <div class="fxb fvc gp2 ">
          <UlxButton
            @variant="white"
            @text={{true}}
            @dataQa="event-top-bar-edit-website"
          >
            <:prefix>
              <UlxIcon
                @type="font"
                @iconName="edit-icon"
                @componentClass="bs-icons1 me-1"
              />
            </:prefix>
            <:default>Edit Website</:default>
          </UlxButton>
          <div class="uls-label empty xxs-size bg-layer6 rds"></div>
          <UlxButton
            @variant="white"
            @text={{true}}
            @dataQa="event-top-bar-view-website"
          >
            <:prefix>
              <UlxIcon
                @type="font"
                @iconName="website-icon"
                @componentClass="bs-icons1 me-1"
              />
            </:prefix>
            <:default>View Website</:default>
          </UlxButton>
          <div class="uls-label empty xxs-size bg-layer6 rds"></div>
          <UlxIconButton
            @iconLeft="question-icon"
            @iconComponentClass="bs-icons1"
            @iconSize="s22"
            @size="s-size"
            @variant="white"
            @dataQa="event-top-bar-help"
          />
          
          <UlxButton
            @label="Republish"
            @variant="primary"
            @size="m-size"
            @dataQa="event-top-bar-republish"
          />
          <UlxAvatar
            @type="text"
            @label={{@model.userInitials}}
            @size="s-size"
            @shape="circle"
            @ariaLabel="User profile"
            @dataQa="event-top-bar-avatar"
          />
        </div>
      </div>
    </div>
  </div>
</template>

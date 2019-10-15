<template>
  <div>
    <div class="profile-developer-top">
      <div class="uk-container">
        <div class="uk-card uk-card-body profile-developer-name">
          <div class="uk-width-1-6 uk-padding uk-box-shadow-small developer-logo">
            <img class="uk-width-1-1" :src="$root.url + '/storage/assets/images/devlogo/' + getdeveloper.dev_logo" />
          </div>
          <div class="uk-margin-small-top developer-name">{{ getdeveloper.dev_name }} <a v-show="getdeveloper.status_verification === 'Y'" uk-tooltip="Terverifikasi" class="badge-verification badge-verification-medium" uk-icon="icon: check; ratio: 0.8"></a></div>
        </div>
      </div>
    </div>
    <div class="navbar-developer-container">
      <div class="uk-container">
        <nav class="uk-navbar navbar-developer-profile">
          <div class="uk-navbar-center">
            <ul class="uk-navbar-nav">
              <li>
                <a :class="{active: profile_menu === 'info'}" @click="profile_menu = 'info'">
                  <div>
                    <span uk-icon="info"></span>
                    <div class="uk-navbar-subtitle">
                      Informasi Pengembang
                    </div>
                  </div>
                </a>
              </li>
              <li>
                <a :class="{active: profile_menu === 'project'}" @click="profile_menu = 'project'">
                  <div>
                    <span uk-icon="thumbnails"></span>
                    <div class="uk-navbar-subtitle">
                      Proyek
                    </div>
                  </div>
                </a>
              </li>
              <li>
                <a :class="{active: profile_menu === 'marketing'}" @click="profile_menu = 'marketing'">
                  <div>
                    <span uk-icon="users"></span>
                    <div class="uk-navbar-subtitle">
                      Agen Marketing
                    </div>
                  </div>
                </a>
              </li>
            </ul>
          </div>
        </nav>
      </div>
    </div>
    <div class="uk-margin-top uk-margin-large-bottom uk-container">
      <developer-info v-if="profile_menu === 'info'" :session_user="session_user" :getdeveloper="getdeveloper" />
      <developer-project v-if="profile_menu === 'project'" :session_user="session_user" :getdeveloper="getdeveloper" />
      <developer-marketing v-if="profile_menu === 'marketing'" :session_user="session_user" :getdeveloper="getdeveloper" />
    </div>
  </div>
</template>

<script>
import DeveloperInfo from './DevProfile/DeveloperInfo.vue';
import DeveloperProject from './DevProfile/DeveloperProject.vue';
import DeveloperMarketing from './DevProfile/DeveloperMarketing.vue';

export default {
  props: ['session_user', 'getdeveloper'],
  components: {
    'developer-info': DeveloperInfo,
    'developer-project': DeveloperProject,
    'developer-marketing': DeveloperMarketing
  },
  data() {
    return {
      profile_menu: 'info'
    }
  },
  methods: {},
  mounted() {}
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div class="uk-container uk-margin-large-top">
      <div class="uk-card uk-card-default">
        <div class="uk-grid-small uk-grid-divider uk-grid-match" uk-grid>
          <div class="uk-width-1-4">
            <div class="uk-card-body">
              <ul class="uk-nav uk-nav-default" uk-nav>
                <li><a @click="pagenav = 'profile'">Informasi Akun</a></li>
                <li><a @click="pagenav = 'email'">Email</a></li>
                <li><a @click="pagenav = 'password'">Password</a></li>
              </ul>
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-card-body">
              <edit-profile :session_user="session_user" v-if="pagenav === 'profile'" />
              <edit-email :session_user="session_user" v-if="pagenav === 'email'" />
              <edit-password :session_user="session_user" v-if="pagenav === 'password'" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import EditProfile from './Profile/EditProfile.vue';
import EditEmail from './Profile/EditEmail.vue';
import EditPassword from './Profile/EditPassword.vue';

export default {
  props: ['session_user', 'pagecomponent'],
  components: {
    'edit-profile': EditProfile,
    'edit-email': EditEmail,
    'edit-password': EditPassword
  },
  data() {
    return {
      pagenav: this.pagecomponent
    }
  },
  mounted() {
    this.pagenav = this.pagecomponent;
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div class="uk-container uk-margin-large-top uk-margin-large-bottom">
      <div class="uk-grid-small uk-grid-match" uk-grid>
        <div class="uk-width-1-4">
          <div class="uk-card uk-card-body uk-card-default side-navbar-profile">
            <div class="uk-margin side-profile-info">
              <div v-if="session_user.customer_photo === null" class="uk-tile uk-tile-default uk-margin side-profile-photo">
                <div class="uk-position-center">
                  <span uk-icon="icon: user; ratio: 3"></span>
                </div>
              </div>
              <div v-else class="uk-margin side-profile-photo">
                <img class="uk-width-1-1" :src="$root.url + '/images/avatar/' + session_user.customer_photo" alt="">
              </div>
              <div class="uk-margin side-profile-joined">
                Bergabung pada <br>
                <span class="profile-joined-date">{{ $root.formatDate( session_user.created_at, 'DD MMMM YYYY', 'id' ) }}</span>
              </div>
            </div>
            <ul class="uk-nav uk-nav-default" uk-nav>
              <li class="uk-nav-divider"></li>
              <li><a :href="$root.url + '/customer/request'">Permintaan</a></li>
              <li><a :href="$root.url + '/customer/survey'">Survey</a></li>
              <li class="uk-nav-divider"></li>
              <li><a :class="{ 'navactive': isMenuActive === 'account_info' }" @click="isMenuActive = 'account_info'">Informasi Akun</a></li>
              <li><a :class="{ 'navactive': isMenuActive === 'password' }" @click="isMenuActive = 'password'">Password</a></li>
              <li><a :class="{ 'navactive': isMenuActive === 'email' }" @click="isMenuActive = 'email'">Alamat Email</a></li>
              <li><a :class="{ 'navactive': isMenuActive === 'profile_photo' }" @click="isMenuActive = 'profile_photo'">Foto Profil</a></li>
              <li class="uk-nav-divider"></li>
              <li><a :href="$root.url + '/authentication/logout/marketing'">Keluar</a></li>
            </ul>
          </div>
        </div>
        <div class="uk-width-expand">
          <div class="uk-card uk-card-default uk-card-body side-content-profile">
            <div v-if="isMenuActive === 'account_info'">
              <AccountInformation :session_user="session_user" :isMenuActive="isMenuActive" />
            </div>
            <div v-else-if="isMenuActive === 'password'">
              <PasswordAccount :session_user="session_user" :isMenuActive="isMenuActive" />
            </div>
            <div v-else-if="isMenuActive === 'email'">
              <EmailAccount :session_user="session_user" :isMenuActive="isMenuActive" />
            </div>
            <div v-else>
              <ProfilePhoto :session_user="session_user" :isMenuActive="isMenuActive" />
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import AccountInformation from './AccountInformation.vue';
import PasswordAccount from './PasswordAccount.vue';
import EmailAccount from './EmailAccount.vue';
import ProfilePhoto from './ProfilePhoto.vue';

export default {
  props: ['session_user'],
  components: {
    AccountInformation,
    PasswordAccount,
    EmailAccount,
    ProfilePhoto
  },
  data() {
    return {
      isMenuActive: 'account_info'
    }
  },
  methods: {

  },
  mounted() {}
}
</script>

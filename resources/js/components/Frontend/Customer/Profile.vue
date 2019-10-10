<template>
  <div>
    <div class="uk-container uk-margin-large-top uk-margin-large-bottom">
      <div v-show="session_user.status_verification === 'N'" class="uk-alert-warning uk-margin" uk-alert>
        Akun anda belum terverifikasi. Silakan cek inbox / spam email atau <a @click="isMenuActive = 'email'"><strong>klik disini</strong></a>
      </div>
      <div class="uk-grid-small uk-grid-match" uk-grid>
        <div class="uk-width-1-4">
          <div class="uk-card uk-card-body uk-card-default side-navbar-profile">
            <div class="uk-margin side-profile-info">
              <div class="uk-margin side-profile-photo">
                <img v-if="session_user.customer_photo" class="uk-width-1-1" :src="$root.url + '/storage/assets/images/avatar/' + session_user.customer_photo" alt="">
                <img v-else class="uk-width-1-1" :src="$root.url + '/images/avatar/avatar.jpg'" alt="">
              </div>
              <div class="uk-margin side-profile-joined">
                Bergabung pada <br>
                <span class="profile-joined-date">{{ $root.formatDate( session_user.created_at, 'DD MMMM YYYY', 'id' ) }}</span>
              </div>
            </div>
            <ul class="uk-nav uk-nav-default" uk-nav>
              <li class="uk-nav-divider"></li>
              <li><a :href="$root.url + '/customer/request_unit'">Pemesanan</a></li>
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
  props: [
    'session_user',
    'hasrequest'
  ],
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

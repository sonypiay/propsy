<template>
  <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s uk-align-center">
    <div class="uk-margin uk-modal-title modal-login-title">
      Daftar
    </div>
    <div class="uk-margin uk-grid-small" uk-grid>
      <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
        <a @click="onSwitchSignUp('dev')" :class="{ 'modal-btn-tabactive': forms.isTabActive === 'dev' }" class="uk-width-1-1 uk-button uk-button-primary modal-btn-tab">Developer</a>
      </div>
      <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
        <a @click="onSwitchSignUp('mkt')" :class="{ 'modal-btn-tabactive': forms.isTabActive === 'mkt' }" class="uk-width-1-1 uk-button uk-button-primary modal-btn-tab">Marketing</a>
      </div>
    </div>

    <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
    <!-- developer -->
    <p class="modal-form-mustcomplete">Lengkapi Formulir dibawah ini</p>
    <form class="uk-margin uk-form-stacked modal-login-form" @submit.prevent="onSignUpDeveloper" v-if="forms.isTabActive === 'dev'">
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Email</label>
        <div class="uk-form-controls">
          <input type="email" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.developer.email">
        </div>
        <div v-show="errors.name.dev_email" class="uk-text-danger uk-text-small">{{ errors.name.dev_email }}</div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Nama Pemilik</label>
        <div class="uk-form-controls">
          <input type="text" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.developer.ownername">
        </div>
        <div v-show="errors.name.dev_ownername" class="uk-text-danger uk-text-small">{{ errors.name.dev_ownername }}</div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">Tentang Pengembang</label>
        <div class="uk-form-controls">
          <textarea class="uk-width-1-1 uk-textarea uk-height-small modal-login-input" v-model="forms.developer.biography"></textarea>
        </div>
      </div>
      <hr>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Username</label>
        <div class="uk-form-controls">
          <input type="text" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.developer.username">
        </div>
        <div v-show="errors.name.dev_username" class="uk-text-danger uk-text-small">{{ errors.name.dev_username }}</div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Password</label>
        <div class="uk-form-controls">
          <input type="password" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.developer.password">
        </div>
        <div v-show="errors.name.dev_password" class="uk-text-danger uk-text-small">{{ errors.name.dev_password }}</div>
      </div>
      <div class="uk-margin">
        <button class="uk-width-1-1 uk-button uk-button-primary modal-login-submit" v-html="forms.submit"></button>
      </div>
    </form>

    <!-- marketing -->
    <form class="uk-margin uk-form-stacked modal-login-form" @submit.prevent="onSignUpMarketing" v-else>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Nama Lengkap</label>
        <div class="uk-form-controls">
          <input type="text" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.marketing.fullname">
        </div>
        <div v-show="errors.name.mkt_fullname" class="uk-text-danger uk-text-small">{{ errors.name.mkt_fullname }}</div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Email</label>
        <div class="uk-form-controls">
          <input type="email" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.marketing.email">
        </div>
        <div v-show="errors.name.mkt_email" class="uk-text-danger uk-text-small">{{ errors.name.mkt_email }}</div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Username</label>
        <div class="uk-form-controls">
          <input type="text" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.marketing.username">
        </div>
        <div v-show="errors.name.mkt_username" class="uk-text-danger uk-text-small">{{ errors.name.mkt_username }}</div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label modal-login-label">*Password</label>
        <div class="uk-form-controls">
          <input type="password" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.marketing.password">
        </div>
        <div v-show="errors.name.mkt_password" class="uk-text-danger uk-text-small">{{ errors.name.mkt_password }}</div>
      </div>
      <div class="uk-margin">
        <button class="uk-width-1-1 uk-button uk-button-primary modal-login-submit" v-html="forms.submit"></button>
      </div>
    </form>

  </div>
</template>

<script>
export default {
  props: [],
  data() {
    return {
      forms: {
        isTabActive: 'dev',
        developer: {
          email: '',
          ownername: '',
          biography: '',
          username: '',
          password: ''
        },
        marketing: {
          fullname: '',
          email: '',
          username: '',
          password: ''
        },
        submit: 'Daftar'
      },
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    onSwitchSignUp( usertype )
    {
      this.forms.isTabActive = usertype;
    },
    onSignUpDeveloper()
    {

    },
    onSignUpMarketing()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.marketing.fullname === '' )
      {
        this.errors.name.mkt_fullname = 'Masukkan nama nengkap Anda';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.email === '' )
      {
        this.errors.name.mkt_email = 'Masukkan alamat email Anda';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.username === '' )
      {
        this.errors.name.mkt_username = 'Masukkan username Anda';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.password === '' )
      {
        this.errors.name.mkt_password = 'Masukkan password Anda';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      if( this.forms.marketing.password.length < 8 )
      {
        swal({
          title: 'Password terlalu pendek',
          text: 'Password minimal 8 (delapan) karakter.',
          icon: 'warning',
          dangerMode: true
        });
        return false;
      }
      this.forms.submit = '<span uk-spinner></span>';

      axios({
        method: 'post',
        url: this.$root.url + '/registration/marketing',
        params: {
          fullname: this.forms.marketing.fullname,
          email: this.forms.marketing.email,
          username: this.forms.marketing.username,
          password: this.forms.marketing.password
        }
      }).then( res => {
        swal({
          title: 'Registrasi Sukses',
          text: 'Mengarahkan ke halaman profil...',
          icon: 'success'
        });
        setTimeout(() => {
          document.location = this.$root.url + '/marketing/profile';
        }, 2000);
      }).catch( err => {
        this.forms.submit = 'Daftar';
        if( err.response.status === 500 )
        {
          this.errors.errorMessage = err.response.statusText;
        }
        else
        {
          this.errors.errorMessage = err.response.data.statusText;
        }
      });
    }
  },
  mounted() {}
}
</script>

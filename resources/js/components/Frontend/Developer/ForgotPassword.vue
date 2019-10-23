<template>
  <div id="background">
    <div class="uk-card uk-card-body signin-box">
      <div class="uk-card-title signin-box-title">Reset Password</div>
      <div v-show="message.successMessage" class="uk-alert-success" uk-alert>{{ message.successMessage }}</div>
      <div v-show="message.errorMessage" class="uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
      <form class="uk-form-stacked uk-margin signin-form" @submit.prevent="onSendToken">
        <div class="uk-margin">
          <label class="uk-form-label signin-form-label">Email</label>
          <div class="uk-form-controls">
            <input type="email" class="uk-width-1-1 uk-input signin-form-input" v-model="forms.email" placeholder="Masukkan email Anda">
          </div>
          <div v-show="message.errors.email" class="uk-text-danger uk-text-small">{{ message.errors.email }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label signup-form-label">Tipe Pengguna</label>
          <div class="uk-form-controls">
            <div class="uk-grid-small" uk-grid>
              <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                <a @click="forms.usertype = 'developer'" :class="{ 'signup-btn-tabactive': forms.usertype === 'developer' }" class="uk-width-1-1 uk-button uk-button-primary signup-btn-tab">Developer</a>
              </div>
              <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                <a @click="forms.usertype = 'marketing'" :class="{ 'signup-btn-tabactive': forms.usertype === 'marketing' }" class="uk-width-1-1 uk-button uk-button-primary signup-btn-tab">Marketing</a>
              </div>
            </div>
          </div>
        </div>
        <div class="uk-margin">
          <button class="uk-width-1-1 uk-button uk-button-primary signin-form-submit" v-html="forms.submit"></button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      forms: {
        email: '',
        usertype: 'developer',
        submit: 'Reset Password'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false,
        successMessage: ''
      }
    }
  },
  methods: {
    onSendToken()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.successMessage = '';
      this.message.iserror = false;

      if( this.forms.email === '' )
      {
        this.message.errors.email = 'Masukkan email Anda';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;
      this.forms.submit = '<span uk-spinner></span>';

      axios({
        method: 'post',
        url: this.$root.url + '/developer/send_password_token/' + this.forms.usertype,
        params: {
          email: this.forms.email
        }
      }).then( res => {
        this.message.successMessage = 'Jika alamat email Anda ada di dalam database kami, Anda akan menerima email link password recovery dalam beberapa saat.';
        this.forms.submit = 'Reset Password';
      }).catch( err => {
        this.forms.submit = 'Reset Password';
        if( err.response.status === 500 )
        {
          this.message.errorMessage = err.response.statusText;
        }
        else
        {
          this.message.errorMessage = err.response.data.statusText;
        }
      });
    }
  }
}
</script>

<style lang="css" scoped>
  #background { background: #f9f9f9; }
</style>

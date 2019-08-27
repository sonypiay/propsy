<template>
  <div class="uk-tile uk-tile-default uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s uk-align-center">
    <div class="uk-margin uk-modal-title modal-login-title">
      Masuk
    </div>
    <div class="uk-margin modal-login-form">
      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <form class="uk-form-stacked" @submit.prevent="onLoginUser">
        <div class="uk-margin">
          <label class="uk-form-label modal-login-label">Username atau Email</label>
          <div class="uk-form-controls">
            <input type="text" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.username">
          </div>
          <div v-show="errors.name.username" class="uk-text-danger uk-text-small">{{ errors.name.username }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label modal-login-label">Password</label>
          <div class="uk-form-controls">
            <input type="password" class="uk-width-1-1 uk-input modal-login-input" v-model="forms.password">
          </div>
          <div v-show="errors.name.password" class="uk-text-danger uk-text-small">{{ errors.name.password }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label modal-login-label">Login sebagai</label>
          <div class="uk-form-controls">
            <div class="uk-grid-small" uk-grid>
              <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                <a @click="forms.isTabActive = 'dev'" :class="{ 'modal-btn-tabactive': forms.isTabActive === 'dev' }" class="uk-width-1-1 uk-button uk-button-primary modal-btn-tab">Developer</a>
              </div>
              <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                <a @click="forms.isTabActive = 'mkt'" :class="{ 'modal-btn-tabactive': forms.isTabActive === 'mkt' }" class="uk-width-1-1 uk-button uk-button-primary modal-btn-tab">Marketing</a>
              </div>
            </div>
          </div>
        </div>
        <div class="uk-margin">
          <button class="uk-width-1-1 uk-button uk-button-primary modal-login-submit" v-html="forms.submit"></button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
export default {
  props: [],
  data() {
    return {
      forms: {
        isTabActive: 'dev',
        username: '',
        password: '',
        submit: 'Masuk'
      },
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    onLoginUser()
    {
      var url = this.$root.url + '/authentication/login';
      if( this.forms.isTabActive === 'dev' ) url = url + '/developer';
      else url = url + '/marketing';

      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.username === '' )
      {
        this.errors.name.username = 'Masukkan username Anda';
        this.errors.iserror = true;
      }
      if( this.forms.password === '' )
      {
        this.errors.name.password = 'Masukkan password Anda';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;
      this.forms.submit = '<span uk-spinner></span>';

      axios({
        method: 'post',
        url: url,
        params: {
          username: this.forms.username,
          password: this.forms.password
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Mengarahkan ke halaman dashboard...',
          icon: 'success'
        });
        var redirect = this.$root.url;
        if( this.isTabActive === 'dev' ) redirect = redirect + '/developer/dashboard';
        else redirect = redirect + '/marketing/dashboard';
        setTimeout(() => { document.location = redirect; }, 2000);
      }).catch( err => {
        this.forms.submit = 'Masuk';
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

<style lang="css" scoped>
</style>

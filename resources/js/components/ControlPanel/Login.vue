<template>
  <div>
    <div class="uk-container uk-margin-large-top">
      <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s uk-align-center">
        <img class="uk-width-1-4 uk-align-center" :src="$root.url + '/images/brand/logo_maps_primary.png'" />
        <div class="uk-card uk-card-default uk-card-body">
          <h2 class="uk-h2 uk-text-center">Masuk</h2>
          <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
          <form class="uk-form-stacked uk-margin" @submit.prevent="onLogin">
            <div class="uk-margin">
              <label class="uk-form-label">Username</label>
              <div class="uk-form-controls">
                <div class="uk-width-1-1 uk-inline-clip">
                  <span class="uk-form-icon" uk-icon="user"></span>
                  <input type="text" class="uk-input uk-width-1-1" :class="{'uk-form-danger': errors.name.username}" placeholder="Username" v-model="forms.username" />
                </div>
              </div>
              <div v-show="errors.name.username" class="uk-text-danger">{{ errors.name.username }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label">Password</label>
              <div class="uk-form-controls">
                <div class="uk-width-1-1 uk-inline-clip">
                  <span class="uk-form-icon" uk-icon="lock"></span>
                  <input type="password" class="uk-input uk-width-1-1" :class="{'uk-form-danger': errors.name.password}" placeholder="Password" v-model="forms.password" />
                </div>
              </div>
              <div v-show="errors.name.password" class="uk-text-danger">{{ errors.name.password }}</div>
            </div>
            <div class="uk-margin">
              <button class="uk-width-1-1 uk-button uk-button-primary" v-html="forms.submit"></button>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: [],
  data() {
    return {
      forms: {
        username: '',
        password: '',
        submit: 'Masuk'
      },
      errors: {
        name: {},
        errorMessage: ''
      }
    }
  },
  methods: {
    onLogin()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.username === '' )
      {
        this.errors.name.username = 'Silakan masukkan username';
        this.errors.iserror = true;
      }
      if( this.forms.password === '' )
      {
        this.errors.name.password = 'Silakan masukkan password';
        this.errors.iserror = true;
      }

      if( this.errors.iserror === true ) return false;
      this.forms.submit = '<span uk-spinner></span>';

      axios({
        method: 'post',
        url: this.$root.url + '/cp/login',
        params: {
          username: this.forms.username,
          password: this.forms.password
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Login berhasil',
          icon: 'success',
          timer: 3000
        });
        setTimeout(() => {
          document.location = this.$root.url + '/cp';
        }, 2000);
      }).catch( err => {
        if( err.response.status === 500 ) this.errors.errorMessage = err.response.statusText;
        else this.errors.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Masuk';
      });
    }
  }
}
</script>

<template>
  <div id="background">
    <div class="uk-container">
      <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-2-3@m uk-width-1-2@s uk-align-center uk-margin-large-top uk-margin-large-bottom">
        <div class="uk-card uk-card-body signin-box">
          <div class="uk-card-title signin-box-title">Masuk Sebagai Marketing</div>
          <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
          <form class="uk-form-stacked uk-margin signin-form" @submit.prevent="onLoginUser">
            <div class="uk-margin">
              <label class="uk-form-label signin-form-label">Username atau Email</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-width-1-1 uk-input signin-form-input" v-model="forms.username">
              </div>
              <div v-show="errors.name.username" class="uk-text-danger uk-text-small">{{ errors.name.username }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signin-form-label">Password</label>
              <div class="uk-form-controls">
                <input type="password" class="uk-width-1-1 uk-input signin-form-input" v-model="forms.password">
              </div>
              <div v-show="errors.name.password" class="uk-text-danger uk-text-small">{{ errors.name.password }}</div>
            </div>
            <div class="uk-margin">
              <button class="uk-width-1-1 uk-button uk-button-primary signin-form-submit" v-html="forms.submit"></button>
            </div>
          </form>
        </div>
        <div class="uk-margin-top signin-box-signup">
          Belum punya akun? <a :href="$root.url + '/marketing/daftar'">Daftar Sekarang</a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      forms: {
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
      var url = this.$root.url + '/authentication/login/marketing';
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
          title: 'Login Berhasil',
          text: 'Mengarahkan ke halaman profil ...',
          icon: 'success'
        });
        setTimeout(() => { document.location = this.$root.url + '/marketing/profile'; }, 2000);
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
  }
}
</script>

<style lang="css" scoped>
  #background { background: #f9f9f9; }
</style>

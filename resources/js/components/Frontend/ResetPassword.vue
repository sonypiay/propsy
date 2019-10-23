<template>
  <div id="background">
    <div v-if="token == ''" class="uk-card uk-card-body signin-box">
      <div class="uk-text-muted uk-text-center">Token tidak ditemukan</div>
    </div>
    <div v-else-if="expired == 1" class="uk-card uk-card-body signin-box">
      <div class="uk-text-muted uk-text-center">Token telah kadaluarsa</div>
    </div>
    <div v-else class="uk-card uk-card-body signin-box">
      <div class="uk-card-title signin-box-title">Reset Password</div>
      <div v-show="message.successMessage" class="uk-alert-success" uk-alert>{{ message.successMessage }}</div>
      <div v-show="message.errorMessage" class="uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
      <form class="uk-form-stacked uk-margin signin-form" @submit.prevent="onResetPassword">
        <div class="uk-margin">
          <label class="uk-form-label signin-form-label">Password</label>
          <div class="uk-form-controls">
            <input type="password" class="uk-width-1-1 uk-input signin-form-input" v-model="forms.password" placeholder="Password baru">
          </div>
          <div v-show="message.errors.password" class="uk-text-danger uk-text-small">{{ message.errors.password }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label signin-form-label">Konfirmasi Password</label>
          <div class="uk-form-controls">
            <input type="password" class="uk-width-1-1 uk-input signin-form-input" v-model="forms.confirmpassword" placeholder="Konfirmasi Password baru">
          </div>
          <div v-show="message.errors.confirmpassword" class="uk-text-danger uk-text-small">{{ message.errors.confirmpassword }}</div>
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
  props: ['token', 'expired'],
  data() {
    return {
      forms: {
        password: '',
        confirmpassword: '',
        submit: 'Ganti Password'
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
    onResetPassword()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.successMessage = '';
      this.message.iserror = false;

      if( this.forms.password === '' )
      {
        this.message.errors.password = 'Silakan masukkan password baru Anda.';
        this.message.iserror = true;
      }

      if( this.forms.confirmpassword === '' )
      {
        this.message.errors.confirmpassword = 'Silakan konfirmasi password baru Anda.';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      if( this.forms.password.length < 8 )
      {
        this.message.errorMessage = 'Password minimum 8 karakter';
        return false;
      }

      if( this.forms.password !== this.forms.confirmpassword )
      {
        this.message.errorMessage = 'Password tidak sama';
        return false;
      }

      this.forms.submit = '<span uk-spinner></span>';

      axios({
        method: 'put',
        url: this.$root.url + '/password/change_password',
        params: {
          password: this.forms.password,
          token: this.token
        }
      }).then( res => {
        this.message.successMessage = 'Password berhasil diganti.';
        this.forms.submit = 'Ganti Password';
      }).catch( err => {
        this.forms.submit = 'Ganti Password';
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

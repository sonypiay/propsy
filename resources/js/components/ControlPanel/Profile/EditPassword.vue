<template>
  <div>
    <h3 class="uk-heading-line">
      <span>Ganti Password</span>
    </h3>
    <div class="uk-margin">
      <div v-show="message.errorMessage" class="uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
      <div v-show="message.success" class="uk-alert-success" uk-alert>{{ message.success }}</div>
      <form class="uk-form-stacked" @submit.prevent="onChangePassword">
        <div class="uk-margin">
          <label class="uk-form-label">Password Baru</label>
          <div class="uk-form-controls">
            <input type="password" class="uk-width-1-2 uk-input" :class="{'uk-form-danger': message.errors.password}" v-model="forms.password" />
          </div>
          <div v-show="message.errors.password" class="uk-text-danger">
            {{ message.errors.password }}
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label">Konfirmasi Password</label>
          <div class="uk-form-controls">
            <input type="password" class="uk-width-1-2 uk-input" :class="{'uk-form-danger': message.errors.confirmpassword}" v-model="forms.confirmpassword" />
          </div>
          <div v-show="message.errors.confirmpassword" class="uk-text-danger">
            {{ message.errors.confirmpassword }}
          </div>
        </div>
        <div class="uk-margin">
          <button class="uk-button uk-button-primary" v-html="forms.submit"></button>
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
        password: '',
        confirmpassword: '',
        submit: 'Ganti Password'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false,
        success: ''
      }
    }
  },
  methods: {
    onChangePassword()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.success = '';
      this.message.iserror = false;

      if( this.forms.password === '' )
      {
        this.message.errors.password = 'Silakan masukkan password baru';
        this.message.iserror = true;
      }
      if( this.forms.confirmpassword === '' )
      {
        this.message.errors.confirmpassword = 'Harap konfirmasi password baru';
        this.message.iserror = true;
      }
      if( this.message.iserror === true ) return false;

      if( this.forms.password.length < 8 )
      {
        this.message.errors.password = 'Password minimal 8 karakter';
        return false;
      }
      if( this.forms.confirmpassword !== this.forms.password )
      {
        this.message.errors.confirmpassword = 'Kombinasi password tidak sama';
        return false;
      }

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/account/edit_profile/password',
        params: {
          password: this.forms.password
        }
      }).then( res => {
        let messageSuccess = 'Password berhasil diganti';
        swal({
          title: 'Berhasil',
          text: messageSuccess,
          icon: 'success'
        });
        this.message.success = messageSuccess;
        setTimeout(() => { document.location = this.$root.url + '/cp/account/profile/password'; }, 2000);
      }).catch( err => {
        if( err.response.status === 500 ) this.message.errorMessage = err.response.statusText;
        else this.message.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Ganti Password';
      });
    }
  }
}
</script>

<style lang="css" scoped>
</style>

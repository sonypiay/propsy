<template>
  <div>
    <div class="uk-heading-line uk-text-center uk-margin-bottom side-content-profile-heading"><span>Password</span></div>
    <div v-show="errors.errorMessage !== null" class="uk-margin uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
    <form class="uk-form-stacked content-form" @submit.prevent="onChangePassword">
      <div class="uk-margin">
        <label class="uk-form-label content-form-label">Ganti Password</label>
        <div class="uk-form-controls">
          <input type="password" v-model="forms.password" class="uk-width-1-2 uk-input content-form-input">
        </div>
      </div>
      <div class="uk-margin">
        <label class="uk-form-label content-form-label">Konfirmasi Password</label>
        <div class="uk-form-controls">
          <input type="password" v-model="forms.confirmpassword" class="uk-width-1-2 uk-input content-form-input">
        </div>
      </div>
      <div class="uk-margin">
        <button class="uk-button uk-button-primary content-form-btn" v-html="forms.submit"></button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'isMenuActive'],
  data() {
    return {
      forms: {
        password: '',
        confirmpassword: '',
        submit: 'Simpan'
      },
      errors: {
        errorMessage: null,
        iserror: false
      }
    }
  },
  methods: {
    onChangePassword()
    {
      this.errors.errorMessage = null;
      this.errors.iserror = false;

      if( this.forms.password === '' || this.forms.confirmpassword === '' )
      {
        this.errors.errorMessage = 'Whoops, kolom password tidak boleh kosong.';
        return false;
      }

      if( this.forms.password.length < 8 )
      {
        this.errors.errorMessage = 'Password terlalu pendek. Password minimal 8 (delapan) karakter.';
        return false;
      }

      if( this.forms.password !== this.forms.confirmpassword )
      {
        this.errors.errorMessage = 'Password tidak sama.';
        return false;
      }

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/marketing/profile/change_password',
        params: { password: this.forms.password }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Berhasil melakukan perubahan password.',
          icon: 'success'
        });
        this.forms.password = '';
        this.forms.confirmpassword = '';
        this.forms.submit = 'Simpan';
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
    }
  }
}
</script>

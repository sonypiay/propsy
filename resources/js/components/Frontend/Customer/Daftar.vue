<template>
  <div id="background">
    <div class="uk-container">
      <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-2-3@m uk-width-1-2@s uk-align-center uk-margin-large-top uk-margin-large-bottom">
        <div class="uk-card uk-card-body signup-box">
          <div class="uk-card-title signup-box-title">Daftar Sebagai Konsumen</div>
          <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
          <p class="signup-form-mustcomplete">Lengkapi Formulir dibawah ini</p>
          <form class="uk-margin uk-form-stacked signup-form" @submit.prevent="onSignUpCustomer">
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Nama Lengkap</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.fullname">
              </div>
              <div v-show="errors.name.fullname" class="uk-text-danger uk-text-small">{{ errors.name.fullname }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Email</label>
              <div class="uk-form-controls">
                <input type="email" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.email">
              </div>
              <div v-show="errors.name.email" class="uk-text-danger uk-text-small">{{ errors.name.email }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Username</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.username">
              </div>
              <div v-show="errors.name.username" class="uk-text-danger uk-text-small">{{ errors.name.username }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Password</label>
              <div class="uk-form-controls">
                <input type="password" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.password">
              </div>
              <div v-show="errors.name.password" class="uk-text-danger uk-text-small">{{ errors.name.password }}</div>
            </div>
            <div class="uk-margin">
              <button class="uk-width-1-1 uk-button uk-button-primary signup-form-submit" v-html="forms.submit"></button>
            </div>
          </form>
        </div>
        <div class="uk-margin-top signup-box-signin">
          Sudah punya akun? <a :href="$root.url + '/marketing/masuk'">Masuk</a>
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
        fullname: '',
        email: '',
        username: '',
        password: '',
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
    onSignUpCustomer()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.fullname === '' )
      {
        this.errors.name.fullname = 'Masukkan nama nengkap Anda';
        this.errors.iserror = true;
      }
      if( this.forms.email === '' )
      {
        this.errors.name.email = 'Masukkan alamat email Anda';
        this.errors.iserror = true;
      }
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

      if( this.forms.password.length < 8 )
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
        url: this.$root.url + '/registration/customer',
        params: this.forms
      }).then( res => {
        swal({
          title: 'Registrasi Sukses',
          text: 'Mengarahkan ke halaman profil ...',
          icon: 'success'
        });
        setTimeout(() => {
          document.location = this.$root.url + '/customer/profile';
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
  }
}
</script>

<style media="screen" scoped>
  #background {
    background: #f9f9f9;
  }
</style>

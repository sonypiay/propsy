<template>
  <div id="background">
    <div class="uk-container">
      <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-2-3@m uk-width-1-2@s uk-align-center uk-margin-large-top uk-margin-large-bottom">
        <div class="uk-card uk-card-body signup-box">
          <div class="uk-card-title signup-box-title">Daftar Sebagai Pengembang</div>
          <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
          <p class="signup-form-mustcomplete">Lengkapi Formulir dibawah ini</p>
          <form class="uk-margin uk-form-stacked signup-form" @submit.prevent="onSignUpDeveloper">
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Username</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.dev_username">
              </div>
              <div v-show="errors.name.dev_username" class="uk-text-danger uk-text-small">{{ errors.name.dev_username }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Password</label>
              <div class="uk-form-controls">
                <input type="password" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.dev_password">
              </div>
              <div v-show="errors.name.dev_password" class="uk-text-danger uk-text-small">{{ errors.name.dev_password }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Email</label>
              <div class="uk-form-controls">
                <input type="email" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.dev_email">
              </div>
              <div v-show="errors.name.dev_email" class="uk-text-danger uk-text-small">{{ errors.name.dev_email }}</div>
            </div>
            <hr>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Nama Pengembang</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.dev_name">
              </div>
              <div v-show="errors.name.dev_name" class="uk-text-danger uk-text-small">{{ errors.name.dev_name }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">*Nama Pemilik</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-width-1-1 uk-input signup-form-input" v-model="forms.dev_ownername">
              </div>
              <div v-show="errors.name.dev_ownername" class="uk-text-danger uk-text-small">{{ errors.name.dev_ownername }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">Jenis Pengembang</label>
              <div class="uk-form-controls">
                <div class="uk-grid-small" uk-grid>
                  <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                    <a @click="forms.dev_ownership = 'perusahaan'" :class="{ 'signup-btn-tabactive': forms.dev_ownership === 'perusahaan' }" class="uk-width-1-1 uk-button uk-button-primary signup-btn-tab">Perusahaan</a>
                  </div>
                  <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                    <a @click="forms.dev_ownership = 'individu'" :class="{ 'signup-btn-tabactive': forms.dev_ownership === 'individu' }" class="uk-width-1-1 uk-button uk-button-primary signup-btn-tab">Individu</a>
                  </div>
                </div>
              </div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label signup-form-label">Tentang Pengembang</label>
              <div class="uk-form-controls">
                <textarea class="uk-width-1-1 uk-textarea uk-height-small signup-form-input" v-model="forms.dev_biography"></textarea>
              </div>
            </div>
            <div class="uk-margin">
              <button class="uk-width-1-1 uk-button uk-button-primary signup-form-submit" v-html="forms.submit"></button>
            </div>
          </form>
        </div>
        <div class="uk-margin-top signup-box-signin">
          Sudah punya akun? <a :href="$root.url + '/developer/masuk'">Masuk</a>
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
        dev_name: '',
        dev_email: '',
        dev_ownername: '',
        dev_biography: '',
        dev_username: '',
        dev_password: '',
        dev_ownership: 'perusahaan',
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
    onSignUpDeveloper()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.dev_username === '' )
      {
        this.errors.name.dev_username = 'Masukkan username Anda';
        this.errors.iserror = true;
      }
      if( this.forms.dev_password === '' )
      {
        this.errors.name.dev_password = 'Masukkan password Anda';
        this.errors.iserror = true;
      }
      if( this.forms.dev_email === '' )
      {
        this.errors.name.dev_email = 'Masukkan email Anda';
        this.errors.iserror = true;
      }
      if( this.forms.dev_name === '' )
      {
        this.errors.name.dev_name = 'Masukkan nama pengembang';
        this.errors.iserror = true;
      }
      if( this.forms.dev_ownername === '' )
      {
        this.errors.name.dev_ownername = 'Masukkan nama pemilik pengembang';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      if( this.forms.dev_password.length < 8 )
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
        url: this.$root.url + '/registration/developer',
        params: this.forms
      }).then( res => {
        swal({
          title: 'Registrasi Sukses',
          text: 'Mengarahkan ke halaman profil',
          icon: 'success'
        });
        setTimeout(() => {
          document.location = this.$root.url + '/developer/profile';
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

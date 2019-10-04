<template>
  <div>
    <h3 class="uk-heading-line">
      <span>Informasi Akun</span>
    </h3>
    <div class="uk-margin">
      <div v-show="message.errorMessage" class="uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
      <div v-show="message.success" class="uk-alert-success" uk-alert>{{ message.success }}</div>
      <form class="uk-form-stacked" @submit.prevent="onChangeAccount">
        <div class="uk-margin">
          <label class="uk-form-label">Nama Lengkap</label>
          <div class="uk-form-controls">
            <input type="text" class="uk-width-1-2 uk-input" :class="{'uk-form-danger': message.errors.fullname}" v-model="forms.fullname" />
          </div>
          <div v-show="message.errors.fullname" class="uk-text-danger">
            {{ message.errors.fullname }}
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label">Username</label>
          <div class="uk-form-controls">
            <input type="tel" class="uk-width-1-2 uk-input" :class="{'uk-form-danger': message.errors.username}" v-model="forms.username" />
          </div>
          <div v-show="message.errors.username" class="uk-text-danger">
            {{ message.errors.username }}
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
  props: ['session_user'],
  data() {
    return {
      forms: {
        fullname: this.session_user.admin_fullname,
        username: this.session_user.admin_username,
        submit: 'Ubah Data'
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
    onChangeAccount()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.success = '';
      this.message.iserror = false;

      if( this.forms.fullname === '' )
      {
        this.message.errors.fullname = 'Nama tidak boleh kosong';
        this.message.iserror = true;
      }
      if( this.forms.username === '' )
      {
        this.message.errors.username = 'Username tidak boleh kosong';
        this.message.iserror = true;
      }
      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/account/edit_profile/profile',
        params: {
          username: this.forms.username,
          fullname: this.forms.fullname
        }
      }).then( res => {
        let messageSuccess = 'Informasi akun berhasil diubah';
        swal({
          title: 'Berhasil',
          text: messageSuccess,
          icon: 'success'
        });
        this.message.success = messageSuccess;
        setTimeout(() => { document.location = this.$root.url + '/cp/account/profile/profile'; }, 2000);
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

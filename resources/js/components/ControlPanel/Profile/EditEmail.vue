<template>
  <div>
    <h3 class="uk-heading-line">
      <span>Ganti Email</span>
    </h3>
    <div class="uk-margin">
      <div v-show="message.errorMessage" class="uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
      <div v-show="message.success" class="uk-alert-success" uk-alert>{{ message.success }}</div>
      <form class="uk-form-stacked" @submit.prevent="onChangeEmail">
        <div class="uk-margin">
          <label class="uk-form-label">Email</label>
          <div class="uk-form-controls">
            <input type="email" class="uk-width-1-2 uk-input" :class="{'uk-form-danger': message.iserror === true}" v-model="forms.email" />
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
        email: this.session_user.admin_email,
        submit: 'Ganti Email'
      },
      message: {
        errorMessage: '',
        iserror: false,
        success: ''
      }
    }
  },
  methods: {
    onChangeEmail()
    {
      this.message.errorMessage = '';
      this.message.success = '';
      this.message.iserror = false;

      if( this.forms.email === '' )
      {
        this.message.iserror = true;
      }

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/account/edit_profile/email',
        params: {
          email: this.forms.email
        }
      }).then( res => {
        let messageSuccess = 'Email berhasil diganti';
        swal({
          title: 'Berhasil',
          text: messageSuccess,
          icon: 'success'
        });
        this.message.success = messageSuccess;
        setTimeout(() => { document.location = this.$root.url + '/cp/account/profile/email'; }, 2000);
      }).catch( err => {
        if( err.response.status === 500 ) this.message.errorMessage = err.response.statusText;
        else this.message.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Ganti Email';
      });
    }
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div class="uk-heading-line uk-text-center uk-margin-bottom side-content-profile-heading"><span>Alamat Email</span></div>
    <div v-show="errors.errorMessage !== null" class="uk-margin uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
    <form class="uk-form-stacked content-form" @submit.prevent="onChangeEmail">
      <div class="uk-margin">
        <label class="uk-form-label content-form-label">Ganti Email</label>
        <div class="uk-form-controls">
          <input type="email" v-model="forms.email" :placeholder="session_user.mkt_email" class="uk-width-1-2 uk-input content-form-input">
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
        email: '',
        submit: 'Simpan'
      },
      errors: {
        errorMessage: null,
        iserror: false
      }
    }
  },
  methods: {
    onChangeEmail()
    {
      this.errors.errorMessage = null;
      this.errors.iserror = false;

      if( this.forms.email === '' )
      {
        this.errors.errorMessage = 'Whoops, email tidak boleh kosong.';
        return false;
      }

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/marketing/profile/change_email',
        params: { email: this.forms.email }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Alamat Email berhasil diubah.',
          icon: 'success'
        });
        this.session_user.mkt_email = this.forms.email;
        this.forms.email = '';
        this.forms.submit = 'Simpan';
      }).catch( err => {
        if( err.response.status === 500 ) this.errors.errorMessage = err.response.statusText;
        else this.errors.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Simpan';
      });
    }
  }
}
</script>

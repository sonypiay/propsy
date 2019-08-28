<template>
  <div>
    <div class="uk-heading-line uk-text-center uk-margin-bottom side-content-profile-heading"><span>Foto Profil</span></div>
    <div v-show="errors.errorMessage !== null" class="uk-margin uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
    <form class="uk-form-stacked content-form" @submit.prevent="onUploadPhoto">
      <div class="uk-margin">
        <label class="uk-form-label content-form-label">Unggah Foto</label>
        <div class="uk-form-controls">
          <div class="uk-width-1-4 uk-margin-small-top" uk-form-custom>
            <input accept="image/*" type="file" @change="onGetFileData">
            <div v-if="forms.photo === ''" class="uk-tile uk-tile-default content-upload-picture">
              <span uk-icon="icon: plus-circle;"></span>
              <div class="uk-text-small">Choose a picture or drag here</div>
            </div>
            <div v-else class="content-upload-picture">
              <img :src="forms.photo" alt="">
            </div>
          </div>
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
        photo: '',
        filedata: '',
        submit: 'Simpan'
      },
      errors: {
        errorMessage: null,
        iserror: false
      }
    }
  },
  methods: {
    onGetFileData(event)
    {
      this.forms.filedata = '';
      if( event.target.files.length !== 0 )
      {
        this.forms.filedata = event.target.files[0];
        this.forms.photo = URL.createObjectURL( this.forms.filedata );
      }
    },
    onUploadPhoto()
    {
      this.errors.errorMessage = null;
      this.errors.iserror = false;

      if( this.forms.filedata === '' )
      {
        this.errors.errorMessage = 'File tidak boleh kosong.';
        return false;
      }

      let formdata = new FormData();
      formdata.append('photo_profie', this.forms.filedata);
      this.forms.submit = '<span uk-spinner></span>';

      axios.post( this.$root.url + '/marketing/profile/upload_photo_profile', formdata).then( res => {
        swal({
          title: 'Sukses',
          text: 'Foto profil berhasil diunggah.',
          icon: 'success'
        });
        setTimeout(() => { document.location = ''; }, 2000);
      }).catch( err => {
        if( err.response.status === 500 ) this.errors.errorMessage = err.response.statusText;
        else this.errors.errorMessage = err.response.data.statusText;
      });
    }
  }
}
</script>

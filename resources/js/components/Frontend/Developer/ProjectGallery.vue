<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Galeri Proyek - {{ projects.project_name }}</div>
      <div v-show="galleries.errorMessage" class="uk-alert-danger" uk-alert>{{ galleries.errorMessage }}</div>
      <div v-if="galleries.isLoading === true" class="uk-text-center">
        <span uk-spinner></span>
      </div>
      <div v-else class="dash-grid-box">
        <div v-if="galleries.total === 0">
          <div class="uk-margin uk-alert-warning" uk-alert>Tidak ada galeri yang ditampilkan.</div>
          <div class="uk-margin uk-width-1-4@xl uk-width-1-4@l uk-width-1-2@m uk-width-1-1@s">
            <progress v-show="files.uploadProgress !== 0" class="uk-progress" :value="files.uploadProgress" max="100"></progress>
            <div class="uk-width-1-1" uk-form-custom>
              <input type="file" accept="image/*" @change="onSelectFile">
              <div v-if="files.photo === null" class="uk-tile uk-tile-default uk-text-center grid-upload-gallery">
                <span uk-icon="icon: plus-circle; ratio: 3"></span>
              </div>
              <div v-else class="grid-upload-gallery">
                <img :src="files.photo" :alt="files.photo">
              </div>
            </div>
            <button class="uk-width-1-1 uk-button uk-button-primary uk-margin dash-btn" @click="onUploadGallery()" v-html="galleries.submit"></button>
          </div>
        </div>
        <div v-else class="uk-margin uk-grid-small" uk-grid="masonry: true" uk-lightbox="animation: slide">
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <progress v-show="files.uploadProgress !== 0" class="uk-progress" :value="files.uploadProgress" max="100"></progress>
            <div class="uk-width-1-1" uk-form-custom>
              <input type="file" accept="image/*" @change="onSelectFile">
              <div v-if="files.photo === null" class="uk-tile uk-tile-default uk-text-center grid-upload-gallery">
                <span uk-icon="icon: plus-circle; ratio: 3"></span>
              </div>
              <div v-else class="grid-upload-gallery">
                <img :src="files.photo" :alt="files.photo">
              </div>
            </div>
            <button class="uk-width-1-1 uk-button uk-button-primary uk-margin dash-btn" @click="onUploadGallery()" v-html="galleries.submit"></button>
          </div>
          <div v-for="gallery in galleries.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-inline-clip uk-transition-toggle">
              <img class="uk-transition-scale-up uk-transition-opaque" :src="$root.url + '/images/project/gallery/' + gallery.gallery_filename" :alt="$root.url + '/images/project/gallery/' + gallery.gallery_name">
              <div class="uk-transition-fade uk-overlay uk-overlay-primary uk-position-cover">
                <div class="uk-position-center">
                  <a class="uk-button uk-button-primary uk-button-small grid-overlay-icon" :href="$root.url + '/images/project/gallery/' + gallery.gallery_filename">
                    <i class="icon ion-ios-eye"></i>
                  </a>
                  <button uk-tooltip="Jadikan sebagai thumbnail" @click="setAsThumbnail( gallery.gallery_id )" class="uk-button uk-button-primary uk-button-small grid-overlay-icon">
                    <i class="icon ion-ios-image"></i>
                  </button>
                  <button uk-tooltip="Hapus" @click="onDeleteGallery( gallery.gallery_id )" class="uk-button uk-button-primary uk-button-small grid-overlay-icon">
                    <i class="icon ion-ios-trash"></i>
                  </button>
                </div>
              </div>
            </div>
            <!--<a class="uk-inline" :href="$root.url + '/images/project/gallery/' + gallery.gallery_filename"></a>-->
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'projects'],
  data() {
    return {
      files: {
        data: null,
        photo: null,
        uploadProgress: 0
      },
      galleries: {
        isLoading: false,
        submit: 'Unggah',
        total: 0,
        results: [],
        errorMessage: ''
      }
    }
  },
  methods: {
    getGalleries()
    {
      this.galleries.isLoading = true;
      axios({
        method: 'get',
        url: this.$root.url + '/developer/project/data_gallery/' + this.projects.project_unique_id
      }).then( res => {
        let result = res.data;
        this.galleries.total = result.data.total;
        this.galleries.results = result.data.row;
        this.galleries.isLoading = false;
      }).catch( err => {
        this.galleries.errorMessage = err.response.statusText;
      });
    },
    onSelectFile( event )
    {
      this.files.photo = null;
      this.files.data = null;

      if( event.target.files.length !== 0 )
      {
        this.files.data = event.target.files[0];
        this.files.photo = URL.createObjectURL( this.files.data );
      }
    },
    onUploadGallery()
    {
      if( this.files.data === null ) return false;
      this.files.uploadProgress = 0;
      let url = this.$root.url + '/developer/project/upload_gallery/' + this.projects.project_unique_id;

      var formdata = new FormData();
      formdata.append('image', this.files.data);
      axios.post( url, formdata, {
        onUploadProgress: function( e )
        {
          this.files.uploadProgress = parseInt( Math.round( e.loaded * 100 ) / e.total );
        }.bind(this)
      }).then( res => {
        let result = res.data;
        swal({
          title: 'Sukses',
          text: 'Gambar berhasil diunggah.',
          icon: 'success'
        });
        setTimeout(() => {
          this.files.uploadProgress = 0;
          this.files.data = null;
          this.files.photo = null;
          this.getGalleries();
        }, 2000);
      }).catch( err => {
        swal({
          title: 'Whoops',
          text: 'Terjadi kesalahan.' + err.response.statusText,
          icon: 'error',
          dangerMode: true
        });
      });
    },
    setAsThumbnail( id ) {
      swal({
        text: 'Jadikan sebagai thumbnail proyek?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal', confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/developer/project/set_asthumbnail/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Berhasil dijadikan sebagai thumbnail',
              icon: 'success'
            });
            setTimeout(() => {
              document.location = this.$root.url + '/developer/project/manage_project';
            }, 2000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan.' + err.response.statusText,
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
    },
    onDeleteGallery( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus foto ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal', confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/developer/project/delete_gallery/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Foto berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => { this.getGalleries(); }, 2000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan.' + err.response.statusText,
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
    }
  },
  mounted() {
    this.getGalleries();
  }
}
</script>

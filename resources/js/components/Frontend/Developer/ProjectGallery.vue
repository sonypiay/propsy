<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Galeri Proyek</div>
      <div v-show="galleries.errorMessage" class="uk-alert-danger" uk-alert>{{ galleries.errorMessage }}</div>
      <div v-if="galleries.isLoading === true" class="uk-text-center">
        <span uk-spinner></span>
      </div>
      <div v-else class="dash-grid-box">
        <div v-if="galleries.total === 0">
          <div class="uk-margin uk-alert-warning" uk-alert>Tidak ada galeri yang ditampilkan.</div>
          <div class="uk-margin uk-width-1-4@xl uk-width-1-4@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-width-1-1" uk-form-custom>
              <input type="file" accept="image/*" @change="onSelectFile">
              <div class="uk-tile uk-tile-default uk-text-center grid-upload-gallery">
                <span uk-icon="icon: plus-circle; ratio: 3"></span>
              </div>
            </div>
            <button class="uk-width-1-1 uk-button uk-button-primary uk-margin dash-btn" @click="" v-html="galleries.submit"></button>
          </div>
        </div>
        <div v-else class="uk-margin uk-grid-small" uk-grid="masonry: true" uk-lightbox="animation: slide">
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div uk-form-custom>
              <input type="file" accept="image/*" @change="onSelectFile">
              <div class="uk-tile uk-tile-default uk-text-center grid-upload-gallery">
                <span uk-icon="icon: plus-circle; ratio: 4"></span>
              </div>
            </div>
          </div>
          <div v-for="gallery in galleries.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <a class="uk-inline" :href="$root.url + '/images/banner/homepage2.jpg'" :data-caption="'Caption 1'">
              <img :src="$root.url + '/images/banner/homepage2.jpg'" alt="">
            </a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'projectid'],
  data() {
    return {
      files: {
        data: null,
        photo: null
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
        url: this.$root.url + '/developer/project/data_gallery/' + this.projectid
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
        this.files.photos = URL.createObjectURL( this.files.data );
      }
    },
    onUploadGallery( gallery_id )
    {
      if( gallery_id === undefined )
      {

      }
      else
      {
        
      }
    }
  },
  mounted() {
    this.getGalleries();
  }
}
</script>

<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">
        {{ projects.project_name }}
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ getarea.provinsi.area_name }},
        {{ getarea.kota.area_name }}<br>
        {{ projects.project_address }}
      </div>
      <div v-if="galleries.isLoading === true">
        <span uk-spinner></span>
      </div>
      <div v-else>
        <div v-if="galleries.total === 0" class="uk-margin uk-alert-warning" uk-alert>
          Tidak ada galeri
        </div>
        <div v-else>
          <div class="uk-card-title uk-margin dashboard-content-heading">
            Galeri Proyek
          </div>
          <div uk-slider>
            <div class="uk-margin uk-position-relative uk-visible-toggle uk-light" tabindex="-1">
              <ul class="uk-slider-items uk-grid-collapse uk-grid-match" uk-height-viewport="offset-top: true; offset-bottom: 30" uk-lightbox>
                <li v-for="gallery in galleries.results" class="uk-width-1-4@xl uk-width-1-4@l uk-width-1-2@m uk-width-1-2@s">
                  <div class="uk-cover-container">
                    <img :src="$root.url + '/images/project/gallery/' + gallery.gallery_filename" :alt="$root.url + '/images/project/gallery/' + gallery.gallery_name" uk-cover>
                    <div class="uk-position-cover uk-overlay uk-overlay-primary">
                      <div class="uk-position-center">
                        <a class="uk-display-block" :href="$root.url + '/images/project/gallery/' + gallery.gallery_filename">
                          <span uk-icon="icon: search; ratio: 2"></span>
                        </a>
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
              <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slider-item="previous"></a>
              <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slider-item="next"></a>
            </div>
          </div>
        </div>
      </div>

      <div class="uk-card-title uk-margin dashboard-content-heading">
        Deskripsi Proyek
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ projects.project_description }}
      </div>

      <!-- Unit -->
      <div class="uk-card-title uk-margin dashboard-content-heading">
        Unit Proyek
      </div>
      <!-- Unit -->
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'projects', 'getarea'],
  data() {
    return {
      galleries: {
        isLoading: false,
        total: 0,
        results: []
      }
    }
  },
  methods: {
    getGalleries()
    {
      this.galleries.isLoading = true;
      axios({
        method: 'get',
        url: this.$root.url + '/developer/project/data_gallery/' + this.projects.project_id
      }).then( res => {
        let result = res.data;
        this.galleries.total = result.data.total;
        this.galleries.results = result.data.row;
        this.galleries.isLoading = false;
      }).catch( err => {
        this.galleries.errorMessage = err.response.statusText;
      });
    },
  },
  mounted() {
    this.getGalleries();
  }
}
</script>

<style lang="css" scoped>
</style>

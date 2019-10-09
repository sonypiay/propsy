<template>
  <div>
    <div class="uk-margin-large-top uk-padding-large hmpg-listproject">
      <div class="uk-container">
        <div class="uk-margin-bottom hmpg-listproject-heading">Proyek Pengembang yang Tersedia</div>
          <div class="uk-padding hmpg-slider-project" uk-slider>
            <div class="uk-position-relative uk-visible-toggle uk-dark" tabindex="-1">
              <ul class="uk-slider-items uk-child-width-1-3@xl uk-child-width-1-3@l uk-child-width-1-3@m uk-child-width-1-2@s uk-grid uk-grid-match">
                <li v-for="p in projects.results">
                  <div class="uk-card uk-card-default uk-card-small hmpg-avail-project">
                    <div class="uk-card-media-top">
                      <div v-if="p.project_thumbnail === null" class="uk-background-cover uk-panel hmpg-card-noimage" :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage2.jpg'}">
                        <div class="uk-overlay uk-overlay-primary uk-position-cover uk-light hmpg-card-overlay">
                          <div class="uk-position-center">
                            <p>{{ p.dev_name }}</p>
                          </div>
                        </div>
                      </div>
                      <div v-else class="uk-background-cover uk-panel hmpg-card-withimage" :style="{'background-image': 'url(' + $root.url + '/storage/assets/images/project/gallery/' + p.project_thumbnail + ')'}">
                        <div class="uk-overlay uk-overlay-primary uk-position-cover uk-light hmpg-card-overlay">
                          <div class="uk-position-center">
                            <p>{{ p.dev_name }}</p>
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="uk-card-body">
                      <a :href="$root.url + '/project/view/' + p.project_slug" class="uk-card-title hmpg-card-title">{{ p.project_name }}</a>
                      <div class="hmpg-card-meta">{{ $root.formatDate( p.created_at, 'DD MMMM YYYY' ) }}</div>
                      <div class="uk-text-truncate uk-margin-top hmpg-card-content" v-html="$root.htmlStripTags( p.project_description, 300 )">
                      </div>
                    </div>
                  </div>
                </li>
              </ul>
            </div>
            <div class="uk-margin-top uk-flex uk-flex-center">
              <a class="uk-hidden-hover" href="#" uk-slidenav-previous uk-slider-item="previous"></a>
              <a class="uk-hidden-hover" href="#" uk-slidenav-next uk-slider-item="next"></a>
            </div>
            <!--<ul class="uk-slider-nav uk-dotnav uk-flex-center uk-margin"></ul>-->
          </div>
          <div class="uk-text-center">
            <a :href="$root.url + '/project/browse_project'" class="uk-margin-top uk-button uk-button-primary browse_project_btn">Lihat Proyek Lainnya</a>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user'],
  data() {
    return {
      projects: {
        total: 0,
        results: []
      }
    }
  },
  methods: {
    getAvailableProject()
    {
      axios.get( this.$root.url + '/project/available' ).then( res => {
        let result = res.data;
        this.projects.total = result.results.total;
        this.projects.results = result.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    }
  },
  mounted() {
    this.getAvailableProject();
  }
}
</script>

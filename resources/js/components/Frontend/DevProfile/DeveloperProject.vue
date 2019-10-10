<template>
  <div>
    <div class="uk-panel uk-margin">
      <h3 class="uk-h3">Proyek Pengembang</h3>
      <div class="uk-grid-small uk-grid-match" uk-grid>
        <div v-for="project in projectlist.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
          <a :href="$root.url + '/project/view/' + project.project_slug" class="uk-card uk-card-default uk-display-block grid-project-card">
            <div class="uk-card-media-left">
              <div class="uk-cover-container uk-height-medium">
                <img v-if="project.project_thumbnail" :src="$root.url + '/storage/assets/images/project/gallery/' + project.project_thumbnail" uk-cover />
                <img v-else :src="$root.url + '/images/banner/homepage3.jpg'" uk-cover />
                <div class="uk-overlay uk-overlay-primary uk-position-cover project-card-background">
                  <div class="uk-position-bottom">
                    <div class="uk-padding-small project-card-title">
                      {{ project.project_name }}
                      <div class="project-card-devname">{{ project.dev_name }}</div>
                      <div class="project-card-location">
                        <span uk-icon="icon: location; ratio: 1"></span> {{ project.city_name }}, {{ project.province_name }}
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="uk-card-body uk-card-small project-card-body">
              <div class="uk-margin">
                <div class="project-card-status">
                  <label v-if="project.project_status === 'sold'" class="uk-label uk-label-danger">Terjual</label>
                  <label v-else-if="project.project_status === 'soon'" class="uk-label uk-label-warning">Segera</label>
                  <label v-else class="uk-label uk-label-success">Tersedia</label>
                </div>
              </div>
              <div class="uk-margin">
                <div class="project-card-list">
                  <span class="projectlist-text">Jenis Properti</span>
                  <span v-if="project.project_type === 'residensial'" class="projectlist-subtext">Residensial</span>
                  <span v-else class="projectlist-subtext">Apartemen</span>
                </div>
                <div v-if="project.unit_price" class="project-card-list">
                  <span class="projectlist-text">Harga Mulai dari</span>
                  <span class="projectlist-subtext">Rp. {{ project.unit_price | currency }}</span>
                </div>
                <div v-if="project.unit_price" class="project-card-list">
                  <span class="projectlist-text">Luas Bangunan mulai dari </span>
                  <span class="projectlist-subtext">{{ project.unit_lb }} m<sup>2</sup></span>
                </div>
                <div v-if="project.project_status === 'soon'" class="project-card-list">
                  <span class="projectlist-text">Opening </span>
                  <span class="projectlist-subtext">{{ project.project_estimate_launch }}</span>
                </div>
              </div>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getdeveloper'],
  data() {
    return {
      projectlist: {
        total: 0,
        results: []
      }
    }
  },
  methods: {
    getProjectList()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/project/project_developer/' + this.getdeveloper.dev_slug
      }).then( res => {
        let result = res.data;
        this.projectlist.total = result.result.total;
        this.projectlist.results = result.result.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    }
  },
  mounted() {
    this.getProjectList();
  }
}
</script>

<style lang="css" scoped>
</style>

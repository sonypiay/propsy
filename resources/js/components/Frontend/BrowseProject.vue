<template>
  <div id="background">
    <div class="uk-cover-container uk-height-medium">
      <img :src="this.$root.url + '/images/banner/homepage3.jpg'" uk-cover />
      <div class="uk-overlay uk-position-cover container-bannersearch">
        <div class="uk-position-center">
          <div class="uk-width-1-1">
            <div class="uk-margin-small-bottom bannersearch-heading">Cari Proyek Murah</div>
            <div class="bannersearch-form">
              <div class="uk-form-stacked uk-grid-small" uk-grid>
                <div class="uk-width-1-2">
                  <select class="uk-width-1-1 uk-select search-form" v-model="forms.type" @change="getProjectList()">
                    <option value="all">Semua Tipe</option>
                    <option value="apartemen">Apartemen</option>
                    <option value="residensial">Residensial</option>
                  </select>
                </div>
                <div class="uk-width-1-2">
                  <select class="uk-width-1-1 uk-select search-form" v-model="forms.city.value" @change="getProjectList()">
                    <option value="all">Semua Kota</option>
                    <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
                  </select>
                </div>
                <div class="uk-width-1-1">
                  <div class="uk-width-1-1 uk-inline">
                    <span class="uk-form-icon" uk-icon="search"></span>
                    <input type="search" class="uk-width-1-1 uk-input search-form" v-model="forms.keywords" placeholder="Cari proyek atau nama developer" @keyup.enter="getProjectList()" />
                  </div>
                </div>
                <div class="uk-width-1-1">
                  <button class="uk-button uk-button-primary search-button-form" @click="getProjectList()" v-html="forms.submitsearch"></button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-margin-large-top uk-margin-large-bottom uk-container">
      <div v-if="getproject.isLoading" class="uk-margin uk-text-center">
        <span uk-spinner></span>
      </div>
      <div v-else class="uk-margin">
        <div v-if="getproject.total === 0" class="uk-alert-warning" uk-alert>
          Belum ada proyek
        </div>
        <div v-else class="uk-margin uk-grid-medium uk-grid-match" uk-grid>
          <div class="uk-width-1-1">
            <div class="uk-text-large">
              <strong>{{ getproject.total }}</strong> Hasil ditemukan di {{ forms.city.name }}
            </div>
          </div>
          <div v-for="project in getproject.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
            <a :href="$root.url + '/project/view/' + project.project_slug" class="uk-card uk-card-default uk-display-block grid-project-card">
              <div class="uk-card-media-left">
                <div class="uk-cover-container uk-height-medium">
                  <img v-if="project.project_thumbnail" :src="$root.url + '/images/project/gallery/' + project.project_thumbnail" uk-cover />
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
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getcity', 'session_active'],
  data() {
    return {
      forms: {
        keywords: '',
        type: 'all',
        city: {
          value: 'all',
          name: 'Semua Kota'
        },
        submitsearch: 'Cari proyek'
      },
      errors: {
        name: {},
        errorMessage: ''
      },
      getproject: {
        isLoading: false,
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          next_prev_url: null,
          prev_page_url: null
        }
      }
    }
  },
  methods: {
    getProjectList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&type=' + this.forms.type + '&filtercity=' + this.forms.city.value;
      var url = this.$root.url + '/project/project_list?page=' + this.getproject.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      this.getproject.isLoading = true;
      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getproject.results = result.results.data;
        this.getproject.total = result.results.total;

        if( this.forms.city.value !== 'all' )
        {
          this.getcity.filter( f => {
            if( f.city_id === this.forms.city.value )
            {
               return this.forms.city.name = f.city_name;
            }
          });
        }

        this.getproject.isLoading = false;
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
    }
  },
  mounted() {
    this.getProjectList();
  }
}
</script>

<style lang="scss" scoped>
#background { background: #f2f2f2; }
</style>

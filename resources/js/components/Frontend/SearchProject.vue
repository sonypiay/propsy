<template>
  <div id="background">
    <div class="uk-padding uk-grid-medium" uk-grid>
      <div class="uk-width-1-4@xl uk-width-1-4@l uk-width-1-4@m uk-width-1-1@s">
        <div class="uk-card uk-card-default uk-card-body sidebar-filter">
          <div class="uk-margin">
            <a class="uk-width-1-1 uk-button uk-button-primary search-button-sidebar" @click="getProjectList()">Terapkan Filter</a>
          </div>
          <hr>
          <div class="uk-margin">
            <div class="uk-width-1-1 uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-width-1-1 uk-input search-form-sidebar" v-model="forms.keywords" placeholder="Cari proyek atau nama developer" />
            </div>
          </div>
          <hr>
          <div class="uk-margin">
            <h4 class="uk-h4">Kota</h4>
            <select class="uk-width-1-1 uk-select search-form-sidebar" v-model="forms.city.value">
              <option value="all">Semua Kota</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <hr>
          <div class="uk-margin">
            <h4 class="uk-h4">Tipe Unit</h4>
            <select class="uk-width-1-1 uk-select search-form-sidebar" v-model="forms.type">
              <option value="all">Semua Tipe</option>
              <option value="apartemen">Apartemen</option>
              <option value="residensial">Residensial</option>
            </select>
          </div>
          <hr>
          <div class="uk-margin">
            <h4 class="uk-h4">Harga</h4>
            <div class="uk-margin-small">
              <label class="uk-form-label">Minimum</label>
              <input type="number" class="uk-input uk-width-1-1 search-form-sidebar" v-model="forms.price.min" :step="forms.price.step">
            </div>
            <div class="uk-margin-small">
              <label class="uk-form-label">Maksimum</label>
              <input type="number" class="uk-input uk-width-1-1 search-form-sidebar" v-model="forms.price.max" :step="forms.price.step">
            </div>
          </div>
          <hr>
          <div class="uk-margin">
            <h4 class="uk-h4">Fasilitas</h4>
            <ul class="uk-list">
              <li v-for="fac in getfacility">
                <label><input type="checkbox" class="uk-checkbox" v-model="forms.facility" :value="fac.facility_name" /> <span class="uk-margin-small-left">{{ fac.facility_name }}</span> </label>
              </li>
            </ul>
          </div>
          <hr>
          <div class="uk-margin">
            <a class="uk-width-1-1 uk-button uk-button-primary search-button-sidebar" @click="getProjectList()">Terapkan Filter</a>
          </div>
        </div>
      </div>
      <div class="uk-width-expand">
        <!-- project -->
        <div class="uk-margin">
          <div v-if="getproject.isLoading" class="uk-margin uk-margin-large-bottom uk-text-center">
            <span uk-spinner></span>
          </div>
          <div v-else class="uk-margin">
            <div v-if="getproject.total === 0" class="uk-alert-warning" uk-alert>
              Unit tidak ada
            </div>
            <div v-else class="uk-margin uk-grid-medium uk-grid-match" uk-grid>
              <div class="uk-width-1-1">
                <div class="uk-text-large">
                  <strong>{{ getproject.total }}</strong> Unit ditemukan di {{ forms.city.name }}
                </div>
              </div>
              <div v-for="project in getproject.results" class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                <a :href="$root.url + '/project/detail_unit/' + project.unit_slug" class="uk-card uk-card-default uk-display-block grid-project-card">
                  <div class="uk-card-media-left">
                    <div class="uk-cover-container uk-height-medium">
                      <img v-if="project.unit_thumbnail" :src="$root.url + '/storage/assets/images/project/gallery/' + project.unit_thumbnail" uk-cover />
                      <img v-else :src="$root.url + '/images/banner/homepage3.jpg'" uk-cover />
                      <div class="uk-overlay uk-overlay-primary uk-position-cover project-card-background">
                        <div class="uk-position-bottom">
                          <div class="uk-padding-small project-card-title">
                            {{ project.unit_name }}
                            <div class="project-card-devname">{{ project.dev_name }} <a v-show="project.status_verification === 'Y'" uk-tooltip="Terverifikasi" class="badge-verification badge-verification-small" uk-icon="icon: check; ratio: 0.4"></a></div>
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
                        <label v-if="project.unit_status === 'sold'" class="uk-label uk-label-danger">Terjual</label>
                        <label v-else-if="project.unit_status === 'booked'" class="uk-label uk-label-warning">Sudah dipesan</label>
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
                        <span class="projectlist-text">Harga</span>
                        <span class="projectlist-subtext">Rp. {{ project.unit_price | currency }}</span>
                      </div>
                      <div v-if="project.unit_price" class="project-card-list">
                        <span class="projectlist-text">Luas Bangunan</span>
                        <span class="projectlist-subtext">{{ project.unit_lb }} m<sup>2</sup></span>
                      </div>
                      <div v-if="project.unit_km" class="project-card-list">
                        <span class="projectlist-text">Kamar Mandi</span>
                        <span class="projectlist-subtext">{{ project.unit_km }}</span>
                      </div>
                      <div v-if="project.unit_km" class="project-card-list">
                        <span class="projectlist-text">Kamar Tidur</span>
                        <span class="projectlist-subtext">{{ project.unit_kt }}</span>
                      </div>
                    </div>
                  </div>
                </a>
              </div>
            </div>

            <ul class="uk-pagination uk-flex-center">
              <li v-if="getproject.pagination.prev_page_url !== null">
                <a @click="getProjectList( getproject.pagination.prev_page_url )" uk-icon="chevron-left"></a>
              </li>
              <li v-else class="uk-disabled">
                <a uk-icon="chevron-left"></a>
              </li>
              <li v-if="getproject.pagination.next_page_url !== null">
                <a @click="getProjectList( getproject.pagination.next_page_url )" uk-icon="chevron-right"></a>
              </li>
              <li v-else class="uk-disabled">
                <a uk-icon="chevron-right"></a>
              </li>
            </ul>

          </div>
        </div>
        <!-- project -->
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: [
    'session_active',
    'session_user',
    'keywords',
    'getcity',
    'getfacility',
    'pricemin',
    'pricemax',
    'type'
  ],
  data() {
    return {
      forms: {
        keywords: this.keywords,
        type: this.type,
        city: {
          value: 'all',
          name: 'Semua Kota'
        },
        price: {
          min: this.pricemin === '' ? '' : this.pricemin,
          max: this.pricemax === '' ? '' : this.pricemax,
          step: 10000000
        },
        facility: [],
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
      var param = 'keywords=' + this.forms.keywords
      + '&type=' + this.forms.type
      + '&filtercity='
      + this.forms.city.value
      + '&facility=' + this.forms.facility
      + '&price_min=' + this.forms.price.min
      + '&price_max=' + this.forms.price.max;
      var url = this.$root.url + '/project/search_list?page=' + this.getproject.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      this.getproject.isLoading = true;
      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getproject.results = result.results.data;
        this.getproject.total = result.results.total;
        this.getproject.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url
        };

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

<template>
  <div>
    <div class="uk-background-cover uk-height-large banner-homepage" :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage3.jpg)'}">
      <!--<img :src="$root.url + '/images/banner/homepage3.jpg'" alt="" uk-cover>-->
      <div class="uk-position-center banner-search">
        <div class="uk-card uk-card-default uk-card-body banner-search-card">
          <form class="uk-form-stacked">
            <div class="uk-width-1-1 uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input @keyup.enter="searchUnit()" type="search" class="uk-width-1-1 uk-input search-input" v-model="forms.keywords" placeholder="Cari berdasarkan nama properti, nama proyek atau nama pengembang" />
            </div>
            <div class="uk-grid-small uk-child-width-auto uk-margin-top banner-search-navbottom" uk-grid>
              <div>
                <a>
                  <span>{{ forms.type.name }}</span>
                  <span uk-icon="chevron-down"></span>
                </a>
                <div uk-dropdown="mode: click;" id="filtertype" class="uk-box-shadow-small banner-search-navdropdown">
                  <ul class="uk-nav uk-dropdown-nav">
                    <li><a @click="changePropertyType('all', 'Semua Properti')">Semua Properti</a></li>
                    <li><a @click="changePropertyType('residensial', 'Residensial')">Residensial</a></li>
                    <li><a @click="changePropertyType('apartemen', 'Apartemen')">Apartemen</a></li>
                  </ul>
                </div>
              </div>
              <div>
                <a>
                  <span v-if="forms.price.isfiltered === false">Harga Min (Rp.) - Harga Max (Rp.)</span>
                  <span v-else>Rp. {{ forms.price.min | currency }} - Rp. {{ forms.price.max | currency }} </span>
                  <span uk-icon="chevron-down"></span>
                </a>
                <div uk-dropdown="mode: click;" id="filterprice" class="uk-width-large banner-filter-dropdown">
                  <div class="uk-margin">
                    <input type="number" class="uk-input" min="0" v-model="forms.price.min" placeholder="Harga minimal" :step="10000000">
                    <span class="uk-text-small uk-text-muted" v-show="forms.price.min > 0 || forms.price.min !== ''">Rp. {{ forms.price.min | currency }}</span>
                  </div>
                  <div class="uk-margin">
                    <input type="number" class="uk-input" min="0" v-model="forms.price.max" placeholder="Harga maksimal" :step="10000000">
                    <span class="uk-text-small uk-text-muted" v-show="forms.price.max > 0 || forms.price.max !== ''">Rp. {{ forms.price.max | currency }}</span>
                  </div>
                  <div class="uk-margin">
                    <a @click="filterPriceRange(true)" class="uk-button uk-button-small uk-button-primary">Terapkan</a>
                    <a @click="filterPriceRange(false)" class="uk-button uk-button-small uk-button-primary">Reset</a>
                  </div>
                </div>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
    <div class="uk-margin-top uk-padding hmpg-listproject">
      <div class="uk-container">
        <div class="uk-margin-bottom hmpg-listproject-heading">Unit Tersedia</div>
        <div class="uk-grid-medium uk-grid-match" uk-grid>
          <div v-for="unit in getunit.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
            <a :href="$root.url + '/project/detail_unit/' + unit.unit_slug" class="uk-card uk-card-default uk-display-block grid-project-card">
              <div class="uk-card-media-left">
                <div class="uk-cover-container uk-height-medium">
                  <img v-if="unit.unit_thumbnail" :src="$root.url + '/storage/assets/images/project/gallery/' + unit.unit_thumbnail" uk-cover />
                  <img v-else :src="$root.url + '/images/banner/homepage3.jpg'" uk-cover />
                  <div class="uk-overlay uk-overlay-primary uk-position-cover project-card-background">
                    <div class="uk-position-bottom">
                      <div class="uk-padding-small project-card-title">
                        {{ unit.unit_name }}
                        <div class="project-card-devname">{{ unit.dev_name }}</div>
                        <div class="project-card-location">
                          <span uk-icon="icon: location; ratio: 1"></span> {{ unit.city_name }}, {{ unit.province_name }}
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="uk-card-body uk-card-small project-card-body">
                <div class="uk-margin">
                  <div class="project-card-status">
                    <label v-if="unit.unit_status === 'sold'" class="uk-label uk-label-danger">Terjual</label>
                    <label v-else-if="unit.unit_status === 'booked'" class="uk-label uk-label-warning">Sudah dipesan</label>
                    <label v-else class="uk-label uk-label-success">Tersedia</label>
                  </div>
                </div>
                <div class="uk-margin">
                  <div class="project-card-list">
                    <span class="projectlist-text">Jenis Properti</span>
                    <span v-if="unit.project_type === 'residensial'" class="projectlist-subtext">Residensial</span>
                    <span v-else class="projectlist-subtext">Apartemen</span>
                  </div>
                  <div v-if="unit.unit_price" class="project-card-list">
                    <span class="projectlist-text">Harga</span>
                    <span class="projectlist-subtext">Rp. {{ unit.unit_price | currency }}</span>
                  </div>
                  <div v-if="unit.unit_price" class="project-card-list">
                    <span class="projectlist-text">Luas Bangunan</span>
                    <span class="projectlist-subtext">{{ unit.unit_lb }} m<sup>2</sup></span>
                  </div>
                  <div v-if="unit.unit_km" class="project-card-list">
                    <span class="projectlist-text">Kamar Mandi</span>
                    <span class="projectlist-subtext">{{ unit.unit_km }}</span>
                  </div>
                  <div v-if="unit.unit_km" class="project-card-list">
                    <span class="projectlist-text">Kamar Tidur</span>
                    <span class="projectlist-subtext">{{ unit.unit_kt }}</span>
                  </div>
                </div>
              </div>
            </a>
          </div>
        </div>
        <div class="uk-text-center">
          <a :href="$root.url + '/project/search?keywords='" class="uk-margin-top uk-button uk-button-primary browse_project_btn">Telusuri Unit Lainnya</a>
        </div>
      </div>
    </div>
    <div class="uk-margin-top uk-padding hmpg-listproject">
      <div class="uk-container">
        <div class="uk-margin-bottom hmpg-listproject-heading">Proyek Pengembang</div>
        <div class="uk-grid-medium uk-grid-match" uk-grid>
          <div v-for="project in projects.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
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
        <div class="uk-text-center">
          <a :href="$root.url + '/project/browse_project'" class="uk-margin-top uk-button uk-button-primary browse_project_btn">Telusuri Proyek Lainnya</a>
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
      forms: {
        keywords: '',
        price: {
          min: '',
          max: '',
          isfiltered: false
        },
        type: {
          name: 'Semua Properti',
          value: 'all'
        }
      },
      projects: {
        total: 0,
        results: []
      },
      getunit: {
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
    },
    getAvailableUnit()
    {
      axios.get( this.$root.url + '/project/unit_available' ).then( res => {
        let result = res.data;
        this.getunit.total = result.results.total;
        this.getunit.results = result.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    changePropertyType( value, name )
    {
      if( name === undefined && value === undefined )
      {
        name = '';
        value = '';
      }

      this.forms.type = {
        name: name,
        value: value
      };

      UIkit.dropdown('#filtertype').hide();
    },
    filterPriceRange( bool )
    {
      if( bool )
      {
        this.forms.price.isfiltered = true;
        if( this.forms.price.min === '' || this.forms.price.min < 1 )
        {
          this.forms.price.min = ''
          this.forms.price.isfiltered = false;
        }

        if( this.forms.price.max === '' || this.forms.price.max < 1 )
        {
          this.forms.price.max = '';
          this.forms.price.isfiltered = false;
        }
      }
      else
      {
        this.forms.price.isfiltered = false;
        this.forms.price.min = '';
        this.forms.price.max = '';
      }

      UIkit.dropdown('#filterprice').hide();
    },
    searchUnit()
    {
      var param = 'keywords=' + this.forms.keywords + '&type=' + this.forms.type.value + '&price_min=' + this.forms.price.min + '&price_max=' + this.forms.price.max;
      document.location = this.$root.url + '/project/search?' + param;
    }
  },
  mounted() {
    this.getAvailableProject();
    this.getAvailableUnit();
  }
}
</script>

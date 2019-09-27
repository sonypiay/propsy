<template>
  <div>
    <div id="galeri" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close-full uk-close" uk-close></a>
        <div class="uk-height-viewport">
          <div class="uk-grid-small" uk-grid uk-lightbox>
            <div v-for="galeri in getgallery" class="uk-width-1-3">
              <a :href="$root.url + '/images/project/gallery/' + galeri.gallery_filename">
                <div class="uk-cover-container uk-height-medium">
                  <img :src="$root.url + '/images/project/gallery/' + galeri.gallery_filename" alt="" uk-cover>
                </div>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-cover-container uk-height-large">
      <img v-if="getproject.project_thumbnail" :src="$root.url + '/images/project/gallery/' + getproject.project_thumbnail" uk-cover />
      <img v-else :src="$root.url + '/images/banner/homepage2.jpg'" uk-cover />
      <div class="uk-position-right uk-position-large">
        <div class="uk-card uk-card-body uk-card-default card-projectinfo">
          <div class="uk-clearfix">
            <div class="uk-align-right card-projectinfo-statusproject">
              <span v-if="getproject.project_status === 'available'" class="available">Tersedia</span>
              <span v-else-if="getproject.project_status === 'sold'" class="sold">Terjual</span>
              <span v-else class="commingsoon">Segera Launching</span>
            </div>
          </div>
          <div class="card-projectinfo-name">{{ getproject.project_name }}</div>
          <div class="card-projectinfo-devname">Oleh {{ getproject.dev_name }}</div>
          <div class="uk-margin-top card-projectinfo-body">
            <div class="uk-margin-top card-projectinfo-location">
              <span uk-icon="icon: location; ratio: 1.1"></span>
              {{ getproject.project_address }}
            </div>
            <div class="card-projectinfo-projecttype">
              Jenis Proyek
              <span v-if="getproject.project_type === 'residensial'">Residensial</span>
              <span v-else>Apartemen</span>
            </div>
            <div v-if="getunit_price !== null" class="card-projectinfo-price">
              Mulai dari
              <span>Rp. {{ $root.formatNumeral( getunit_price.unit_price ) }}</span>
            </div>
            <div v-show="getproject.project_estimate_launch !== null" class="card-projectinfo-launch">
              Segera Launching
              <span>{{ getproject.project_estimate_launch }}</span>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-margin-large-bottom">
      <div class="uk-card uk-card-body">
        <div class="uk-grid-medium" uk-grid>
          <div class="uk-width-expand">
            <div class="uk-card uk-card-default container-projectinfo">
              <div class="uk-card-body container-projectbody">
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Deskripsi Proyek
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    {{ getproject.project_description }}
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Alamat
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    {{ getproject.project_address }} <br>
                    <strong>{{ projectcity.city_name }},</strong>
                    <strong>{{ projectcity.province_name }}</strong>
                    <div v-show="getproject.project_map_embed" v-html="getproject.project_map_embed"></div>
                  </div>
                </div>
                <div v-show="getgallery !== null" class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Galeri
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    <div class="uk-position-relative uk-visible-toggle uk-light" tabindex="-1" uk-slideshow="animation: push">
                      <ul class="uk-slideshow-items">
                        <li v-for="galeri in getgallery">
                          <img :src="$root.url + '/images/project/gallery/' + galeri.gallery_filename" uk-cover>
                        </li>
                      </ul>
                      <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slideshow-item="previous"></a>
                      <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slideshow-item="next"></a>
                    </div>
                    <a uk-toggle="target: #galeri" class="uk-button uk-button-primary uk-margin-top content-viewbutton">Lihat Galeri</a>
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div uk-form-custom="target: > * > span:first-child">
                    <select class="uk-select content-projectform" v-model="forms.filterUnit" @change="getProjectUnit()">
                      <option value="available">Unit Tersedia</option>
                      <option value="sold">Unit Terjual</option>
                    </select>
                    <button class="uk-button uk-button-default" type="button" tabindex="-1">
                      <span></span>
                      <span uk-icon="icon: chevron-down"></span>
                    </button>
                  </div>
                  <div class="uk-grid-small uk-grid-divider uk-margin-top" uk-grid>
                    <div v-for="unit in projectunit.results" class="uk-width-1-1">
                      <div uk-tooltip :title="unit.unit_name" class="uk-card card-unit-project uk-grid-collapse uk-grid-match uk-margin" uk-grid>
                        <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
                          <div class="uk-card-media-left">
                            <div v-if="unit.unit_thumbnail" class="uk-background-cover unit-thumbnail" :style="{'background-image': 'url(' + $root.url + '/images/project/gallery/' + unit.unit_thumbnail + ')'}">
                            </div>
                            <div v-else class="uk-background-cover unit-thumbnail" :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage2.jpg)'}">
                            </div>
                          </div>
                        </div>
                        <div class="uk-width-expand">
                          <div class="uk-card-body uk-card-small card-unit-body">
                            <a class="uk-card-title unit-name">{{ unit.unit_name }}</a>
                            <div class="unit-location">
                              <span uk-icon="icon: location; ratio: 0.8"></span>
                              {{ getproject.project_address }},
                              {{ projectcity.city_name }},
                              {{ projectcity.province_name }}
                            </div>
                            <div class="unit-price">
                              Rp. {{ unit.unit_price | currency }}
                            </div>
                          </div>
                          <div class="uk-card-footer card-unit-footer uk-padding-small">
                            <div class="uk-grid-small uk-child-width-auto" uk-grid>
                              <div>
                                <div class="unit-specification">
                                  {{ unit.unit_lb }} m<sup>2</sup>
                                  <span>Luas Bangunan</span>
                                </div>
                              </div>
                              <div>
                                <div class="unit-specification">
                                  {{ unit.unit_km }}
                                  <span>Kamar Mandi</span>
                                </div>
                              </div>
                              <div>
                                <div class="unit-specification">
                                  {{ unit.unit_kt }}
                                  <span>Kamar Tidur</span>
                                </div>
                              </div>
                              <div>
                                <a class="uk-button uk-button-small uk-button-primary unit-readmore" href="#">Lihat Lebih Lanjut</a>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <ul class="uk-pagination uk-flex-center">
                    <li v-if="projectunit.pagination.prev_page_url !== null">
                      <a @click="getProjectUnit( projectunit.pagination.prev_page_url )" uk-icon="chevron-left"></a>
                    </li>
                    <li v-else class="uk-disabled">
                      <a uk-icon="chevron-left"></a>
                    </li>
                    <li v-if="projectunit.pagination.next_page_url !== null">
                      <a @click="getProjectUnit( projectunit.pagination.next_page_url )" uk-icon="chevron-right"></a>
                    </li>
                    <li v-else class="uk-disabled">
                      <a uk-icon="chevron-right"></a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-card uk-card-body uk-card-default uk-margin sidebar-dev-info">
              <div v-if="getproject.dev_logo === null" class="dev-withnologo">
                <span uk-icon="icon: users; ratio: 4"></span>
              </div>
              <div v-else class="dev-withlogo">
                <img class="uk-align-center" :src="$root.url + '/images/devlogo/' + getproject.dev_logo" :alt="getproject.dev_name">
              </div>
              <div class="uk-margin sidebar-dev-profile">
                <a class="dev-profile-name" href="#">{{ getproject.dev_name }}</a>
                <div class="dev-profile-region">{{ devcity.province_name + ', ' + devcity.city_name }}</div>
              </div>
              <div class="uk-margin uk-text-center">
                <a class="uk-width-1-1 uk-button uk-button-primary sidebar-viewproject" href="#">Lihat Pengembang</a>
              </div>
            </div>

            <div class="uk-card uk-card-body uk-card-default uk-margin sidebar-dev-info">
              <div class="uk-margin sidebar-dev-heading">Apakah anda tertarik?</div>
              <form class="uk-form-stacked uk-margin uk-grid-small" uk-grid>
                <div class="uk-width-1-2">
                  <input type="text" class="uk-input" placeholder="Nama Anda">
                </div>
                <div class="uk-width-1-2">
                  <input type="text" class="uk-input" placeholder="No. Telepon">
                </div>
                <div class="uk-width-1-1">
                  <textarea placeholder="Ketik pesan..." class="uk-textarea uk-height-small"></textarea>
                </div>
                <div class="uk-width-1-1">
                  <button class="uk-width-1-1 uk-button uk-button-primary btn-booking-unit" href="#">Pesan Unit</button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: [
    'session_user',
    'getproject',
    'getgallery',
    'getunit_price',
    'projectcity',
    'devcity'
  ],
  data() {
    return {
      forms: {
        filterUnit: 'available'
      },
      projectunit: {
        total: 0,
        results: [],
        isLoading: false,
        pagination: {
          current_page: 1,
          last_page: 1,
          next_page_url: null,
          prev_page_url: null
        }
      }
    }
  },
  methods: {
    getProjectUnit( p )
    {
      var param = 'filterUnit=' + this.forms.filterUnit;
      var url = this.$root.url + '/project/unit/' + this.getproject.project_unique_id + '?page=' + this.projectunit.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.projectunit.results = result.results.data;
        this.projectunit.total = result.results.total;
        this.projectunit.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          next_page_url: result.results.next_page_url,
          prev_page_url: result.results.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    }
  },
  mounted() {
    this.getProjectUnit();
  }
}
</script>

<style lang="css" scoped>
</style>

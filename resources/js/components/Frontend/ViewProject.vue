<template>
  <div>
    <div id="galeri" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close-full uk-close" uk-close></a>
        <div class="uk-height-viewport">
          <div class="uk-grid-small" uk-grid uk-lightbox>
            <div v-for="galeri in getgallery" class="uk-width-1-3">
              <a :href="$root.url + '/storage/assets/images/project/gallery/' + galeri.gallery_filename">
                <div class="uk-cover-container uk-height-medium">
                  <img :src="$root.url + '/storage/assets/images/project/gallery/' + galeri.gallery_filename" alt="" uk-cover>
                </div>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-cover-container uk-height-large">
      <img v-if="getproject.project_thumbnail" :src="$root.url + '/storage/assets/images/project/gallery/' + getproject.project_thumbnail" uk-cover />
      <img v-else :src="$root.url + '/images/banner/homepage3.jpg'" uk-cover />
      <div class="uk-position-right uk-position-large">
        <div class="uk-card uk-card-body uk-card-default card-projectinfo">
          <div class="uk-clearfix">
            <div class="uk-align-right card-projectinfo-statusproject">
              <span v-if="getproject.project_status === 'available'" class="available">Tersedia</span>
              <span v-else-if="getproject.project_status === 'sold'" class="sold">Terjual</span>
              <span v-else class="commingsoon">Segera Hadir</span>
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
              <span>Rp. {{ getunit_price.unit_price | currency }}</span>
            </div>
            <div v-show="getproject.project_estimate_launch !== null" class="card-projectinfo-launch">
              Segera Hadir
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
                  <div class="uk-margin-small content-projectlead" v-html="getproject.project_description">
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Alamat
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    {{ getproject.project_address }} <br>
                    <strong>{{ getproject.city_name }},</strong>
                    <strong>{{ getproject.province_name }}</strong>
                    <div v-show="getproject.project_map_embed" v-html="getproject.project_map_embed"></div>
                  </div>
                </div>
                <div v-show="getgallery !== null" class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Galeri
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    <div class="uk-position-relative uk-visible-toggle uk-light" tabindex="-1" uk-slideshow="animation: push; ratio: 16:9">
                      <ul class="uk-slideshow-items">
                        <li v-for="galeri in getgallery">
                          <img :src="$root.url + '/storage/assets/images/project/gallery/' + galeri.gallery_filename" uk-cover>
                        </li>
                      </ul>
                      <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slideshow-item="previous"></a>
                      <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slideshow-item="next"></a>
                    </div>
                    <a uk-toggle="target: #galeri" class="uk-button uk-button-primary uk-margin-top content-viewbutton">Lihat Galeri</a>
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-grid-small uk-grid-divider uk-margin-top" uk-grid>
                    <div v-for="unit in projectunit.results" class="uk-width-1-1">
                      <div uk-tooltip :title="unit.unit_name" class="uk-card card-unit-project uk-grid-collapse uk-grid-match uk-margin" uk-grid>
                        <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
                          <div class="uk-card-media-left">
                            <div v-if="unit.unit_thumbnail" class="uk-background-cover unit-thumbnail" :style="{'background-image': 'url(' + $root.url + '/storage/assets/images/project/gallery/' + unit.unit_thumbnail + ')'}">
                            </div>
                            <div v-else class="uk-background-cover unit-thumbnail" :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage3.jpg)'}">
                            </div>
                          </div>
                        </div>
                        <div class="uk-width-expand">
                          <div class="uk-card-body uk-card-small card-unit-body">
                            <div class="uk-grid-small" uk-grid>
                              <div class="uk-width-expand">
                                <a :href="$root.url + '/project/detail_unit/' + unit.unit_slug" class="uk-card-title unit-name">{{ unit.unit_name }}</a>
                              </div>
                              <div class="uk-width-1-6">
                                <div class="unit-status unit-status-available" v-if="unit.unit_status === 'available'">Tersedia</div>
                                <div class="unit-status unit-status-booked" v-else-if="unit.unit_status === 'booked'">Sudah dipesan</div>
                                <div class="unit-status unit-status-sold" v-else>Terjual</div>
                              </div>
                            </div>
                            <div class="unit-location">
                              <span uk-icon="icon: location; ratio: 0.8"></span>
                              {{ getproject.project_address }},
                              {{ getproject.city_name }},
                              {{ getproject.province_name }}
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
                                <a class="uk-button uk-button-small uk-button-primary unit-readmore" :href="$root.url + '/project/detail_unit/' + unit.unit_slug">Lihat Lebih Lanjut</a>
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
                <img class="uk-align-center uk-width-1-4" :src="$root.url + '/storage/assets/images/devlogo/' + getproject.dev_logo" :alt="getproject.dev_name">
              </div>
              <div class="uk-margin sidebar-dev-profile">
                <a class="dev-profile-name" href="#">{{ getproject.dev_name }}
                  <span v-show="getproject.status_verification === 'Y'" uk-tooltip="Terverifikasi" class="badge-verification badge-verification-medium" uk-icon="icon: check; ratio: 0.6"></span>
                </a>
              </div>
              <div class="uk-margin uk-text-center">
                <a class="uk-width-1-1 uk-button uk-button-primary sidebar-viewproject" :href="$root.url + '/profile/developer/' + getproject.dev_slug">Lihat Pengembang</a>
              </div>
              <div class="uk-margin sidebar-dev-contact">
                <div class="uk-grid-small" uk-grid>
                  <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                    <button @click="isViewPhone = true" class="uk-width-1-1 uk-button uk-button-default sidebar-btncontact">
                      <div v-if="isViewPhone">
                        {{ getproject.dev_phone_office }}
                      </div>
                      <div v-else class="uk-text-truncate">
                        <span uk-icon="icon: receiver; ratio: 0.8"></span> {{ getproject.dev_phone_office }}
                      </div>
                    </button>
                  </div>
                  <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
                    <button @click="whatsAppChat()" class="uk-width-1-1 uk-button uk-button-default sidebar-btncontact">
                      <span uk-icon="icon: whatsapp; ratio: 0.8"></span> WhatsApp
                    </button>
                  </div>
                </div>
              </div>
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
    'session_active'
  ],
  data() {
    return {
      forms: {},
      isViewPhone: false,
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
      var url = this.$root.url + '/project/unit/' + this.getproject.project_id + '?page=' + this.projectunit.pagination.current_page;
      if( p !== undefined ) url = p;

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
    },
    whatsAppChat()
    {
      let text = 'Halo, Saya mau tanya...';
      let url = 'https://api.whatsapp.com/send?phone=' + this.getproject.dev_mobile_phone + '&text=' + text;
      window.open( url, '_blank' );
    }
  },
  mounted() {
    this.getProjectUnit();
  }
}
</script>

<style lang="css" scoped>
</style>

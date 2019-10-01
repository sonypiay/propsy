<template>
  <div id="background">
    <div class="uk-padding container-projectinfo">
      <div class="container-projectheading">
        {{ getunit.project_name }}
      </div>
      <div class="uk-margin-bottom container-projectlead">
        <span uk-icon="location"></span> {{ projectcity.city_name }}, {{ projectcity.province_name }}
      </div>
      <div class="uk-grid-small" uk-grid>
        <div class="uk-width-expand">
          <!-- gallery -->
          <div class="uk-position-relative uk-visible-toggle uk-light" tabindex="-1" uk-slideshow="ratio: 7:3; animation: push">
            <ul class="uk-slideshow-items">
              <li v-for="gallery in getgallery">
                <img :src="$root.url + '/images/project/gallery/' + gallery.unit_gallery_filename" uk-cover>
              </li>
            </ul>
            <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slideshow-item="previous"></a>
            <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slideshow-item="next"></a>
          </div>
          <!-- gallery -->
          <div class="uk-navbar uk-box-shadow-small navbar-detail-unit" uk-navbar>
            <div class="uk-navbar-left">
              <div class="uk-navbar-item">
                <div class="nav-unit-item">
                  <div class="uk-navbar-subtitle nav-unit-subtitle">Harga</div>
                  Rp. {{ getunit.unit_price | currency }}
                </div>
              </div>
            </div>
            <div class="uk-navbar-right">
              <div class="uk-navbar-item">
                <div class="nav-unit-item">
                  <div class="uk-navbar-subtitle nav-unit-subtitle">Kamar Mandi</div>
                  {{ getunit.unit_km }}
                </div>
              </div>
              <div class="uk-navbar-item">
                <div class="nav-unit-item">
                  <div class="uk-navbar-subtitle nav-unit-subtitle">Kamar Tidur</div>
                  {{ getunit.unit_kt }}
                </div>
              </div>
              <div class="uk-navbar-item">
                <div class="nav-unit-item">
                  <div class="uk-navbar-subtitle nav-unit-subtitle">Luas Bangunan</div>
                  {{ getunit.unit_lb }} m<sup>2</sup>
                </div>
              </div>
              <div class="uk-navbar-item">
                <div class="nav-unit-item">
                  <div class="uk-navbar-subtitle nav-unit-subtitle">Luas Tanah</div>
                  {{ getunit.unit_lt }} m<sup>2</sup>
                </div>
              </div>
            </div>
          </div>

          <div class="uk-margin-top uk-navbar uk-box-shadow-small navbar-menu-unit">
            <div class="uk-navbar-center">
              <ul class="uk-navbar-nav">
                <li>
                  <a href="#">
                    <div>
                      <span uk-icon="thumbnails"></span>
                      <div class="uk-navbar-subtitle">
                        Rincian
                      </div>
                    </div>
                  </a>
                </li>
                <li>
                  <a href="#">
                    <div>
                      <span uk-icon="album"></span>
                      <div class="uk-navbar-subtitle">
                        Fasilitas
                      </div>
                    </div>
                  </a>
                </li>
                <li>
                  <a href="#">
                    <div>
                      <span uk-icon="location"></span>
                      <div class="uk-navbar-subtitle">
                        Lokasi
                      </div>
                    </div>
                  </a>
                </li>
              </ul>
            </div>
          </div>
          <div class="uk-card uk-card-default container-projectinfo">
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small content-projectheading">
                  Rincian Unit
                </div>
                <div class="uk-margin-small content-projectlead">
                  <table class="uk-table uk-table-middle uk-table-striped uk-table-hover uk-table-divider">
                    <tbody>
                      <tr>
                        <th>Kamar Mandi</th>
                        <td><strong>{{ getunit.unit_km }}</strong></td>
                        <th>Kamar Tidur</th>
                        <td><strong>{{ getunit.unit_kt }}</strong></td>
                      </tr>
                      <tr>
                        <th>Luas Bangunan</th>
                        <td><strong>{{ getunit.unit_lb }}</strong></td>
                        <th>Luas Tanah</th>
                        <td><strong>{{ getunit.unit_lt }}</strong></td>
                      </tr>
                      <tr>
                        <th>Jumlah Lantai</th>
                        <td><strong>{{ getunit.unit_floor }}</strong></td>
                        <th>Watt</th>
                        <td><strong>{{ getunit.unit_watt }}</strong></td>
                      </tr>
                    </tbody>
                  </table>
                </div>
              </div>
            </div>
            <hr>
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small content-projectheading">
                  Deskripsi
                </div>
                <div class="uk-margin-small content-projectlead" v-html="getunit.unit_description">
                </div>
              </div>
            </div>
            <hr>
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small content-projectheading">
                  Fasilitas
                </div>
                <div class="uk-margin-small content-projectlead">
                  <div class="uk-grid-small" uk-grid>
                    <div v-for="fac in getFacility" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
                      <span uk-icon="check"></span> {{ fac }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <hr>
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small uk-text-uppercase content-projectheading">
                  Listing ini adalah Proyek {{ getunit.project_name }}
                </div>
                <div class="uk-margin-small content-projectlead">
                  <div class="uk-card uk-card-default uk-grid-collapse uk-margin" uk-grid>
                    <div class="uk-width-1-3 uk-card-media-left uk-cover-container" v-if="getunit.project_thumbnail">
                      <img :src="$root.url + '/images/project/gallery/' + getunit.project_thumbnail" uk-cover />
                      <canvas width="600" height="400"></canvas>
                    </div>
                    <div class="uk-width-expand">
                      <div class="uk-card-body">
                        <h3 class="uk-card-title">{{ getunit.project_name }}</h3>
                        <div class="uk-text-justify">
                          {{ $root.htmlStripTags( getunit.project_description, 500 ) }} ... <br />
                          <a class="uk-button uk-button-small uk-button-default uk-margin-small-top" :href="$root.url + '/project/view/' + getunit.project_slug">Kunjungi Laman Proyek</a>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="uk-width-1-4@xl uk-width-1-4@l uk-width-1-3@m uk-width-1-1@s">
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: [
    'session_user',
    'getunit',
    'getgallery',
    'getmarketing',
    'projectcity',
    'devcity',
    'session_active'
  ],
  data() {
    return {
      forms: {
        booking: {
          selectunit: '',
          message: 'Halo ' + this.getunit.dev_name + ', saya ingin mengajukan pemesenan unit.',
          errorMessage: ''
        }
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

  },
  computed: {
    getFacility()
    {
      let fasilitas = this.getunit.unit_facility.split(',');
      return fasilitas;
    }
  },
  mounted() {

  }
}
</script>

<style lang="scss" scoped>
#background {
  background: #f2f2f2;
}
</style>

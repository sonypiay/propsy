<template>
  <div id="background">
    <div id="contact-agent" uk-modal>
      <div class="uk-modal-body uk-modal-dialog">
        <a class="uk-modal-close uk-modal-close-outside" uk-close></a>
        <h3 class="uk-h3">Kontak Agen Marketing</h3>
        <div class="uk-grid-small uk-grid-divider" uk-grid>
          <div v-for="mkt in getmarketing" class="uk-width-1-1">
            <div class="uk-card">
              <h4 class="uk-h4">{{ mkt.mkt_fullname }}</h4>
              <div v-show="mkt.mkt_phone_number">
                {{ mkt.mkt_phone_number }}
              </div>
              <div v-show="mkt.mkt_mobile_number">
                {{ mkt.mkt_mobile_number }}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-padding container-projectinfo">
      <div class="container-projectheading">
        {{ getunit.project_name }}
        <label class="uk-label uk-label-success" v-if="getunit.unit_status === 'available'">Tersedia</label>
        <label class="uk-label uk-label-warning" v-else-if="getunit.unit_status === 'booked'">Sudah dipesan</label>
        <label class="uk-label uk-label-danger" v-else>Terjual</label>
      </div>
      <div class="uk-margin-bottom container-projectlead">
        <span uk-icon="location"></span> {{ projectcity.city_name }}, {{ projectcity.province_name }}
      </div>
      <div class="uk-grid-medium" uk-grid>
        <div class="uk-width-expand">
          <!-- gallery -->
          <div class="uk-position-relative uk-visible-toggle uk-light" tabindex="-1" uk-slideshow="ratio: 16:9; animation: push">
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
                  <a href="#rincian" uk-scroll>
                    <div>
                      <span uk-icon="thumbnails"></span>
                      <div class="uk-navbar-subtitle">
                        Rincian
                      </div>
                    </div>
                  </a>
                </li>
                <li>
                  <a href="#fasilitas" uk-scroll>
                    <div>
                      <span uk-icon="album"></span>
                      <div class="uk-navbar-subtitle">
                        Fasilitas
                      </div>
                    </div>
                  </a>
                </li>
                <li>
                  <a href="#lokasi" uk-scroll>
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
                <div id="rincian" class="uk-margin-small content-projectheading">
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
            <hr class="uk-divider-icon">
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div id="deskripsi" class="uk-margin-small content-projectheading">
                  Deskripsi
                </div>
                <div class="uk-margin-small content-projectlead" v-html="getunit.unit_description">
                </div>
              </div>
            </div>
            <hr class="uk-divider-icon">
            <div id="fasilitas" class="uk-card-body uk-card-small container-projectbody">
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
            <hr class="uk-divider-icon">
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small uk-text-uppercase content-projectheading">
                  Listing ini adalah Proyek {{ getunit.project_name }}
                </div>
                <div class="uk-margin-small content-projectlead">
                  <div class="uk-card uk-grid-collapse uk-margin" uk-grid>
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
        <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
          <div class="uk-card uk-card-body uk-card-default uk-margin sidebar-dev-info">
            <div v-if="getunit.dev_logo === null" class="dev-withnologo">
              <span uk-icon="icon: users; ratio: 4"></span>
            </div>
            <div v-else class="dev-withlogo">
              <img class="uk-align-center" :src="$root.url + '/images/devlogo/' + getunit.dev_logo" :alt="getunit.dev_name">
            </div>
            <div class="uk-margin sidebar-dev-profile">
              <a class="dev-profile-name" href="#">{{ getunit.dev_name }}</a>
              <div class="dev-profile-region">{{ devcity.province_name + ', ' + devcity.city_name }}</div>
            </div>
            <div class="uk-margin uk-text-center">
              <a class="uk-width-1-1 uk-button uk-button-primary uk-margin-small sidebar-viewproject" :href="$root.url + '/profile/developer/' + getunit.dev_slug">Lihat Pengembang</a>
              <a class="uk-width-1-1 uk-button uk-button-primary uk-margin-small sidebar-viewproject" uk-toggle="target: #contact-agent">Kontak Agen</a>
            </div>
          </div>

          <div v-show="session_active !== 'developer'" class="uk-card uk-card-body uk-card-default uk-margin sidebar-dev-info">
            <div class="uk-margin sidebar-dev-heading">Apakah anda tertarik?</div>
            <div v-show="forms.booking.errorMessage" class="uk-alert-danger" uk-alert>{{ forms.booking.errorMessage }}</div>
            <div v-if="session_active === 'customer'" class="uk-margin uk-grid-small" uk-grid>
              <div class="uk-width-1-1">
                <input type="text" class="uk-width-1-1 uk-input form-booking-unit" :value="getunit.unit_name" readonly />
              </div>
              <div class="uk-width-1-1">
                <textarea v-model="forms.booking.message" placeholder="Ketik pesan..." class="uk-textarea form-booking-unit uk-height-small"></textarea>
              </div>
              <div class="uk-width-1-1">
                <button @click="requestUnit()" class="uk-width-1-1 uk-button uk-button-primary btn-booking-unit">Ajukan Pemesanan</button>
              </div>
            </div>
            <a v-else :href="$root.url + '/customer/masuk'" class="uk-width-1-1 uk-button uk-button-primary btn-login">Masuk / Daftar</a>
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
          selectunit: this.getunit.unit_type_id,
          message: 'Halo ' + this.getunit.dev_name + ', saya ingin mengajukan pemesenan unit ' + this.getunit.unit_name + '.',
          errorMessage: ''
        }
      }
    }
  },
  methods: {
    requestUnit()
    {
      this.forms.booking.errorMessage = '';
      if( this.forms.booking.selectunit === '' || this.forms.booking.message === '' ) return false;

      var param = {
        message: this.forms.booking.message,
        dev_user: this.getunit.dev_user_id
      };

      axios({
        method: 'post',
        url: this.$root.url + '/project/request_unit/' + this.forms.booking.selectunit,
        params: param
      }).then( res => {
        let result = res.data;
        swal({
          title: 'Sukses',
          text: 'Berhasil mengajukan pemesanan',
          icon: 'success',
          timer: 3000
        });
        setTimeout(() => { document.location = this.$root.url + '/customer/request_unit' }, 2000);
      }).catch( err => {
        if( err.response.status === 500 )
        {
          this.forms.booking.errorMessage = 'Whoops, ' + err.response.statusText;
        }
        else
        {
          this.forms.booking.errorMessage = err.response.data.statusText;
        }
      });
    }
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

<template>
  <div id="background">
    <div id="contact-agent" class="uk-modal-container" uk-modal>
      <div class="uk-modal-dialog">
        <a class="uk-modal-close-full uk-close-large" uk-close></a>
        <div class="uk-modal-body">
          <h3 class="uk-h3">Kontak Agen Marketing</h3>
          <div class="uk-grid-small uk-grid-match" uk-grid>
            <div v-for="mkt in marketinglist.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
              <div class="uk-card uk-card-default">
                <div class="uk-card-header">
                  <div class="uk-grid-small uk-flex-middle" uk-grid>
                    <div class="uk-width-auto">
                      <img v-if="mkt.mkt_profile_photo" class="uk-border-circle" width="40" height="40" :src="$root.url + '/storage/assets/images/avatar/marketing/' + mkt.mkt_profile_photo" />
                      <img v-else class="uk-border-circle" width="40" height="40" :src="$root.url + '/images/avatar/avatar.jpg'" />
                    </div>
                    <div class="uk-width-expand">
                      <h4 class="uk-h4 uk-margin-remove-bottom">{{ mkt.mkt_fullname }}</h4>
                    </div>
                  </div>
                </div>
                <div class="uk-card-body">
                  <div class="uk-panel uk-margin">
                    <h4 class="uk-h4 uk-margin-remove-bottom">Email</h4>
                    <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
                      {{ mkt.mkt_email }}
                    </p>
                  </div>
                  <div class="uk-panel uk-margin">
                    <h4 class="uk-h4 uk-margin-remove-bottom">Alamat</h4>
                    <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
                      {{ mkt.mkt_address }}
                    </p>
                  </div>
                  <div class="uk-panel uk-margin">
                    <h4 class="uk-h4 uk-margin-remove-bottom">Kota</h4>
                    <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
                      {{ mkt.city_name }}, {{ mkt.province_name }}
                    </p>
                  </div>
                </div>
                <div class="uk-card-footer">
                  <div class="uk-panel uk-grid-small" uk-grid>
                    <div class="uk-width-1-2 uk-text-meta uk-text-center">
                      <a class="uk-button uk-button-text">
                        <div>
                          <span uk-icon="receiver"></span>
                        </div>
                        {{ mkt.mkt_phone_number }}
                      </a>
                    </div>
                    <div class="uk-width-1-2 uk-text-meta uk-text-center">
                      <a class="uk-button uk-button-text">
                        <div>
                          <span uk-icon="whatsapp"></span>
                        </div>
                        {{ mkt.mkt_mobile_phone }}
                      </a>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div id="ajukan" class="uk-modal-container" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <h3 class="uk-h3">Ajukan Pesanan</h3>
        <div class="uk-margin">
          <div v-show="forms.booking.errorMessage" class="uk-alert-danger" uk-alert>{{ forms.booking.errorMessage }}</div>
          <div class="uk-margin">
            <input type="text" class="uk-width-1-1 uk-input form-booking-unit" :value="getunit.unit_name" readonly />
          </div>
          <div class="uk-margin">
            <table class="uk-table uk-table-hover uk-table-striped uk-table-divider uk-table-small uk-table-middle">
              <thead>
                <tr>
                  <th></th>
                  <th>DP</th>
                  <th>Angsuran</th>
                  <th>Tenor</th>
                  <th>Total Angsuran</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="installment in getinstallment.results">
                  <td>
                    <input type="radio" class="uk-radio" v-model="forms.booking.selectinstallment" :value="installment.id">
                  </td>
                  <td>Rp. {{ installment.dp_price | currency }}</td>
                  <td>Rp. {{ installment.installment_price | currency }}</td>
                  <td>{{ installment.installment_tenor }} bulan (<span v-if="installment.installment_tenor >= 12">{{ roundFixedYear( installment.installment_tenor ) }} tahun</span>)</td>
                  <td>Rp. {{ installment.installment_tenor * installment.installment_price | currency }}
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
          <div class="uk-margin">
            <textarea v-model="forms.booking.message" placeholder="Ketik pesan..." class="uk-textarea form-booking-unit uk-height-small"></textarea>
          </div>
          <div class="uk-margin">
            <button @click="requestUnit()" class="uk-width-1-1 uk-button uk-button-primary btn-booking-unit">Ajukan Pemesanan</button>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-padding container-projectinfo">
      <div class="container-projectheading">
        {{ getunit.unit_name }}
        <label class="uk-label uk-label-success" v-if="getunit.unit_status === 'available'">Tersedia</label>
        <label class="uk-label uk-label-warning" v-else-if="getunit.unit_status === 'booked'">Sudah dipesan</label>
        <label class="uk-label uk-label-danger" v-else>Terjual</label>
      </div>
      <div class="uk-margin-bottom container-projectlead">
        <span uk-icon="location"></span> {{ getunit.city_name }}, {{ getunit.province_name }}
        <div v-show="getunit.project_address" class="uk-text-small">
          {{ getunit.project_address }}
        </div>
      </div>
      <div class="uk-grid-medium" uk-grid>
        <div class="uk-width-expand">
          <!-- gallery -->
          <div class="uk-position-relative uk-visible-toggle uk-light" tabindex="-1" uk-slideshow="animation: push">
            <ul class="uk-slideshow-items">
              <li v-for="gallery in getgallery">
                <img :src="$root.url + '/storage/assets/images/project/gallery/' + gallery.unit_gallery_filename" uk-cover>
                <canvas width="600" height="400"></canvas>
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
            <div id="lokasi" class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small content-projectheading">
                  Lokasi
                </div>
                <div class="uk-margin-small content-projectlead" v-html="getunit.project_map_embed">
                </div>
              </div>
            </div>
            <hr class="uk-divider-icon">
            <div class="uk-card-body uk-card-small container-projectbody">
              <div class="uk-margin content-projectdetail">
                <div class="uk-margin-small uk-text-uppercase content-projectheading">
                  Rincian Angsuran
                </div>
                <div class="uk-margin-small content-projectlead">
                  <table class="uk-table uk-table-hover uk-table-striped uk-table-divider uk-table-small uk-table-middle">
                    <thead>
                      <tr>
                        <th>DP</th>
                        <th>Angsuran</th>
                        <th>Tenor</th>
                        <th>Total Angsuran</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="installment in getinstallment.results">
                        <td>Rp. {{ installment.dp_price | currency }}</td>
                        <td>Rp. {{ installment.installment_price | currency }}</td>
                        <td>{{ installment.installment_tenor }} bulan (<span v-if="installment.installment_tenor >= 12">{{ roundFixedYear( installment.installment_tenor ) }} tahun</span>)</td>
                        <td>Rp. {{ installment.installment_tenor * installment.installment_price | currency }}
                        </td>
                      </tr>
                    </tbody>
                  </table>
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
                      <img :src="$root.url + '/storage/assets/images/project/gallery/' + getunit.project_thumbnail" uk-cover />
                      <canvas width="600" height="400"></canvas>
                    </div>
                    <div class="uk-width-expand">
                      <div class="uk-card-body">
                        <h3 class="uk-card-title">{{ getunit.project_name }}</h3>
                        <div class="uk-text-justify">
                          <div v-html="$root.htmlStripTags( getunit.project_description, 500 ) + ' ...'">
                          </div>
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
              <img class="uk-align-center" :src="$root.url + '/storage/assets/images/devlogo/' + getunit.dev_logo" />
            </div>
            <div class="uk-margin sidebar-dev-profile">
              <a class="dev-profile-name" href="#">{{ getunit.dev_name }}</a>
            </div>
            <div class="uk-margin uk-text-center">
              <a class="uk-width-1-1 uk-button uk-button-primary uk-margin-small sidebar-viewproject" :href="$root.url + '/profile/developer/' + getunit.dev_slug">Lihat Pengembang</a>
              <a class="uk-width-1-1 uk-button uk-button-primary uk-margin-small sidebar-viewproject" uk-toggle="target: #contact-agent">Kontak Agen</a>
            </div>
          </div>

          <div v-show="session_active === 'customer' || session_active === ''" class="uk-card uk-card-body uk-card-default uk-margin sidebar-dev-info">
            <div class="uk-margin sidebar-dev-heading">Apakah anda tertarik?</div>
            <div v-if="session_active === 'customer'" class="uk-margin uk-grid-small" uk-grid>
              <button uk-toggle="target: #ajukan" class="uk-width-1-1 uk-button uk-button-primary btn-booking-unit">Ajukan Pemesanan</button>
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
    'session_active'
  ],
  data() {
    return {
      forms: {
        booking: {
          selectunit: this.getunit.unit_type_id,
          selectinstallment: 0,
          message: 'Halo ' + this.getunit.dev_name + ', saya ingin mengajukan pemesenan unit ' + this.getunit.unit_name + '.',
          errorMessage: ''
        }
      },
      marketinglist: {
        total: 0,
        results: []
      },
      getinstallment: {
        total: 0,
        results: []
      }
    }
  },
  methods: {
    getMarketingList()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/project/marketing_developer/' + this.getunit.dev_user_id
      }).then( res => {
        let result = res.data;
        this.marketinglist.total = result.result.total;
        this.marketinglist.results = result.result.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    requestUnit()
    {
      this.forms.booking.errorMessage = '';
      if( this.forms.booking.selectunit === '' || this.forms.booking.message === '' ) return false;
      if( this.forms.booking.selectinstallment === '' || this.forms.booking.selectinstallment === 0 ) return false;

      var param = {
        message: this.forms.booking.message,
        dev_user: this.getunit.dev_user_id,
        selectinstallment: this.forms.booking.selectinstallment
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
    },
    getInstallmentList()
    {
      let id = this.getunit.unit_type_id;
      axios({
        method: 'get',
        url: this.$root.url + '/project/get_installment/' + id
      }).then( res => {
        let result = res.data;
        this.getinstallment.total = result.results.total;
        this.getinstallment.results = result.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    roundFixedYear( val )
    {
      var year = parseInt( val ) / 12;
      if( Number.isInteger(year) ) return year;
      else return year.toFixed(1);
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
    this.getMarketingList();
    this.getInstallmentList();
  }
}
</script>

<style lang="scss" scoped>
#background {
  background: #f2f2f2;
}
</style>

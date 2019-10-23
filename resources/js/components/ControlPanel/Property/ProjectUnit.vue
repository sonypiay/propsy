<template>
  <div>
    <div id="modal-unit" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog">
        <a class="uk-modal-close-large uk-modal-close" uk-close></a>
        <div class="uk-grid-collapse uk-grid-match" uk-grid>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-background-cover" v-if="getunit.detail.unit_thumbnail === null" uk-height-viewport  :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage3.jpg)'}">
            </div>
            <div v-else class="uk-background-cover" uk-height-viewport :style="{'background-image': 'url(' + $root.url + '/storage/assets/images/project/gallery/' + getunit.detail.unit_thumbnail + ')'}"></div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-card uk-card-body uk-overflow-auto" style="height: 620px;">
              <h1 class="uk-h1">Rp. {{ getunit.detail.unit_price | currency }}</h1>
              <h3 class="uk-h3">{{ getunit.detail.unit_name }}</h3>
              <table class="uk-table uk-table-striped uk-table-hover uk-table-small uk-table-middle uk-table-responsive">
                <tbody>
                  <tr>
                    <td>Kamar Tidur</td>
                    <td><strong>{{ getunit.detail.unit_kt }}</strong></td>
                    <td>Kamar Mandi</td>
                    <td><strong>{{ getunit.detail.unit_km }}</strong></td>
                  </tr>
                  <tr>
                    <td>Jumlah Lantai</td>
                    <td><strong>{{ getunit.detail.unit_floor }}</strong></td>
                    <td>Kapasitas Watt</td>
                    <td><strong>{{ getunit.detail.unit_watt }}</strong></td>
                  </tr>
                  <tr>
                    <td>Luas Bangunan</td>
                    <td><strong>{{ getunit.detail.unit_lb }} m<sup>2</sup></strong></td>
                    <td>Luas Lahan </td>
                    <td><strong>{{ getunit.detail.unit_lt }} m<sup>2</sup></strong></td>
                  </tr>
                </tbody>
              </table>
              <hr>
              <h3 class="uk-h3">Deskripsi</h3>
              <div v-html="getunit.detail.unit_description"></div>
              <hr>
              <h3 class="uk-h3">Fasilitas</h3>
              <div class="uk-grid-small uk-child-width-1-3@s" uk-grid>
                <div v-for="fac in getFacility( getunit.detail.unit_facility )" class="uk-text-small">
                  <span uk-icon="icon: check; ratio: 0.6"></span> {{ fac }}
                </div>
              </div>
              <hr>
              <h3 class="uk-h3">Biaya Angsuran</h3>
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
      </div>
    </div>

    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Properti</span></li>
        <li><span>Tipe Unit</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Tipe Unit</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getUnitType()">
              <option value="10">10 baris</option>
              <option value="20">20 baris</option>
              <option value="50">50 baris</option>
              <option value="100">100 baris</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.city" @change="getUnitType()">
              <option value="all">Semua kota</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.status" @change="getUnitType()">
              <option value="all">Semua status</option>
              <option value="available">Tersedia</option>
              <option value="sold">Terjual</option>
              <option value="booked">Sudah Dipesan</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getUnitType()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getunit.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada unit
          </div>
          <div v-else>
            <label class="uk-label">{{ getunit.total }} unit</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Unit</th>
                  <th>Proyek</th>
                  <th>Pengembang</th>
                  <th>Status</th>
                  <th>Tanggal Posting</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="unit in getunit.results">
                  <td>
                    <a uk-tooltip="Lihat Detail" @click="onDetailUnit( unit )" class="uk-icon-link" uk-icon="forward"></a>
                  </td>
                  <td>{{ unit.unit_name }}</td>
                  <td>{{ unit.project_name }}</td>
                  <td>{{ unit.dev_name }}</td>
                  <td>
                    <label v-if="unit.unit_status === 'sold'" class="uk-label uk-label-danger">Terjual</label>
                    <label v-else-if="unit.unit_status === 'booked'" class="uk-label">Sudah dipesan</label>
                    <label v-else class="uk-label uk-label-success">Tersedia</label>
                  </td>
                  <td>{{ $root.formatDate( unit.created_at, 'DD/MM/YYYY' ) }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getunit.paginate.prev_page_url" @click="getUnitType( getunit.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getunit.paginate.next_page_url" @click="getUnitType( getunit.paginate.next_page_url )">
                  <span uk-pagination-next></span>
                </a>
                <a v-else>
                  <span uk-pagination-next></span>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['getcity'],
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        city: 'all',
        status: 'all'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getinstallment: {
        total: 0,
        results: []
      },
      getunit: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        },
        detail: {}
      }
    }
  },
  methods: {
    getUnitType( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city + '&status=' + this.forms.status;
      var url = this.$root.url + '/cp/property/unit/get_unit?page=' + this.getunit.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getunit.total = result.total;
        this.getunit.results = result.data;
        this.getunit.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailUnit( data )
    {
      this.getunit.detail = data;
      this.getInstallmentList( data.unit_type_id );
      UIkit.modal('#modal-unit').show();
    },
    saveReport()
    {
      let param = 'city=' + this.forms.city + '&status=' + this.forms.status;
      let url = this.$root.url + '/cp/property/unit/save_report?' + param;
      window.open( url, '_blank' );
    },
    getInstallmentList( id )
    {
      axios({
        method: 'get',
        url: this.$root.url + '/developer/project/get_installment/' + id
      }).then( res => {
        let result = res.data;
        this.getinstallment.total = result.results.total;
        this.getinstallment.results = result.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getFacility( facility )
    {
      if( facility !== undefined )
      {
        return facility.split(',');
      }
    },
    roundFixedYear( val )
    {
      var year = parseInt( val ) / 12;
      if( Number.isInteger(year) ) return year;
      else return year.toFixed(1);
    }
  },
  mounted() {
    this.getUnitType();
  }
}
</script>

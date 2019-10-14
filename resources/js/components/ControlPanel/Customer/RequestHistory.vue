<template>
  <div>
    <div id="detail-request" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog uk-modal-body" uk-height-viewport>
        <a class="uk-modal-close-full uk-close-large" type="button" uk-close></a>
        <div class="uk-card uk-card-body container-viewschedule">
          <div class="uk-card-title container-viewschedule-heading">
            Rincian Pemesanan Unit {{ getrequest.detail.data.request_id }}
          </div>
          <div class="uk-margin container-viewschedule-body">
            <table class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
              <tbody>
                <tr>
                  <th>Nama Pelanggan</th>
                  <td>{{ getrequest.detail.data.customer_name }}</td>
                </tr>
                <tr>
                  <th>Nomor Telepon</th>
                  <td>{{ getrequest.detail.data.customer_phone_number }}</td>
                </tr>
                <tr>
                  <th>Alamat Email</th>
                  <td>{{ getrequest.detail.data.customer_email }}</td>
                </tr>
                <tr>
                  <th>Alamat</th>
                  <td>
                    {{ getrequest.detail.data.customer_address }} <br>
                    {{ getrequest.detail.data.city_name }}, {{ getrequest.detail.data.province_name }}
                  </td>
                </tr>
                <tr>
                  <th>Unit Dipesan</th>
                  <td>
                    {{ getrequest.detail.data.unit_name }}
                  </td>
                </tr>
                <tr>
                  <th>Pesan</th>
                  <td>{{ getrequest.detail.data.request_message }}</td>
                </tr>
              </tbody>
            </table>

            <div class="uk-card-title container-viewschedule-heading">Angsuran Pilihan</div>
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
                <tr>
                  <td>Rp. {{ getrequest.detail.data.dp_price | currency }}</td>
                  <td>Rp. {{ getrequest.detail.data.installment_price | currency }}</td>
                  <td>{{ getrequest.detail.data.installment_tenor }} bulan (<span v-if="getrequest.detail.data.installment_tenor >= 12">{{ roundFixedYear( getrequest.detail.data.installment_tenor ) }} tahun</span>)</td>
                  <td>Rp. {{ getrequest.detail.data.installment_tenor * getrequest.detail.data.installment_price | currency }}
                  </td>
                </tr>
              </tbody>
            </table>

            <table v-show="getrequest.detail.data.meeting_time" class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
              <thead>
                <tr>
                  <th>Tanggal Meeting</th>
                  <th>Jam</th>
                  <th>Status</th>
                  <th>Dokumen</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="uk-width-medium">{{ $root.formatDate( getrequest.detail.data.meeting_time, 'dddd, DD MMMM YYYY' ) }}</td>
                  <td class="uk-width-medium">{{ $root.formatDate( getrequest.detail.data.meeting_time, 'HH:mm' ) }}</td>
                  <td>
                    <label class="uk-label" v-if="getrequest.detail.data.meeting_status === 'waiting_confirmation'">Menunggu Konfirmasi</label>
                    <label class="uk-label uk-label-success" v-else-if="getrequest.detail.data.meeting_status === 'accept'">Diterima</label>
                    <label class="uk-label uk-label-danger" v-else-if="getrequest.detail.data.meeting_status === 'reject'">Ditolak</label>
                    <label class="uk-label uk-label-danger" v-else-if="getrequest.detail.data.meeting_status === 'cancel'">Dibatalkan</label>
                    <label class="uk-label uk-label-warning" v-else-if="getrequest.detail.data.meeting_status === 'revision'">Revisi</label>
                    <label class="uk-label uk-label-success" v-else>Selesai</label>
                  </td>
                  <td>
                    <a v-if="getrequest.detail.data.document_file" target="_blank" class="uk-button uk-button-small uk-button-default" :href="$root.url + '/storage/assets/document/meeting/' + getrequest.detail.data.document_file"><span uk-icon="download"></span> Unduh Dokumen</a>
                    <a v-else class="uk-button uk-button-small uk-button-default" href="#"><span uk-icon="download"></span> Unduh Dokumen</a>
                  </td>
                </tr>
                <tr>
                  <th>Hasil Meeting</th>
                  <td colspan="3">
                    {{ getrequest.detail.data.meeting_result }}
                  </td>
                </tr>
              </tbody>
            </table>
            <div class="uk-margin">
              <h3 class="uk-h3">Track Pemesanan Unit</h3>
              <ul class="uk-margin uk-list uk-list-divider">
                <li v-for="log in getrequest.detail.log_request">
                  <div class="uk-text-small uk-text-bold">
                    {{ $root.formatDate( log.log_date, 'DD MMMM YYYY, HH:mm' ) }}
                  </div>
                  <span v-html="log.log_message"></span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Pelanggan</span></li>
        <li><span>Riwayat Pengajuan Pesanan</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Riwayat Pengajuan Pesanan</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getRequestUnit()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.status" @change="getRequestUnit()">
              <option value="all">Semua status</option>
              <option value="waiting_response">Menunggu Tanggapan</option>
              <option value="cancel">Dibatalkan</option>
              <option value="meeting">Dijadwalkan Meeting</option>
              <option value="accept">Diterima</option>
              <option value="reject">Ditolak</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getRequestUnit()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getrequest.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Pengajuan Pesanan
          </div>
          <div v-else>
            <label class="uk-label">{{ getrequest.total }} Pesanan</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>ID</th>
                  <th>Nama Pelanggan</th>
                  <th>Unit</th>
                  <th>Tanggal Pesan</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="req in getrequest.results">
                  <td>
                    <a uk-tooltip="Lihat Detail" @click="onDetailRequest( req.request_id )" class="uk-icon-link" uk-icon="forward"></a>
                  </td>
                  <td>{{ req.request_id }}</td>
                  <td>{{ req.customer_name }}</td>
                  <td>{{ req.unit_name }}</td>
                  <td>{{ $root.formatDate( req.created_at, 'DD/MM/YYYY' ) }}</td>
                  <td>
                    <label class="uk-label" v-if="req.status_request === 'waiting_response'">Menunggu Konfirmasi</label>
                    <label class="uk-label uk-label-danger" v-else-if="req.status_request === 'cancel'">Dibatalkan</label>
                    <label class="uk-label uk-label-danger" v-else-if="req.status_request === 'reject'">Ditolak</label>
                    <label class="uk-label uk-label-warning" v-else-if="req.status_request === 'meeting'">Dijadwalkan Meeting</label>
                    <label class="uk-label uk-label-success" v-else>Diterima</label>
                  </td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getrequest.paginate.prev_page_url" @click="getRequestUnit( getrequest.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getrequest.paginate.next_page_url" @click="getRequestUnit( getrequest.paginate.next_page_url )">
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
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        status: 'all'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getrequest: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        },
        detail: {
          data: {},
          log_request: []
        }
      }
    }
  },
  methods: {
    getRequestUnit( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city + '&status=' + this.forms.status;
      var url = this.$root.url + '/cp/customer/request_unit/get_request?page=' + this.getrequest.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getrequest.total = result.total;
        this.getrequest.results = result.data;
        this.getrequest.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailRequest( id )
    {
      axios({
        method: 'get',
        url: this.$root.url + '/cp/customer/request_unit/detail_request/' + id
      }).then( res => {
        let result = res.data;
        this.getrequest.detail.data = result.results.data;
        this.getrequest.detail.log_request = result.results.log;
        UIkit.modal('#detail-request').show();
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    saveReport()
    {
      let param = 'city=' + this.forms.city + '&keywords=' + this.forms.keywords + '&status=' + this.forms.status;
      let url = this.$root.url + '/cp/customer/save_report?' + param;
      window.open( url, '_blank' );
    },
    roundFixedYear( val )
    {
      var year = parseInt( val ) / 12;
      if( Number.isInteger(year) ) return year;
      else return year.toFixed(1);
    }
  },
  mounted() {
    this.getRequestUnit();
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div id="detail-request" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog uk-modal-body" uk-height-viewport>
        <a class="uk-modal-close-full uk-close-large" type="button" uk-close></a>
        <div class="uk-card uk-card-body container-viewschedule">
          <div class="uk-card-title container-viewschedule-heading">
            Rincian Pemesanan Unit {{ request_list.details.data.request_id }}
          </div>
          <div class="uk-margin container-viewschedule-body">
            <table class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
              <tbody>
                <tr>
                  <th>Nama Pelanggan</th>
                  <td>{{ request_list.details.data.customer_name }}</td>
                </tr>
                <tr>
                  <th>Nomor Telepon</th>
                  <td>{{ request_list.details.data.customer_phone_number }}</td>
                </tr>
                <tr>
                  <th>Alamat Email</th>
                  <td>{{ request_list.details.data.customer_email }}</td>
                </tr>
                <tr>
                  <th>Alamat</th>
                  <td>
                    {{ request_list.details.data.customer_address }} <br>
                    {{ request_list.details.data.city_name }}, {{ request_list.details.data.province_name }}
                  </td>
                </tr>
                <tr>
                  <th>Unit Dipesan</th>
                  <td>
                    {{ request_list.details.data.unit_name }}
                  </td>
                </tr>
                <tr>
                  <th>Pesan</th>
                  <td>{{ request_list.details.data.request_message }}</td>
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
                  <td>Rp. {{ request_list.details.data.dp_price | currency }}</td>
                  <td>Rp. {{ request_list.details.data.installment_price | currency }}</td>
                  <td>{{ request_list.details.data.installment_tenor }} bulan (<span v-if="request_list.details.data.installment_tenor >= 12">{{ roundFixedYear( request_list.details.data.installment_tenor ) }} tahun</span>)</td>
                  <td>Rp. {{ request_list.details.data.installment_tenor * request_list.details.data.installment_price | currency }}
                  </td>
                </tr>
              </tbody>
            </table>

            <table v-show="request_list.details.data.meeting_time" class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
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
                  <td class="uk-width-medium">{{ $root.formatDate( request_list.details.data.meeting_time, 'dddd, DD MMMM YYYY' ) }}</td>
                  <td class="uk-width-medium">{{ $root.formatDate( request_list.details.data.meeting_time, 'HH:mm' ) }}</td>
                  <td>
                    <label class="uk-label" v-if="request_list.details.data.meeting_status === 'waiting_confirmation'">Menunggu Konfirmasi</label>
                    <label class="uk-label uk-label-success" v-else-if="request_list.details.data.meeting_status === 'accept'">Diterima</label>
                    <label class="uk-label uk-label-danger" v-else-if="request_list.details.data.meeting_status === 'reject'">Ditolak</label>
                    <label class="uk-label uk-label-danger" v-else-if="request_list.details.data.meeting_status === 'cancel'">Dibatalkan</label>
                    <label class="uk-label uk-label-warning" v-else-if="request_list.details.data.meeting_status === 'revision'">Revisi</label>
                    <label class="uk-label uk-label-success" v-else>Selesai</label>
                  </td>
                  <td>
                    <a v-if="request_list.details.data.document_file" target="_blank" class="uk-button uk-button-primary" :href="$root.url + '/storage/assets/document/meeting/' + request_list.details.data.document_file"><span uk-icon="download"></span> Unduh Dokumen</a>
                    <a v-else class="uk-button uk-button-primary" href="#"><span uk-icon="download"></span> Unduh Dokumen</a>
                  </td>
                </tr>
                <tr>
                  <th>Hasil Meeting</th>
                  <td colspan="3">
                    {{ request_list.details.data.meeting_result }}
                  </td>
                </tr>
              </tbody>
            </table>
            <div class="uk-margin">
              <h3 class="uk-h3">Track Pemesanan Unit</h3>
              <ul class="uk-margin uk-list uk-list-divider">
                <li v-for="log in request_list.details.log_request">
                  <div class="uk-text-small uk-text-bold">
                    {{ $root.formatDate( log.created_at, 'DD MMMM YYYY, HH:mm' ) }}
                  </div>
                  <span v-html="log.log_message"></span>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Pengajuan Pemesanan</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <select class="uk-select uk-select dash-form-input" v-model="forms.limit" @change="getRequestUnit()">
            <option value="5">5 baris</option>
            <option value="10">10 baris</option>
            <option value="15">15 baris</option>
            <option value="20">20 baris</option>
          </select>
        </div>
        <div>
          <select class="uk-select uk-select dash-form-input" v-model="forms.status_request" @change="getRequestUnit()">
            <option value="all">Semua Status</option>
            <option value="waiting_response">Menunggu Tanggapan</option>
            <option value="cancel">Dibatalkan</option>
            <option value="meeting">Dijadwalkan Meeting</option>
            <option value="reject">Ditolak</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="search"></span>
            <input type="search" class="uk-input dash-form-input" v-model="forms.keywords" @keyup.enter="getRequestUnit()" placeholder="Cari customer...">
          </div>
        </div>
      </div>

      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <div v-if="request_list.isLoading === true" class="uk-margin-top uk-text-center">
        <span uk-spinner></span>
      </div>
      <div v-else>
        <div v-if="request_list.total === 0" class="uk-alert-warning" uk-alert>
          Tidak ada pengajuan pemesanan unit
        </div>
        <div v-else class="uk-margin-top">
          <div v-for="unit in request_list.results" class="uk-width-1-1">
            <div class="uk-card uk-card-default card-unit-project uk-margin">
              <div class="uk-card-body card-unit-body">
                <div class="uk-margin-bottom card-unit-header">
                  <div class="uk-grid-small uk-child-width-auto" uk-grid>
                    <div v-if="unit.meeting_time !== null">
                      <div class="status-request status-request-meeting" v-if="unit.meeting_status === 'waiting_confirmation' || unit.meeting_status === 'revision'">Dijadwalkan meeting</div>
                      <div class="status-request status-request-meeting-done" v-if="unit.meeting_status === 'done'">Meeting telah selesai</div>
                      <div class="status-request status-request-cancel" v-if="unit.meeting_status === 'cancel'">Undangan Dibatalkan</div>
                      <div class="status-request status-request-reject" v-if="unit.meeting_status === 'reject'">Undangan Ditolak</div>
                      <div class="status-request status-request-accept" v-if="unit.meeting_status === 'accept'">Undangan diterima</div>
                    </div>
                    <div>
                      <div class="status-request status-request-waiting-response" v-if="unit.status_request === 'waiting_response'">Menunggu Tanggapan</div>
                      <div class="status-request status-request-accept" v-if="unit.status_request === 'accept' && unit.isReviewed === 'Y'">Pengajuan Diteima</div>
                      <div class="status-request status-request-reject" v-if="unit.status_request === 'reject' && unit.isReviewed === 'Y'">Pengajuan Ditolak</div>
                      <div class="status-request status-request-cancel" v-if="unit.status_request === 'cancel'">Pesanan Dibatalkan</div>
                    </div>
                    <div v-show="unit.meeting_status === 'done'">
                      <span class="status-review status-review-waiting" v-if="unit.isReviewed === 'N'">Belum direview</span>
                      <span class="status-review status-review-accept" v-if="unit.isReviewed === 'Y'">Sudah direview</span>
                    </div>
                    <div class="uk-width-expand">
                      <div class="uk-float-right">
                        <div class="uk-inline">
                          <a class="card-unit-setting-icon" uk-icon="icon: more"></a>
                          <div uk-dropdown="mode: click" class="card-unit-setting-dropdown">
                            <ul class="uk-nav uk-dropdown-nav">
                              <li><a @click="onDetailRequest( unit.request_id )">Lihat Rincian</a></li>
                              <li><a target="_blank" :href="$root.url + '/developer/report/request_unit/save/' + unit.request_id">Cetak</a></li>
                              <li v-show="unit.status_request !== 'cancel' && unit.status_request !== 'reject' && unit.status_request !== 'accept'"><a @click="onRejectRequest( unit.request_id )">Tolak Pengajuan</a></li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="unit-name">{{ unit.unit_name }}</div>
                <div class="uk-margin-small unit-body">
                  <div class="uk-margin">
                    <div class="unit-body-heading"><strong>Pemesan</strong></div>
                    <div class="unit-body-content">
                      {{ unit.customer_name }} | {{ unit.customer_phone_number }} <br>
                      {{ unit.request_message }}
                    </div>
                  </div>
                </div>
                <div class="card-unit-footer">
                  <div class="uk-grid-small uk-child-width-auto" uk-grid>
                    <div>
                      <a class="uk-button uk-button-small uk-button-primary unit-readmore">Cicilan dipilih</a>
                      <div class="uk-width-2-3" uk-dropdown="mode: click;">
                        <h3 class="uk-h3">Info Cicilan</h3>
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
                              <td>Rp. {{ unit.dp_price | currency }}</td>
                              <td>Rp. {{ unit.installment_price | currency }}</td>
                              <td>{{ unit.installment_tenor }} bulan (<span v-if="unit.installment_tenor >= 12">{{ roundFixedYear( unit.installment_tenor ) }} tahun</span>)</td>
                              <td>Rp. {{ unit.installment_tenor * unit.installment_price | currency }}
                              </td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                    <div>
                      <div class="unit-specification">
                        {{ unit.request_id }}
                        <span>Request ID</span>
                      </div>
                    </div>
                    <div>
                      <div class="unit-specification">
                        {{ $root.formatDate( unit.created_at, 'DD MMMM YYYY' ) }}
                        <span>Tanggal Pengajuan</span>
                      </div>
                    </div>
                  </div>
                </div>
                <div v-if="unit.meeting_status === 'done' && unit.isReviewed === 'N'" class="uk-margin-small-top card-unit-header">
                  <a @click="onReviewRequest('accept', unit.request_id)" class="uk-button uk-button-primary uk-button-small status-review status-review-accept">Terima</a>
                  <a @click="onReviewRequest('reject', unit.request_id)" class="uk-button uk-button-primary uk-button-small status-review status-review-reject">Tolak</a>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <ul class="uk-pagination uk-flex-center">
        <li v-if="request_list.pagination.prev_page_url !== null">
          <a @click="getRequestList( request_list.pagination.prev_page_url )" uk-icon="chevron-left"></a>
        </li>
        <li v-else class="uk-disabled">
          <a uk-icon="chevron-left"></a>
        </li>
        <li v-if="request_list.pagination.next_page_url !== null">
          <a @click="getRequestList( request_list.pagination.next_page_url )" uk-icon="chevron-right"></a>
        </li>
        <li v-else class="uk-disabled">
          <a uk-icon="chevron-right"></a>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user'],
  data() {
    return {
      request_list: {
        isLoading: false,
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null
        },
        details: {
          data: {},
          log_request: []
        }
      },
      forms: {
        keywords: '',
        limit: 10,
        status_request: 'all'
      },
      errors: {
        errorMessage: ''
      }
    }
  },
  methods: {
    getRequestUnit( p )
    {
      var params = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&status_request=' + this.forms.status_request;
      this.errors.errorMessage = '';

      var url = this.$root.url + '/developer/customer/get_request_unit?page=' + this.request_list.pagination.current_page + '&' + params;
      if( p !== undefined )
        url = p;

      this.request_list.isLoading = true;
      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.request_list.isLoading = false;
        this.request_list.results = result.results.data;
        this.request_list.total = result.results.total;
        this.request_list.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url
        };
      }).catch( err => {
        this.request_list.isLoading = false;
        this.errors.errorMessage = err.response.statusText;
      });
    },
    onDetailRequest( id )
    {
      this.request_list.details.data = {};
      this.request_list.details.log_request = [];
      axios({
        method: 'get',
        url: this.$root.url + '/developer/customer/detail_request/' + id
      }).then( res => {
        let result = res.data;
        this.request_list.details.data = result.results.data;
        this.request_list.details.log_request = result.results.log;
        UIkit.modal('#detail-request').show();
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onRejectRequest( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menolak pengajuan ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Tidak',
          confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/developer/customer/review_request_unit/' + id + '/reject'
          }).then( res => {
            swal({
              title: 'Sukses',
              text: id + ' berhasil ditolak',
              icon: 'success',
              timer: 3000
            });
            setTimeout(() => {
              this.getRequestUnit();
            }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
    },
    onReviewRequest( status_review, id )
    {
      var messageConfirmation = status_review === 'accept' ? 'Apakah anda ingin menerima pengajuan ini?' : 'Apakah anda ingin menolak pengajuan ini?';
      swal({
        title: 'Konfirmasi',
        text: messageConfirmation,
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Tidak',
          confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/developer/customer/review_request_unit/' + id + '/' + status_review
          }).then( res => {
            swal({
              title: 'Sukses',
              text: id + ' berhasil diupdate.',
              icon: 'success',
              timer: 3000
            });
            setTimeout(() => {
              this.getRequestUnit();
            }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
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

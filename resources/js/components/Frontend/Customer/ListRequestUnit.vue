<template>
  <div>
    <div class="uk-margin-large-top uk-margin-large-bottom uk-container">
      <div class="uk-card uk-card-body uk-card-default card-requestlist">
        <div class="uk-heading-line card-requestlist-heading"><span>Daftar Pengajuan Pemesanan</span></div>
        <div class="uk-margin-top">
          <div class="uk-margin-small-bottom card-requestlist-subtext">Status Pengajuan</div>
          <div class="uk-grid-small uk-child-width-auto" uk-grid>
            <div>
              <button @click="getRequestList('all')" :class="{'btn-status-active': forms.status_request === 'all'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Semua</button>
            </div>
            <div>
              <button @click="getRequestList('waiting_response')" :class="{'btn-status-active': forms.status_request === 'waiting_response'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Menunggu Tanggapan</button>
            </div>
            <div>
              <button @click="getRequestList('cancel')" :class="{'btn-status-active': forms.status_request === 'cancel'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Dibatalkan</button>
            </div>
            <div>
              <button @click="getRequestList('meeting')" :class="{'btn-status-active': forms.status_request === 'meeting'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Dijadwalkan Meeting</button>
            </div>
            <div>
              <button @click="getRequestList('reject')" :class="{'btn-status-active': forms.status_request === 'reject'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Ditolak</button>
            </div>
            <div>
              <button @click="getRequestList('accept')" :class="{'btn-status-active': forms.status_request === 'accept'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Diterima</button>
            </div>
          </div>
        </div>

        <div v-show="errors.errorMessage" class="uk-alert-danger uk-margin-top" uk-alert>{{ errors.errorMessage }}</div>
        <div v-if="request_list.isLoading === true" class="uk-margin-top uk-text-center">
          <span uk-spinner></span>
        </div>
        <div v-else class="uk-margin">
          <div v-if="request_list.total === 0" class="uk-alert-warning" uk-alert>
            Anda belum mengajukan pemesanan unit.
          </div>
          <div v-else class="uk-grid-small uk-grid-divider uk-margin-top" uk-grid>
            <div v-for="unit in request_list.results" class="uk-width-1-1">
              <div class="uk-card card-unit-project uk-grid-collapse uk-grid-match uk-margin" uk-grid>
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
                    <div class="uk-clearfix">
                      <a class="uk-link uk-link-text uk-float-right" :href="$root.url + '/customer/print/' + unit.request_id">
                        <span uk-icon="print"></span>
                      </a>
                    </div>
                    <a :href="$root.url + '/project/detail_unit/' + unit.unit_slug" class="uk-card-title unit-name">{{ unit.unit_name }}</a>
                    <div class="unit-location">
                      <span uk-icon="icon: location; ratio: 0.8"></span>
                      {{ unit.project_address }},
                      {{ unit.city_name }},
                      {{ unit.province_name }}
                    </div>
                    <div class="unit-price">
                      Rp. {{ unit.unit_price | currency }}
                    </div>
                    <div>
                      <div v-if="unit.meeting_status === 'waiting_confirmation' || unit.meeting_status === 'revision'">
                        <div class="uk-text-small uk-margin-small-bottom">
                          Anda menerima undangan dari Marketing pada :<br>
                          <strong>
                            {{ $root.formatDate( unit.meeting_time, 'dddd, DD MMMM YYYY HH:mm' ) }}
                          </strong>
                        </div>
                        <button @click="onResponseMeeting( unit.request_id, 'accept' )" class="uk-button uk-button-small btn-approve">Terima</button>
                        <button @click="onResponseMeeting( unit.request_id, 'reject' )" class="uk-button uk-button-small btn-reject">Tolak</button>
                      </div>
                      <div v-else>
                        <div v-if="unit.status_request === 'cancel'" class="uk-label uk-label-danger">
                          <span uk-icon="close"></span> Pengajuan dibatalkan
                        </div>
                        <div v-else-if="unit.status_request === 'reject'" class="uk-label uk-label-danger">
                          <span uk-icon="close"></span> Pengajuan Ditolak
                        </div>
                        <div v-else-if="unit.status_request === 'accept'" class="uk-label uk-label-success">
                          <span uk-icon="check"></span> Pengajuan Diterima
                        </div>
                        <div v-else>
                          <div v-show="unit.meeting_time !== null">
                            <div class="uk-text-small uk-margin-small-bottom">
                              Jadwal undangan meeting :<br>
                              <strong>
                                {{ $root.formatDate( unit.meeting_time, 'dddd, DD MMMM YYYY HH:mm' ) }}
                              </strong>
                            </div>
                            <div uk-tooltip="Meeting telah dibatalkan oleh pihak Marketing" class="uk-label uk-label-danger" v-if="unit.meeting_status === 'cancel'">
                              <span uk-icon="close"></span> Meeting Dibatalkan
                            </div>
                            <div uk-tooltip="Anda telah menolak undangan ini" class="uk-label uk-label-danger" v-else-if="unit.meeting_status === 'reject'">
                              <span uk-icon="close"></span> Meeting Ditolak
                            </div>
                            <div uk-tooltip="Anda telah menerima undangan ini" class="uk-label uk-label-success" v-else-if="unit.meeting_status === 'accept'">
                              <span uk-icon="check"></span> Meeting Diterima
                            </div>
                            <div uk-tooltip="Meeting telah selesai dilakukan" class="uk-label uk-label-success" v-else>
                              <span uk-icon="check"></span> Meeting Selesai
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>
                  <div class="uk-card-footer card-unit-footer uk-padding-small">
                    <div class="uk-grid-small uk-child-width-auto" uk-grid>
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
                </div>
                <div class="uk-width-1-1">
                  <div class="uk-card-footer card-unit-footer uk-padding-remove uk-margin-small-top">
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
                      <div v-if="unit.status_request === 'accept'">
                        <a class="uk-button uk-button-small uk-button-primary unit-readmore">Pengajuan Diterima</a>
                      </div>
                      <div v-if="unit.status_request === 'reject'">
                        <a class="uk-button uk-button-small btn-cancel-request">Pengajuan Ditolak</a>
                      </div>
                      <div v-if="unit.status_request === 'cancel'">
                        <a class="uk-button uk-button-small btn-cancel-request">Pengajuan Dibatalkan</a>
                      </div>
                      <div v-if="unit.status_request === 'waiting_response' || unit.status_request === 'meeting'">
                        <button @click="onCancelRequest( unit.request_id )" class="uk-button uk-button-small btn-cancel-request">Batalkan Pengajuan</button>
                      </div>
                    </div>
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
  </div>
</template>

<script>
export default {
  props: [
    'session_user'
  ],
  data() {
    return {
      forms: {
        status_request: 'all'
      },
      errors: {
        errorMessage: ''
      },
      request_list: {
        isLoading: false,
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null
        }
      }
    }
  },
  methods: {
    getRequestList( status_request, p )
    {
      this.errors.errorMessage = '';

      if( status_request === undefined )
        status_request = 'all';

      this.forms.status_request = status_request;
      var url = this.$root.url + '/customer/get_request_list/' + this.forms.status_request;
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
    onCancelRequest( id )
    {
      swal({
        title: 'Konfirmasi?',
        text: 'Apakah anda ingin membatalkan pengajuan ini?',
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
            url: this.$root.url + '/customer/cancel_request/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Pengajuan berhasil dibatalkan',
              icon: 'success',
              timer: 3000
            });
            setTimeout(() => { this.getRequestList(); }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error',
              dangerMode: true,
              timer: 3000
            });
          });
        }
      });
    },
    onResponseMeeting( id, status_request )
    {
      var message = status_request === 'accept' ? 'Anda telah menerima undangan dari Marketing' : 'Anda telah menolak undangan dari Marketing';
      var messageConfirmation = status_request === 'accept' ? 'Apakah anda ingin menerima undangan ini?' : 'Apakah anda ingin menolak undangan ini?';

      swal({
        title: 'Konfirmasi',
        text: messageConfirmation,
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Tidak',
          confirm: {
            value: true, text: 'Ya'
          }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/customer/response_meeting_invitation/' + id + '/' + status_request
          }).then( res => {
            swal({
              title: 'Berhasil',
              text: message,
              icon: 'success',
              timer: 3000
            });
            setTimeout(() => {
              this.getRequestList( this.forms.status_request );
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
    this.getRequestList();
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div class="uk-margin-large-top uk-margin-large-bottom uk-container">
      <div class="uk-card uk-card-body uk-card-default card-requestlist">
        <div class="uk-heading-line card-requestlist-heading"><span>Daftar Jadwal Meeting</span></div>
        <div class="uk-margin-top">
          <div class="uk-grid-small uk-child-width-auto" uk-grid>
            <div>
              <select class="uk-select" v-model="forms.status_meeting" @change="getMeetingList()">
                <option value="all">Semua Status</option>
                <option value="waiting_confirmation">Menunggu Tanggapan</option>
                <option value="reject">Ditolak</option>
                <option value="revision">Revisi</option>
                <option value="cancel">Dibatalkan</option>
                <option value="accept">Diterima</option>
                <option value="done">Selesai</option>
              </select>
            </div>
          </div>
        </div>

        <div v-show="errors.errorMessage" class="uk-alert-danger uk-margin-top" uk-alert>{{ errors.errorMessage }}</div>
        <div v-if="meeting_list.isLoading === true" class="uk-margin-top uk-text-center">
          <span uk-spinner></span>
        </div>
        <div v-else class="uk-margin">
          <div v-if="meeting_list.total === 0" class="uk-alert-warning" uk-alert>
            Tidak ada jadwal meeting
          </div>
          <div v-else class="uk-grid-small uk-grid-divider uk-margin-top" uk-grid>
            <div v-for="meeting in meeting_list.results" class="uk-width-1-1">
              <div class="uk-card uk-card-body">
                <div class="uk-card-badge">
                  <span class="uk-label" v-if="meeting.meeting_status === 'waiting_confirmation' || meeting.meeting_status === 'revision'">Menunggu Tanggapan</span>
                  <span class="uk-label uk-label-danger" v-if="meeting.meeting_status === 'reject'">Ditolak</span>
                  <span class="uk-label uk-label-warning" v-if="meeting.meeting_status === 'cancel'">Dibatalkan</span>
                  <span class="uk-label uk-label-success" v-if="meeting.meeting_status === 'accept'">Anda menerima undangan</span>
                  <span class="uk-label uk-label-success" v-if="meeting.meeting_status === 'done'">Selesai</span>
                </div>
                <h4 class="uk-h4 uk-margin-remove-bottom">Undangan meeting dengan {{ meeting.created_by }}</h4>
                <div class="uk-margin-remove-top">
                  <strong>{{ meeting.unit_name }}</strong> <br />
                  <div class="uk-text-muted uk-margin-small-top">
                    <div class="uk-text-small">
                      Diundang: {{ $root.formatDate( meeting.created_at, 'DD MMM YYYY' ) }}
                    </div>
                    {{ meeting.meeting_note }}
                  </div>
                </div>
                <div class="uk-margin">
                  Tanggal Meeting: <br>{{ $root.formatDate( meeting.meeting_time, 'dddd, DD MMMM YYYY' ) }} pukul {{ $root.formatDate( meeting.meeting_time, 'HH:mm' ) }}
                  <div v-show="meeting.meeting_status === 'waiting_confirmation' || meeting.meeting_status === 'revision'" class="uk-margin-small-top">
                    <a class="uk-button uk-button-small uk-button-primary btn-accept" @click="onResponseMeeting( meeting.request_id, 'accept' )"><span uk-icon="icon: check; ratio: 0.8"></span> Terima</a>
                    <a class="uk-button uk-button-small uk-button-primary btn-reject" @click="onResponseMeeting( meeting.request_id, 'reject' )"><span uk-icon="icon: ban; ratio: 0.8"></span> Tolak</a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <ul class="uk-pagination uk-flex-center">
          <li v-if="meeting_list.pagination.prev_page_url !== null">
            <a @click="getMeetingList( meeting_list.pagination.prev_page_url )" uk-icon="chevron-left"></a>
          </li>
          <li v-else class="uk-disabled">
            <a uk-icon="chevron-left"></a>
          </li>
          <li v-if="meeting_list.pagination.next_page_url !== null">
            <a @click="getMeetingList( meeting_list.pagination.next_page_url )" uk-icon="chevron-right"></a>
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
    'session_user',
    'hasrequest'
  ],
  data() {
    return {
      forms: {
        status_meeting: 'all'
      },
      errors: {
        errorMessage: ''
      },
      meeting_list: {
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
    getMeetingList( p )
    {
      var param = 'status_meeting=' + this.forms.status_meeting;
      var url = this.$root.url + '/customer/get_meeting_invitation?page=' + this.meeting_list.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      this.errors.errorMessage = '';
      this.meeting_list.isLoading = true;
      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.meeting_list.isLoading = false;
        this.meeting_list.results = result.results.data;
        this.meeting_list.total = result.results.total;
        this.meeting_list.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url
        };
      }).catch( err => {
        this.meeting_list.isLoading = false;
        this.errors.errorMessage = err.response.statusText;
      });
    },
    onResponseMeeting( id, status_request )
    {
      var message = status_request === 'accept' ? 'Anda menerima undangan meeting' : 'Anda telah menolak undangan meeting';
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
              this.getMeetingList( this.forms.status_request );
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
    }
  },
  mounted() {
    this.getMeetingList();
  }
}
</script>

<style lang="css" scoped>
</style>

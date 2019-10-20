<template>
  <div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Developer</span></li>
        <li class="uk-disabled"><span>Marketing</span></li>
        <li><span>Jadwal Meeting</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Jadwal Meeting</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getMeetingList()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.status" @change="getMeetingList()">
              <option value="all">Semua status</option>
              <option value="waiting_confirmation">Menunggu Tanggapan</option>
              <option value="cancel">Dibatalkan</option>
              <option value="revision">Revisi</option>
              <option value="accept">Diterima</option>
              <option value="reject">Ditolak</option>
              <option value="done">Selesai</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getMeetingList()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getmeeting.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Jadwal
          </div>
          <div v-else>
            <label class="uk-label">{{ getmeeting.total }} Jadwal</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>ID</th>
                  <th>No. Pesanan</th>
                  <th>Jadwal</th>
                  <th>Pelanggan</th>
                  <th>Marketing</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="meet in getmeeting.results">
                  <td class="uk-width-small uk-text-truncate" uk-tooltip :title="meet.meeting_id">
                    {{ meet.meeting_id }}
                  </td>
                  <td class="uk-width-small uk-text-truncate" uk-tooltip :title="meet.request_id">
                    {{ meet.request_id }}
                  </td>
                  <td class="uk-width-small">{{ $root.formatDate( meet.meeting_time, 'DD/MM/YYYY HH:mm' ) }}</td>
                  <td>{{ meet.customer_name }}</td>
                  <td class="uk-width-small uk-text-truncate" uk-tooltip :title="meet.dev_name">{{ meet.dev_name }}</td>
                  <td>
                    <label class="uk-label" v-if="meet.meeting_status === 'waiting_confirmation'">Menunggu Konfirmasi</label>
                    <label class="uk-label uk-label-danger" v-else-if="meet.meeting_status === 'cancel'">Dibatalkan</label>
                    <label class="uk-label uk-label-danger" v-else-if="meet.meeting_status === 'reject'">Ditolak</label>
                    <label class="uk-label uk-label-warning" v-else-if="meet.meeting_status === 'revision'">Dijadwalkan Meeting</label>
                    <label class="uk-label uk-label-success" v-else-if="meet.meeting_status === 'accept'">Diterima</label>
                    <label class="uk-label uk-label-success" v-else>Selesai</label>
                  </td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getmeeting.paginate.prev_page_url" @click="getMeetingList( getmeeting.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getmeeting.paginate.next_page_url" @click="getMeetingList( getmeeting.paginate.next_page_url )">
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
      getmeeting: {
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
    getMeetingList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city + '&status=' + this.forms.status;
      var url = this.$root.url + '/cp/developer/meeting/get_meeting?page=' + this.getmeeting.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getmeeting.total = result.total;
        this.getmeeting.results = result.data;
        this.getmeeting.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailMeeting( data )
    {
      this.getmeeting.detail = data;
      UIkit.modal('#detail-request').show();
    },
    saveReport()
    {
      let param = 'status=' + this.forms.status;
      let url = this.$root.url + '/cp/developer/meeting/save_report?' + param;
      window.open( url, '_blank' );
    }
  },
  mounted() {
    this.getMeetingList();
  }
}
</script>

<style lang="css" scoped>
</style>

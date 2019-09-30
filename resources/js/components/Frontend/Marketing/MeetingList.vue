<template >
  <div>
    <div id="detail-schedule" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog uk-modal-body" uk-height-viewport>
        <a class="uk-modal-close-full uk-close-large" type="button" uk-close></a>
        <div class="uk-card uk-card-body container-viewschedule">
          <div class="uk-card-title container-viewschedule-heading">
            Detail Meeting {{ meeting_list.details.request_unique_id }}
          </div>
          <div class="uk-margin container-viewschedule-body">
            <table class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
              <tbody>
                <th>Unit Dipesan</th>
                <td colspan="3">
                  {{ meeting_list.details.unit_name }}
                </td>
                <tr>
                  <th>Nama Pelanggan</th>
                  <td>{{ meeting_list.details.customer_name }}</td>
                  <th>Nomor Telepon</th>
                  <td>{{ meeting_list.details.customer_phone_number }}</td>
                </tr>
                <tr>
                  <th>Alamat Email</th>
                  <td>{{ meeting_list.details.customer_email }}</td>
                  <th>Alamat</th>
                  <td>
                    {{ meeting_list.details.customer_address }} <br>
                    {{ meeting_list.details.city_name }}, {{ meeting_list.details.province_name }}
                  </td>
                </tr>
                <tr>
                  <th>Pesan</th>
                  <td colspan="3">{{ meeting_list.details.request_message }}</td>
                </tr>
              </tbody>
            </table>
            <table class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
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
                  <td class="uk-width-medium">{{ $root.formatDate( meeting_list.details.meeting_time, 'dddd, DD MMMM YYYY' ) }}</td>
                  <td class="uk-width-medium">{{ $root.formatDate( meeting_list.details.meeting_time, 'HH:mm' ) }}</td>
                  <td>
                    <label class="uk-label" v-if="meeting_list.details.meeting_status === 'waiting_confirmation'">Menunggu Konfirmasi</label>
                    <label class="uk-label uk-label-success" v-else-if="meeting_list.details.meeting_status === 'accept'">Diterima</label>
                    <label class="uk-label uk-label-danger" v-else-if="meeting_list.details.meeting_status === 'reject'">Ditolak</label>
                    <label class="uk-label uk-label-danger" v-else-if="meeting_list.details.meeting_status === 'cancel'">Dibatalkan</label>
                    <label class="uk-label uk-label-warning" v-else-if="meeting_list.details.meeting_status === 'revision'">Revisi</label>
                    <label class="uk-label uk-label-success" v-else>Selesai</label>
                  </td>
                  <td>
                    <a class="uk-button uk-button-primary" href="#"><span uk-icon="download"></span> Unduh Dokumen</a>
                  </td>
                </tr>
                <tr>
                  <th>Hasil Meeting</th>
                  <td colspan="3">
                    {{ meeting_list.details.meeting_result }}
                  </td>
                </tr>
              </tbody>
            </table>
            <table>
              <tbody>

              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Jadwal Meeting</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.limitrow">
            <option value="10">10 baris</option>
            <option value="20">20 baris</option>
            <option value="50">50 baris</option>
          </select>
        </div>
        <div>
          <v-date-picker
            mode="single"
            v-model="forms.datepicker.selectedDate"
            :formats="forms.datepicker.formats"
            :select-attribute="forms.datepicker.attributes"
            :input-props="forms.datepicker.props"
            :theme-styles="forms.datepicker.themeStyles"
            show-caps
          >
          </v-date-picker>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.status_meeting">
            <option value="all">Semua Status</option>
            <option value="waiting_confirmation">Menunggu Konfirmasi</option>
            <option value="accept">Diterima</option>
            <option value="revision">Revisi</option>
            <option value="cancel">Dibatalkan</option>
            <option value="reject">Ditolak</option>
            <option value="done">Selesai</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="search"></span>
            <input @keyup.enter="" type="search" v-model="forms.keywords" class="uk-input dash-form-input" placeholder="Masukkan kata kunci...">
          </div>
        </div>
        <div>
          <a @click="getMeetingList()" class="uk-button uk-button-primary dash-btn"><span class="icon ion-ios-funnel"></span> Filter</a>
        </div>
        <div>
          <a @click="onClearFilter()" class="uk-button uk-button-primary dash-btn"><span class="icon ion-ios-close-circle-outline"></span> Reset</a>
        </div>
      </div>
      <div class="uk-margin">
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <a class="uk-button uk-button-primary uk-button-small uk-margin-bottom dash-btn">Total: {{ meeting_list.total }}</a>
          </div>
          <div>
            <a :href="$root.url + '/marketing/meeting/create_schedule'" class="uk-button uk-button-primary uk-button-small uk-margin-bottom dash-btn">Buat Jadwal</a>
          </div>
        </div>
        <div v-if="meeting_list.isLoading" class="uk-margin uk-text-center">
          <span uk-spinner></span>
        </div>
        <div v-else class="uk-margin">
          <div v-show="meeting_list.errorMessage" class="uk-alert-danger" uk-alert>
            {{ meeting_list.errorMessage }}
          </div>
          <div v-if="meeting_list.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada jadwal meeting.
          </div>
          <div v-else>
            <table class="uk-table uk-table-responsive uk-table-divider uk-table-middle uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>ID</th>
                  <th>Nama Pelanggan</th>
                  <th>Tanggal</th>
                  <th>Status</th>
                  <th>Terakhir diubah</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="meet in meeting_list.results">
                  <td>
                    <div class="uk-inline">
                      <a class="uk-button uk-button-primary uk-button-small dash-btn dash-btn-action" uk-icon="icon: more-vertical; ratio: 0.7"></a>
                      <div uk-dropdown="mode: click">
                        <ul class="uk-nav uk-dropdown-nav">
                          <li><a @click="getDetailSchedule( meet.request_unique_id )"><span uk-icon="forward"></span> Lihat Jadwal</a></li>
                          <li><a :href="$root.url + '/marketing/meeting/edit_schedule/' + meet.request_unique_id"><span uk-icon="pencil"></span>
                            Edit Jadwal
                          </a></li>
                          <li><a v-show="meet.meeting_status === 'waiting_confirmation' || meet.meeting_status === 'revision'" @click=""><span uk-icon="close"></span> Batalkan</a></li>
                        </ul>
                      </div>
                    </div>
                  </td>
                  <td>{{ meet.request_unique_id }}</td>
                  <td>{{ meet.customer_name }}</td>
                  <td>{{ $root.formatDate( meet.meeting_time, 'DD MMM YYYY, HH:mm' ) }}</td>
                  <td>
                    <label class="uk-label" v-if="meet.meeting_status === 'waiting_confirmation'">Menunggu Konfirmasi</label>
                    <label class="uk-label uk-label-success" v-else-if="meet.meeting_status === 'accept'">Diterima</label>
                    <label class="uk-label uk-label-danger" v-else-if="meet.meeting_status === 'reject'">Ditolak</label>
                    <label class="uk-label uk-label-danger" v-else-if="meet.meeting_status === 'cancel'">Dibatalkan</label>
                    <label class="uk-label uk-label-warning" v-else-if="meet.meeting_status === 'revision'">Revisi</label>
                    <label class="uk-label uk-label-success" v-else>Selesai</label>
                  </td>
                  <td>{{ $root.formatDate( meet.updated_at, 'DD MMM YYYY, HH:mm' ) }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="meeting_list.pagination.prev_page_url" @click="getMeetingList( meeting_list.pagination.prev_page_url )" uk-icon="chevron-left"></a>
                <span v-else uk-icon="chevron-left"></span>
              </li>
              <li class="uk-disabled"><span>Halaman {{ meeting_list.pagination.current_page }} dari {{ meeting_list.pagination.last_page }}</span></li>
              <li>
                <a v-if="meeting_list.pagination.next_page_url" @click="getMeetingList( meeting_list.pagination.next_page_url )" uk-icon="chevron-right"></a>
                <span v-else uk-icon="chevron-right"></span>
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
  props: ['session_user'],
  data() {
    return {
      forms: {
        keywords: '',
        status_meeting: 'all',
        limitrow: 10,
        datepicker: {
          selectedDate: null,
          props: {
            class: 'uk-width-1-1 uk-input dash-form-input',
            placeholder: 'Masukkan tanggal',
            readonly: true
          },
          attributes: {},
          themeStyles: {},
          formats: {
            title: 'MMMM YYYY',
            weekdays: 'W',
            navMonths: 'MMM',
            input: ['L', 'YYYY-MM-DD', 'YYYY/MM/DD'], // Only for `v-date-picker`
            dayPopover: 'L', // Only for `v-date-picker`
            data: ['L', 'YYYY-MM-DD', 'YYYY/MM/DD'] // For attribute dates
          }
        }
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
        },
        details: {}
      }
    }
  },
  methods: {
    onClearFilter() {
      this.forms.datepicker.selectedDate = null;
      this.forms.keywords = '';
      this.forms.status_meeting = 'all';
      this.forms.limitrow = 10;
      this.getMeetingList();
    },
    getMeetingList( p )
    {
      var filterdate = this.forms.datepicker.selectedDate === null ? '' : this.$root.formatDate( this.forms.datepicker.selectedDate, 'YYYY-MM-DD' );
      var param = 'keywords=' + this.forms.keywords
      + '&status_meeting=' + this.forms.status_meeting
      + '&limitrow=' + this.forms.limitrow
      + '&filterdate=' + filterdate;
      var url = this.$root.url + '/marketing/meeting/get_meeting_list?page=' + this.meeting_list.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      this.meeting_list.isLoading = true;
      this.meeting_list.errorMessage = '';
      axios({
        method: 'get',
        url: url
      }).then( res => {
        this.meeting_list.isLoading = false;
        let result = res.data;

        this.meeting_list.results = result.results.data;
        this.meeting_list.total = result.results.total;
        this.meeting_list.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url
        };
      }).catch( err => {
        this.meeting_list.errorMessage = err.response.statusText;
        this.meeting_list.isLoading = false;
      });
    },
    getDetailSchedule( id )
    {
      this.meeting_list.details = {};
      axios({
        method: 'get',
        url: this.$root.url + '/marketing/meeting/detail_meeting/' + id
      }).then( res => {
        let result = res.data;
        this.meeting_list.details = result.results;
        UIkit.modal('#detail-schedule').show();
      }).catch( err => {
        console.log( err.response.statusText );
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

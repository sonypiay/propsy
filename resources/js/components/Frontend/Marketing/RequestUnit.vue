<template>
  <div>
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
            <option value="waiting_response">Meunggu Tanggapan</option>
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
                    <div>
                      <div class="status-request status-request-waiting-response" v-if="unit.status_request === 'waiting_response'">Menunggu Tanggapan</div>
                      <div class="status-request status-request-meeting" v-else-if="unit.status_request === 'meeting'">Dijadwalkan Meeting</div>
                      <div class="status-request status-request-cancel" v-else-if="unit.status_request === 'cancel'">Pesanan Dibatalkan</div>
                      <div class="status-request status-request-reject" v-else>Pesanan Ditolak</div>
                    </div>
                    <div class="uk-width-expand">
                      <div class="uk-float-right">
                        <div class="uk-inline">
                          <a class="card-unit-setting-icon" uk-icon="icon: more"></a>
                          <div uk-dropdown="mode: click" class="card-unit-setting-dropdown">
                            <ul class="uk-nav uk-dropdown-nav">
                              <li v-show="unit.status_request === 'waiting_response'"><a :href="$root.url + '/marketing/meeting/create_schedule/' + unit.request_unique_id">Buat Jadwal Meeting</a></li>
                              <li v-show="unit.status_request === 'meeting'"><a :href="$root.url + '/marketing/meeting/edit_schedule/' + unit.request_unique_id">Revisi Jadwal Meeting</a></li>
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
                      <div class="unit-specification">
                        {{ unit.request_unique_id }}
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

      var url = this.$root.url + '/marketing/customer/get_request_unit?page=' + this.request_list.pagination.current_page + '&' + params;
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
    }
  },
  mounted() {
    this.getRequestUnit();
  }
}
</script>

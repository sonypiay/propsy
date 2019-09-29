<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Pengajuan Pemesanan</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <select class="uk-select uk-select dash-form-input" v-model="forms.limit" @change="getRequestInfo()">
            <option value="5">5 baris</option>
            <option value="10">10 baris</option>
            <option value="15">15 baris</option>
            <option value="20">20 baris</option>
          </select>
        </div>
        <div>
          <select class="uk-select uk-select dash-form-input" v-model="forms.status_request" @change="getRequestInfo()">
            <option value="all">Semua Status</option>
            <option value="open">Open</option>
            <option value="cancel">Cancel</option>
            <option value="survey">On Survey</option>
            <option value="close">Closed</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="search"></span>
            <input type="search" class="uk-input dash-form-input" v-model="forms.keywords" @keyup.enter="getRequestInfo()" placeholder="Cari customer...">
          </div>
        </div>
      </div>

      <div v-if="request_list.isLoading === true" class="uk-text-center">
        <span uk-spinner></span>
      </div>
      <div else class="uk-margin">
        <div v-if="request_list.total === 0" class="uk-alert-warning" uk-alert>
          Belum ada proyek.
        </div>
        <div v-else>
          <table class="uk-table uk-table-middle uk-table-hover uk-table-divider uk-table-striped uk-table-small">
            <thead>
              <tr>
                <th>Aksi</th>
                <th>Nama Customer</th>
                <th>Email</th>
                <th>No. Telepon</th>
                <th>Status Permintaan</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="req in request_list.results">
                <td>
                  <div class="uk-inline">
                    <a class="uk-button uk-button-primary uk-button-small dash-btn dash-action-btn" uk-icon="cog"></a>
                  </div>
                </td>
                <td>{{ req.customer_name }}</td>
                <td>{{ req.customer_email }}</td>
                <td>{{ req.customer_phone_number }}</td>
                <td>
                  <label class="uk-label uk-label-success" v-if="req.status_request === 'open'">Open</label>
                  <label class="uk-label uk-label-danger" v-else>Closed</label>
                </td>
              </tr>
            </tbody>
          </table>
          <div class="uk-text-center uk-margin">
            <a class="uk-button uk-button-small uk-button-primary dash-btn">Lihat Lebih Banyak</a>
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
      request_list: {
        isLoading: false,
        total: 0,
        results: [],
        currentOffset: 0,
        nextOffset: null
      },
      forms: {
        keywords: '',
        limit: 10,
        status_request: 'all'
      }
    }
  },
  methods: {
    getRequestInfo( offset )
    {
      if( offset === undefined )
      {
        this.request_list.nextOffset = 0;
      }
      else
      {
        this.request_list.nextOffset = this.request_list.nextOffset + offset;
      }
      this.request_list.currentOffset = this.request_list.nextOffset;
      var params = 'offset=' + this.request_list.currentOffset + '&keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&status_request=' + this.forms.status_request;

      axios({
        method: 'get',
        url: this.$root.url + '/marketing/customer/get_request_info?' + params
      }).then( res => {
        let results = res.data;
        if( this.request_list.total === 0 )
        {
          this.request_list.results = results.data.result;
        }
        else
        {
          var newdata = results.data;
          if( newdata.total !== 0 )
          {
            for( let i = 0; i < newdata.result.total; i++ )
            {
              this.request_list.results.pust(newdata.result[i]);
            }
          }
        }
        this.request_list.total = this.request_list.results.length;
      });
    }
  },
  mounted() {
    this.getRequestInfo();
  }
}
</script>

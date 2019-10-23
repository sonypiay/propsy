<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Laporan Data Pelanggan</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.limit" @change="getReportCustomer()">
            <option value="10">10 baris</option>
            <option value="20">20 baris</option>
            <option value="30">30 baris</option>
            <option value="50">50 baris</option>
          </select>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.city" @change="getReportCustomer()">
            <option value="all">Semua kota</option>
            <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="search"></span>
            <input type="search" class="uk-input dash-form-input" v-model="forms.keywords" @keyup.enter="getReportCustomer()" />
          </div>
        </div>
        <div>
          <a class="uk-button uk-button-default dash-btn" @click="onSaveAs('pdf')"><span uk-icon="print"></span> Cetak</a>
        </div>
      </div>
      <div class="uk-margin">
        <a class="uk-button uk-button-small uk-button-default dash-btn">{{ getcustomer.total }} Pelanggan</a>
        <table class="uk-table uk-table-responsive uk-table-divider uk-table-middle uk-table-small">
          <thead>
            <tr>
              <th>Nama Pelanggan</th>
              <th>Email</th>
              <th>No. Telepon</th>
              <th>Kota</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="customer in getcustomer.results">
              <td>{{ customer.customer_name }}</td>
              <td>{{ customer.customer_email }}</td>
              <td>{{ customer.customer_phone_number }}</td>
              <td>{{ customer.city_name }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getcity'],
  data() {
    return {
      forms: {
        keywords: '',
        city: 'all',
        limit: 10
      },
      getcustomer: {
        total: 0,
        results: [],
        isLoading: false,
        paginate: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null
        }
      },
      errors: {
        errorMessage: ''
      }
    }
  },
  methods: {
    getReportCustomer( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&city=' + this.forms.city + '&limit=' + this.forms.limit;
      var url = this.$root.url + '/developer/report/customer/get_customer?page=' + this.getcustomer.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getcustomer.results = result.data;
        this.getcustomer.total = result.total;
        this.getcustomer.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          prev_page_url: result.prev_page_url,
          next_page_url: result.next_page_url
        };
      });
    },
    onSaveAs( file )
    {
      var param = 'city=' + this.forms.city;
      var url = this.$root.url + '/developer/report/customer/save_report?' + param;
      window.open( url, '_blank' );
    }
  },
  mounted() {
    this.getReportCustomer();
  }
}
</script>

<style lang="css" scoped>
</style>

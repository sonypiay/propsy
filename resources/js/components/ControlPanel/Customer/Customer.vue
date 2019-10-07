<template>
  <div>
    <div id="modal-customer" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-h3">Detail Pelanggan</h3>
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Foto</h4>
              <img v-if="getcustomer.detail.customer_photo" :src="this.$root.url + '/images/avatar/' + getcustomer.detail.customer_photo" />
              <img v-else :src="this.$root.url + '/images/avatar/avatar.jpg'" alt="" />
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">{{ getcustomer.detail.customer_name }}</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Bergabung pada
                <span v-show="getcustomer.detail.created_at">
                  {{ $root.formatDate( getcustomer.detail.created_at, 'DD MMMM YYYY' ) }}
                </span>
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat Email</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getcustomer.detail.customer_email }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Nomor Telepon</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getcustomer.detail.customer_phone_number }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getcustomer.detail.customer_address }} <br>
                {{ getcustomer.detail.city_name }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Status Verifikasi</h4>
              <label v-if="getcustomer.detail.status_verification === 'Y'" class="uk-label uk-label-success">Terverifikasi</label>
              <label v-else class="uk-label uk-label-warning">Belum Verifikasi</label>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Pelanggan</span></li>
        <li><span>Pelanggan</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Pelanggan</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getCustomerList()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.city" @change="getCustomerList()">
              <option value="all">Semua kota</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getCustomerList()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getcustomer.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Pelanggan
          </div>
          <div v-else>
            <label class="uk-label">{{ getcustomer.total }} pelanggan</label>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Pelanggan</th>
                  <th>Email</th>
                  <th>Kota</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="customer in getcustomer.results">
                  <td>
                    <a uk-tooltip="Lihat Detail" @click="onDetailCustomer( customer )" class="uk-icon-link" uk-icon="forward"></a>
                  </td>
                  <td>{{ customer.customer_name }}</td>
                  <td>{{ customer.customer_email }}</td>
                  <td>{{ customer.city_name }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getcustomer.paginate.prev_page_url" @click="getCustomerList( getcustomer.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getcustomer.paginate.next_page_url" @click="getCustomerList( getcustomer.paginate.next_page_url )">
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
        city: 'all'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getcustomer: {
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
    getCustomerList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city;
      var url = this.$root.url + '/cp/customer/get_customer?page=' + this.getcustomer.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getcustomer.total = result.total;
        this.getcustomer.results = result.data;
        this.getcustomer.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailCustomer( data )
    {
      this.getcustomer.detail = data;
      UIkit.modal('#modal-customer').show();
    }
  },
  mounted() {
    this.getCustomerList();
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div id="modal-marketing" class="uk-modal-container" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-h3">Detail Marketing</h3>
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-panel uk-margin">
              <img v-if="getmarketing.detail.mkt_profile_photo" :src="this.$root.url + '/images/devlogo/' + getmarketing.detail.mkt_profile_photo" />
              <img v-else :src="this.$root.url + '/images/avatar/avatar.jpg'" alt="" />
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">{{ getmarketing.detail.dev_name }}</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Bergabung pada
                <span v-show="getmarketing.detail.created_at">
                  {{ $root.formatDate( getmarketing.detail.created_at, 'DD MMMM YYYY' ) }}
                </span>
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Nama Marketing</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getmarketing.detail.dev_ownername }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat Email</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getmarketing.detail.dev_email }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Telepon</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Kantor: {{ getmarketing.detail.customer_phone_number }} <br />
                Whatsapp: {{ getmarketing.detail.dev_mobile_phone }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getmarketing.detail.dev_address }} <br>
                {{ getmarketing.detail.city_name }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Pengembang</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getmarketing.detail.dev_name }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Developer</span></li>
        <li><span>Marketing</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Marketing</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getMarketingList()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.city" @change="getMarketingList()">
              <option value="all">Semua kota</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getMarketingList()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getmarketing.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Marketing
          </div>
          <div v-else>
            <label class="uk-label">{{ getmarketing.total }} Marketing</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Marketing</th>
                  <th>Username</th>
                  <th>Email</th>
                  <th>Kota</th>
                  <th>Pengembang</th>
                  <th>Tanggal Bergabung</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="mkt in getmarketing.results">
                  <td>
                    <a uk-tooltip="Lihat Detail" @click="onDetailMarketing( mkt )" class="uk-icon-link" uk-icon="forward"></a>
                  </td>
                  <td>{{ mkt.mkt_fullname }}</td>
                  <td>{{ mkt.mkt_username }}</td>
                  <td>{{ mkt.mkt_email }}</td>
                  <td>{{ mkt.city_name }}</td>
                  <td>{{ mkt.dev_name }}</td>
                  <td>{{ $root.formatDate( mkt.created_at, 'DD/MM/YYYY' ) }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getmarketing.paginate.prev_page_url" @click="getMarketingList( getmarketing.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getmarketing.paginate.next_page_url" @click="getMarketingList( getmarketing.paginate.next_page_url )">
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
      getmarketing: {
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
    getMarketingList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city;
      var url = this.$root.url + '/cp/developer/marketing/get_marketing?page=' + this.getmarketing.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getmarketing.total = result.total;
        this.getmarketing.results = result.data;
        this.getmarketing.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailMarketing( data )
    {
      this.getmarketing.detail = data;
      UIkit.modal('#modal-marketing').show();
    },
    saveReport()
    {
      let param = 'city=' + this.forms.city + '&keywords=' + this.forms.keywords;
      let url = this.$root.url + '/cp/developer/marketing/save_report?' + param;
      window.open( url, '_blank' );
    }
  },
  mounted() {
    this.getDeveloperList();
  }
}
</script>

<style lang="css" scoped>
</style>

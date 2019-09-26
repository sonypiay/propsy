<template>
  <div>
    <div id="modal" class="uk-modal-container" v-show="marketing_detail !== null" uk-modal>
      <div class="uk-modal-body uk-modal-dialog">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-h3">Detail Marketing</h3>
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin">
              <div class="uk-text-bold">Nama</div>
              <div>{{ marketing_detail.mkt_fullname }}</div>
            </div>
          </div>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin">
              <div class="uk-text-bold">Foto</div>
              <div v-if="marketing_detail.mkt_profile_photo">
                <img class="uk-width-1-2" :src="$root.url + '/images/avatar/' + marketing_detail.mkt_profile_photo" alt="">
              </div>
              <div v-else>
                Tidak ada foto
              </div>
            </div>
          </div>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin">
              <div class="uk-text-bold">Telepon</div>
              <div>{{ marketing_detail.mkt_phone_number }}</div>
            </div>
          </div>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin">
              <div class="uk-text-bold">No. Handphone</div>
              <div>{{ marketing_detail.mkt_mobile_phone }}</div>
            </div>
          </div>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin">
              <div class="uk-text-bold">Email</div>
              <div>{{ marketing_detail.mkt_email }}</div>
            </div>
          </div>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin">
              <div class="uk-text-bold">Kota</div>
              <div>{{ marketing_detail.city_name }}, {{ marketing_detail.province_name }}</div>
            </div>
          </div>
          <div class="uk-width-1-1">
            <div class="uk-margin">
              <div class="uk-text-bold">Tentang Marketing</div>
              <div class="uk-text-justify">{{ marketing_detail.mkt_biography }}</div>
            </div>
          </div>
        </div>
        <div class="uk-margin modal-form">
          <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>
            {{ errors.errorMessage }}
          </div>
          <div class="uk-margin-bottom uk-overflow-auto">
            <div v-show="errors.name.selectproject" class="uk-text-small uk-text-danger">{{ errors.name.selectproject }}</div>
            <div class="uk-grid-small uk-child-width-auto" uk-grid>
              <div v-for="project in getproject">
                <label><input type="checkbox" class="uk-checkbox" v-model="forms.selectproject" :value="project.project_id" /> {{ project.project_name }}</label>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- modal add/delete marketing -->
    <div id="modal-add-marketing" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-modal-title">
          <span v-if="forms.isedit">Edit Marketing</span>
          <span v-else>Tambah Marketing</span>
        </h3>
        <form class="uk-form-stacked modal-form" @submit.prevent="forms.marketing.isedit === false ? onAddMarketing() : onSaveMarketing()">
          <div class="uk-margin">
            <label class="uk-form-label modal-label">Nama Marketing</label>
            <div class="uk-form-controls">
              <input type="text" class="uk-input modal-input" v-model="forms.marketing.fullname" required>
            </div>
            <div v-show="errors.name.mkt_fullname" class="uk-text-small uk-text-danger">{{ errors.name.mkt_fullname }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label modal-label">Email</label>
            <div class="uk-form-controls">
              <input type="email" class="uk-input modal-input" v-model="forms.marketing.email" required>
            </div>
            <div v-show="errors.name.mkt_email" class="uk-text-small uk-text-danger">{{ errors.name.mkt_email }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label modal-label">Telepon Kantor</label>
            <div class="uk-form-controls">
              <input type="text" class="uk-input modal-input" v-model="forms.marketing.phone_number" required>
            </div>
            <div v-show="errors.name.mkt_phone_number" class="uk-text-small uk-text-danger">{{ errors.name.mkt_phone_number }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label modal-label">No. Handphone / Whatsapp</label>
            <div class="uk-form-controls">
              <input type="text" class="uk-input modal-input" v-model="forms.marketing.mobile_phone" required>
            </div>
            <div v-show="errors.name.mkt_mobile_phone" class="uk-text-small uk-text-danger">{{ errors.name.mkt_mobile_phone }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label modal-label">Provinsi</label>
            <div class="uk-form-controls">
              <select class="uk-select modal-input" v-model="forms.marketing.region" @change="getCityData()">
                <option :value="0">-- Pilih Provinsi --</option>
                <option v-for="region in forms.getregion" :value="region.province_id">{{ region.province_name }}</option>
              </select>
            </div>
            <div v-show="errors.name.mkt_region" class="uk-text-small uk-text-danger">{{ errors.name.mkt_region }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label modal-label">Kota</label>
            <div class="uk-form-controls">
              <select class="uk-select modal-input" v-model="forms.marketing.city">
                <option :value="0">-- Pilih Kota --</option>
                <option v-for="city in forms.getcity" :value="city.city_id">{{ city.city_name }}</option>
              </select>
            </div>
            <div v-show="errors.name.mkt_city" class="uk-text-small uk-text-danger">{{ errors.name.mkt_city }}</div>
          </div>
          <div class="uk-margin">
            <button type="submit" v-html="forms.marketing.submit" class="uk-button uk-button-primary modal-form-add"></button>
            <a class="uk-modal-close uk-button uk-button-primary modal-form-cancel">Batal</a>
          </div>
        </form>
      </div>
    </div>
    <!-- modal add/delete marketing -->

    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Cari Marketing</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.column" @change="getMarketingList()">
            <option value="mkt_fullname">Nama Lengkap</option>
            <option value="mkt_email">Email</option>
            <option value="mkt_mobile_phone">No. Handphone</option>
          </select>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.city" @change="getMarketingList()">
            <option value="all">Semua Kota</option>
            <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
          </select>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.sorting" @change="getMarketingList()">
            <option value="asc">A - Z</option>
            <option value="desc">Z - A</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="search"></span>
            <input @keyup.enter="getMarketingList()" type="search" v-model="forms.keywords" class="uk-input dash-form-input" placeholder="Masukkan kata kunci...">
          </div>
        </div>
        <div>
          <a @click="onPopupModalAdd()" class="uk-button uk-button-primary dash-btn">Tambah Marketing</a>
        </div>
      </div>
      <div class="uk-margin uk-overflow-auto">
        <table class="uk-table uk-table-responsive uk-table-divider uk-table-middle uk-table-small">
          <thead>
            <tr>
              <th>Aksi</th>
              <th>Nama</th>
              <th>Telepon / Handphone</th>
              <th>Email</th>
              <th>Kota</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="mkt in marketingList.results">
              <td>
                <a @click="detailMarketing(mkt)" uk-tooltip="Lihat Detail" href="#" class="uk-button uk-button-primary uk-button-small dash-btn"><i class="icon ion-ios-redo"></i></a>
              </td>
              <td>{{ mkt.mkt_fullname }}</td>
              <td>{{ mkt.mkt_mobile_phone }} / {{ mkt.mkt_phone_number }}</td>
              <td>{{ mkt.mkt_email }}</td>
              <td>{{ mkt.city_name }}</td>
            </tr>
          </tbody>
        </table>
        <ul class="uk-pagination uk-flex-center">
          <li>
            <a v-if="marketingList.pagination.prev_page_url" @click="getMarketingList( marketingList.pagination.prev_page_url )" uk-icon="chevron-left"></a>
            <span v-else uk-icon="chevron-left"></span>
          </li>
          <li class="uk-disabled"><span>Halaman {{ marketingList.pagination.current_page }} dari {{ marketingList.pagination.last_page }}</span></li>
          <li>
            <a v-if="marketingList.pagination.next_page_url" @click="getMarketingList( marketingList.pagination.next_page_url )" uk-icon="chevron-right"></a>
            <span v-else uk-icon="chevron-right"></span>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getcity', 'getproject'],
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        column: 'mkt_fullname',
        sorting: 'asc',
        city: 'all',
        marketing: {
          fullname: '',
          email: '',
          username: '',
          phone_number: '',
          mobile_phone: '',
          city: 0,
          region: 0,
          submit: 'Tambah Marketing',
          isedit: false
        },
        getregion: [],
        getcity: []
      },
      marketingList: {
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null
        }
      },
      marketing_detail: {},
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    getRegionData()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/provinsi/all'
      }).then( res => {
        let results = res.data;
        this.forms.getregion = results.results.data
        this.getCityData();
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getCityData()
    {
      var region = this.forms.marketing.region;
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/kota/all/' + region
      }).then( res => {
        let results = res.data;
        this.forms.getcity = results.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onPopupModalAdd( data )
    {
      if( data === undefined )
      {
        this.forms.marketing.fullname = '';
        this.forms.marketing.email = '';
        this.forms.marketing.phone_number = '';
        this.forms.marketing.mobile_phone = '';
        this.forms.marketing.region = 0;
        this.forms.marketing.city = 0;
        this.forms.marketing.isedit = false;
        this.forms.marketing.submit = 'Tambah';
      }
      else
      {
        this.forms.marketing.fullname = data.mkt_fullname;
        this.forms.marketing.email = data.mkt_email;
        this.forms.marketing.phone_number = data.mkt_phone_number;
        this.forms.marketing.mobile_phone = data.mkt_mobile_phone;
        this.forms.marketing.region = data.province_id;
        this.forms.marketing.city = data.city_id;
        this.forms.marketing.isedit = true;
        this.forms.marketing.submit = 'Simpan Perubahan';
      }

      this.errors.name = {};
      this.errors.iserror = false;
      this.errors.errorMessage = '';
      UIkit.modal('#modal-add-marketing').show();
    },
    getMarketingList( offset )
    {
      var param = 'keywords=' + this.forms.keywords +
      '&city=' + this.forms.city +
      '&column=' + this.forms.column +
      '&sorting=' + this.forms.sorting;
      var url = this.$root.url + '/developer/marketing/list_marketing?page=' + this.marketingList.pagination.current_page + '&' + param;

      axios.get( url ).then( res => {
        let result = res.data;
        this.marketingList.results = result.results.data;
        this.marketingList.total = result.results.total;
        this.marketingList.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    detailMarketing( mkt )
    {
      this.forms.selectproject = [];
      this.marketing_detail = mkt;
      axios({
        method: 'get',
        url: this.$root.url + '/developer/marketing/project_selected/' + mkt.mkt_user_id
      }).then( res => {
        let result = res.data;
        this.project_selected.results = result.results.data;
        this.project_selected.total = result.results.total;
        this.project_selected.results.filter( p => {
          if( p.mkt_user_id !== null && p.mkt_user_id === mkt.mkt_user_id )
            this.forms.selectproject.push(p.project_id);
        });
      }).catch( err => { console.log( err.response.statusText ); });
      UIkit.modal('#modal').show();
    },
    onAddMarketing()
    {
      console.log('add marketing...');
    },
    onSaveMarketing()
    {
      console.log('save marketing...');
    }
  },
  mounted() {
    this.getMarketingList();
    this.getRegionData();
  }
}
</script>

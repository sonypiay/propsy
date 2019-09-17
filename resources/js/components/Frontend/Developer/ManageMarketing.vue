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
          <a @click="recruitMarketing(marketing_detail.mkt_user_id, 'add')" class="uk-button uk-button-primary uk-button-small modal-submit">
            <span v-if="project_selected.results.length === 0">Rekrut Marketing</span>
            <span v-else>Simpan Perubahan</span>
          </a>
          <a v-show="project_selected.results.length > 0" @click="recruitMarketing( marketing_detail.mkt_user_id, 'delete' )" class="uk-button uk-button-danger uk-button-small modal-form-cancel">Hapus dari Proyek</a>
        </div>
      </div>
    </div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Kelola Marketing</div>
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
      </div>
      <div class="uk-margin uk-overflow-auto">
        <table class="uk-table uk-table-responsive uk-table-divider uk-table-middle uk-table-small">
          <thead>
            <tr>
              <th>Aksi</th>
              <th>Nama</th>
              <th>Email</th>
              <th>Kota</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="mkt in marketingList.results">
              <td>
                <a @click="detailMarketing(mkt)" uk-tooltip="Lihat Detail" href="#" class="uk-button uk-button-primary uk-button-small dash-btn dash-btn-action"><i class="icon ion-ios-redo"></i></a>
                <a @click="deleteMarketing(mkt.mkt_user_id)" class="uk-button uk-button-primary uk-button-small dash-btn dash-btn-action"><i class="icon ion-ios-trash"></i></a>
              </td>
              <td>{{ mkt.mkt_fullname }}</td>
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
        selectproject: [],
        recruitProject: false
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
      project_selected: {
        results: [],
        total: 0
      },
      errors: {
        name: {},
        errorMessage: ''
      }
    }
  },
  methods: {
    getMarketingList( offset )
    {
      var param = 'keywords=' + this.forms.keywords +
      '&city=' + this.forms.city +
      '&column=' + this.forms.column +
      '&sorting=' + this.forms.sorting;
      var url = this.$root.url + '/developer/marketing/my_marketing?page=' + this.marketingList.pagination.current_page + '&' + param;

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
    recruitMarketing( mkt_user, action )
    {
      this.errors.name = {};
      this.errors.errorMessage = '';

      if( this.forms.selectproject.length === 0 )
      {
        this.errors.name.selectproject = 'Silakan pilih minimal 1 proyek';
        return false;
      }

      var method;
      if( action === 'add' )
      {
        method = 'post';
      }
      else
      {
        method = 'delete';
      }

      axios({
        method: method,
        url: this.$root.url + '/developer/marketing/recruit_marketing/' + mkt_user + '/' + action,
        params: {
          selectedproject: this.forms.selectproject
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: action === 'add' ? 'Berhasil merekrut marketing' : 'Marketing telah dihapus dari proyek',
          icon: 'success',
          timer: 3000
        });
        setTimeout(() => {
          this.getMarketingList();
          UIkit.modal('#modal').hide();
        }, 2000);
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    deleteMarketing( user_id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus marketing ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal',
          confirm: { text: 'Hapus', value: true }
        }
      }).then( val => {
        if( val === true )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/developer/marketing/recruit_marketing/' + user_id + '/delete',
            params: {
              selectedproject: []
            }
          }).then( res => {
            swal({
              title: 'Sukses',
              text: action === 'add' ? 'Berhasil merekrut marketing' : 'Marketing telah dihapus dari proyek',
              icon: 'success',
              timer: 3000
            });
            setTimeout(() => {
              this.getMarketingList();
              UIkit.modal('#modal').hide();
            }, 2000);
          }).catch( err => {
            console.log( err.response.statusText );
          });
        }
      });
    }
  },
  mounted() {
    this.getMarketingList();
  }
}
</script>

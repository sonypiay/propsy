<template>
  <div>
    <div id="modal" v-show="marketing_detail !== null" uk-modal>
      <div class="uk-modal-body uk-modal-dialog">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-h3">Detail Marketing</h3>
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-panel uk-margin">
              <img v-if="marketing_detail.mkt_profile_photo" :src="this.$root.url + '/storage/assets/images/marketing/' + marketing_detail.mkt_profile_photo" />
              <img v-else :src="this.$root.url + '/images/avatar/avatar.jpg'" alt="" />
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">{{ marketing_detail.mkt_fullname }}</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Terakhir diubah
                <span v-show="marketing_detail.updated_at">
                  {{ $root.formatDate( marketing_detail.updated_at, 'DD MMM YYYY HH:mm' ) }}
                </span>
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Username</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ marketing_detail.mkt_username }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat Email</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ marketing_detail.mkt_email }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Telepon</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Kantor: {{ marketing_detail.mkt_phone_number }} <br />
                Whatsapp: {{ marketing_detail.mkt_mobile_phone }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ marketing_detail.mkt_address }} <br>
                {{ marketing_detail.city_name }}
              </p>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- modal add/delete marketing -->
    <div id="modal-add-marketing" uk-modal>
      <div class="uk-modal-dialog">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <div class="uk-modal-header">
          <h4 class="uk-modal-title">
            <span v-if="forms.isedit">Edit Marketing</span>
            <span v-else>Tambah Marketing</span>
          </h4>
        </div>
        <form class="uk-form-stacked modal-form" @submit.prevent="forms.marketing.isedit === false ? onAddMarketing() : onSaveMarketing()">
          <div class="uk-modal-body uk-margin-bottom" uk-overflow-auto>
            <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Nama Marketing</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.marketing.fullname">
              </div>
              <div v-show="errors.name.mkt_fullname" class="uk-text-small uk-text-danger">{{ errors.name.mkt_fullname }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Email</label>
              <div class="uk-form-controls">
                <input type="email" class="uk-input modal-input" v-model="forms.marketing.email">
              </div>
              <div v-show="errors.name.mkt_email" class="uk-text-small uk-text-danger">{{ errors.name.mkt_email }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Telepon Kantor</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.marketing.phone_number">
              </div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">No. Handphone / Whatsapp</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.marketing.mobile_phone">
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
              <label class="uk-form-label modal-label">Alamat</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.marketing.address">
              </div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Username</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.marketing.username">
              </div>
              <div v-show="errors.name.mkt_username" class="uk-text-small uk-text-danger">{{ errors.name.mkt_username }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Password</label>
              <div class="uk-form-controls">
                <input type="password" class="uk-input modal-input" v-model="forms.marketing.password">
              </div>
              <div v-show="errors.name.mkt_password" class="uk-text-small uk-text-danger">{{ errors.name.mkt_password }}</div>
            </div>
          </div>
          <div class="uk-modal-footer">
            <button type="submit" v-html="forms.marketing.submit" class="uk-button uk-button-primary modal-form-add"></button>
            <a class="uk-modal-close uk-button uk-button-primary modal-form-cancel">Batal</a>
          </div>
        </form>
      </div>
    </div>
    <!-- modal add/delete marketing -->

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
        <div>
          <a @click="onPopupModalAdd()" class="uk-button uk-button-primary dash-btn">Tambah Marketing</a>
        </div>
      </div>
      <div class="uk-margin">
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
                <div class="uk-inline">
                  <a class="uk-button uk-button-primary uk-button-small dash-btn dash-btn-action" uk-icon="icon: more-vertical; ratio: 0.7"></a>
                  <div uk-dropdown="mode: click">
                    <ul class="uk-nav uk-dropdown-nav">
                      <li><a @click="detailMarketing(mkt)"><span uk-icon="forward"></span> Lihat Detail</a></li>
                      <li><a @click="onPopupModalAdd(mkt)"><span uk-icon="pencil"></span> Ubah</a></li>
                      <li><a @click="onDeleteMarketing( mkt.mkt_user_id )"><span uk-icon="trash"></span> Hapus</a></li>
                    </ul>
                  </div>
                </div>
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
  props: ['session_user', 'getcity'],
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
          address: '',
          username: '',
          password: '',
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
      this.getRegionData();
      if( data === undefined )
      {
        this.forms.marketing.fullname = '';
        this.forms.marketing.email = '';
        this.forms.marketing.phone_number = '';
        this.forms.marketing.mobile_phone = '';
        this.forms.marketing.region = 0;
        this.forms.marketing.city = 0;
        this.forms.marketing.address = '';
        this.forms.marketing.username = '';
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
        this.forms.marketing.address = data.mkt_address;
        this.forms.marketing.username = data.mkt_username;
        this.forms.marketing.user_id = data.mkt_user_id;
        this.forms.marketing.isedit = true;
        this.forms.marketing.submit = 'Simpan Perubahan';
      }
      this.forms.marketing.password = '';

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
      this.marketing_detail = mkt;
      axios({
        method: 'get',
        url: this.$root.url + '/developer/marketing/project_selected/' + mkt.mkt_user_id
      }).then( res => {
        let result = res.data;
        this.project_selected.results = result.results.data;
        this.project_selected.total = result.results.total;
      }).catch( err => { console.log( err.response.statusText ); });
      UIkit.modal('#modal').show();
    },
    onAddMarketing()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.marketing.fullname === '' )
      {
        this.errors.name.mkt_fullname = 'Nama marketing harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.email === '' )
      {
        this.errors.name.mkt_email = 'Alamat email harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.mobile_phone === '' )
      {
        this.errors.name.mkt_mobile_phone = 'No. Handphone harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.region === '' )
      {
        this.errors.name.mkt_region = 'Silakan pilih provinsi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.city === '' )
      {
        this.errors.name.mkt_city = 'Silakan pilih kota';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.username === '' )
      {
        this.errors.name.mkt_username = 'Username harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.password === '' )
      {
        this.errors.name.mkt_password = 'Password harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.password !== '' && this.forms.marketing.password.length < 8 )
      {
        this.errors.name.mkt_password = 'Password terlalu pendek';
        return false;
      }

      if( this.errors.iserror === true ) return false;

      let form_marketing = this.forms.marketing;
      form_marketing.submit = '<span uk-spinner></span>';

      axios({
        method: 'post',
        url: this.$root.url + '/developer/marketing/add_marketing',
        params: {
          mkt_fullname: form_marketing.fullname,
          mkt_email: form_marketing.email,
          mkt_phone_number: form_marketing.phone_number,
          mkt_mobile_phone: form_marketing.mobile_phone,
          mkt_city: form_marketing.city,
          mkt_address: form_marketing.address,
          mkt_password: form_marketing.password,
          mkt_username: form_marketing.username
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Marketing berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getMarketingList();
          UIkit.modal('#modal-add-marketing').hide();
        }, 2000);
      }).catch( err => {
        if( err.response.status === 409 )
        {
          this.errors.errorMessage = err.response.data.statusText;
        }
        else
        {
          this.errors.errorMessage = err.response.data.statusText;
        }
        swal({
          title: 'Whoops',
          text: 'Terjadi kesalahan',
          icon: 'error',
          dangerMode: true
        });
        form_marketing.submit = 'Tambah';
      });
    },
    onSaveMarketing()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.marketing.fullname === '' )
      {
        this.errors.name.mkt_fullname = 'Nama marketing harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.email === '' )
      {
        this.errors.name.mkt_email = 'Alamat email harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.mobile_phone === '' )
      {
        this.errors.name.mkt_mobile_phone = 'No. Handphone harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.region === '' )
      {
        this.errors.name.mkt_region = 'Silakan pilih provinsi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.city === '' )
      {
        this.errors.name.mkt_city = 'Silakan pilih kota';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.username === '' )
      {
        this.errors.name.mkt_username = 'Username harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.marketing.password !== '' && this.forms.marketing.password.length < 8 )
      {
        this.errors.name.mkt_password = 'Password terlalu pendek';
        return false;
      }

      if( this.errors.iserror === true ) return false;

      let form_marketing = this.forms.marketing;
      form_marketing.submit = '<span uk-spinner></span>';

      axios({
        method: 'put',
        url: this.$root.url + '/developer/marketing/save_marketing/' + this.forms.marketing.user_id,
        params: {
          mkt_fullname: form_marketing.fullname,
          mkt_email: form_marketing.email,
          mkt_phone_number: form_marketing.phone_number,
          mkt_mobile_phone: form_marketing.mobile_phone,
          mkt_city: form_marketing.city,
          mkt_address: form_marketing.address,
          mkt_password: form_marketing.password,
          mkt_username: form_marketing.username
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Perubahan berhasil disimpan',
          icon: 'success'
        });
        setTimeout(() => {
          this.getMarketingList();
          UIkit.modal('#modal-add-marketing').hide();
        }, 2000);
      }).catch( err => {
        if( err.response.status === 409 )
        {
          this.errors.errorMessage = err.response.data.statusText;
        }
        else
        {
          this.errors.errorMessage = err.response.data.statusText;
        }
        swal({
          title: 'Whoops',
          text: 'Terjadi kesalahan',
          icon: 'error',
          dangerMode: true
        });
        form_marketing.submit = 'Simpan Perubahan';
      });
    },
    onDeleteMarketing( id )
    {
      swal({
        title: 'Konfirmasi?',
        text: 'Apakah anda ingin menghapus marketing ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal',
          confirm: { value: true, text: 'Hapus' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/developer/marketing/delete_marketing/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Marketing berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => { this.getMarketingList(); }, 2000);
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
    this.getMarketingList();
  }
}
</script>

<template>
  <div>
    <div id="modal-city" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <div class="uk-modal-title">
          <span v-if="forms.isedit">Edit Kota</span>
          <span v-else>Tambah Kota</span>
        </div>
        <form class="uk-form-stacked" @submit.prevent="forms.isedit === false ? addCity() : saveCity()">
          <div v-show="message.errors.errorMessage" class="uk-margin uk-alert-danger" uk-alert>{{ message.errors.errorMessage }}</div>
          <div class="uk-margin">
            <label class="uk-form-label">Provinsi</label>
            <div class="uk-form-controls">
              <select class="uk-select uk-width-1-1" v-model="forms.province">
                <option value="">-- Pilih Provinsi --</option>
                <option v-for="province in getprovince" :value="province.province_id">{{ province.province_name }}</option>
              </select>
            </div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label">Nama Kota</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.city_name}" class="uk-input uk-width-1-1" v-model="forms.city_name" />
            </div>
            <div v-show="message.errors.city_name" class="uk-text-danger">{{ message.errors.city_name }}</div>
          </div>
          <div class="uk-margin">
            <button class="uk-button uk-button-primary" v-html="forms.submit"></button>
          </div>
        </form>
      </div>
    </div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Wilayah</span></li>
        <li><span>Kota</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Kota</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getCity()" />
            </div>
          </div>
          <div>
            <a @click="onClickModal()" class="uk-button uk-button-primary">Tambah Kota</a>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getprovince.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada kota
          </div>
          <div v-else>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Kota</th>
                  <th>Provinsi</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="city in getcity.results">
                  <td>
                    <a @click="onClickModal( city )" class="uk-icon-link uk-margin-small-right" uk-icon="file-edit"></a>
                    <a @click="deleteCity( city.city_id )" href="#" class="uk-icon-link uk-margin-small-right" uk-icon="trash"></a>
                  </td>
                  <td>{{ city.city_name }}</td>
                  <td>{{ city.province_name }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getcity.paginate.prev_page_url" @click="getCity( getcity.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getcity.paginate.next_page_url" @click="getCity( getcity.paginate.next_page_url )">
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
  props: [],
  data() {
    return {
      forms: {
        keywords: '',
        city_name: '',
        city_id: '',
        province: '',
        isedit: false,
        submit: 'Tambah'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getcity: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        }
      },
      getprovince: []
    }
  },
  methods: {
    getProvince() {
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/provinsi/all'
      }).then( res => {
        let results = res.data;
        this.getprovince = results.results.data
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getCity( p )
    {
      var params = 'keywords=' + this.forms.keywords;
      var url = this.$root.url + '/cp/wilayah/city/get_city?page=' + this.getcity.paginate.current_page + '&' + params;
      if( p !== undefined ) url = p + '&' + params;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getcity.total = result.total;
        this.getcity.results = result.data;

        this.getcity.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onClickModal( data )
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( data === undefined )
      {
        this.forms.city_name = '';
        this.forms.city_id = '';
        this.forms.province = '';
        this.forms.isedit = false;
        this.forms.submit = 'Tambah';
      }
      else
      {
        this.forms.city_name = data.city_name;
        this.forms.city_id = data.city_id;
        this.forms.province = data.province_id;
        this.forms.isedit = true;
        this.forms.submit = 'Simpan';
      }

      this.getProvince();
      UIkit.modal('#modal-city').show();
    },
    addCity()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.province === '' )
      {
        this.message.errors.province = 'Provinsi tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.forms.city_name === '' )
      {
        this.message.errors.city_name = 'Nama kota tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'post',
        url: this.$root.url + '/cp/wilayah/city/store',
        params: {
          city_name: this.forms.city_name,
          province: this.forms.province
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Kota baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getCity();
          UIkit.modal('#modal-city').hide();
        }, 1000);
      }).catch( err => {
        this.message.errorMessage = err.response.statusText;
        this.forms.submit = 'Tambah';
      });
    },
    saveCity()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.province === '' )
      {
        this.message.errors.province = 'Provinsi tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.forms.city_name === '' )
      {
        this.message.errors.city_name = 'Nama kota tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/wilayah/city/save/' + this.forms.city_id,
        params: {
          city_name: this.forms.city_name,
          province: this.forms.province
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Kota berhasil disimpan',
          icon: 'success'
        });
        setTimeout(() => {
          this.getCity();
          UIkit.modal('#modal-city').hide();
        }, 1000);
      }).catch( err => {
        this.message.errorMessage = err.response.statusText;
        this.forms.submit = 'Simpan';
      });
    },
    deleteCity( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus kota ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal',
          confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/cp/wilayah/city/delete/' + id
          }).then( res => {
            swal({
              title: 'Berhasil',
              text: 'Kota berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => {
              this.getCity();
            }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error'
            });
          });
        }
      });
    }
  },
  mounted() {
    this.getCity();
  }
}
</script>

<style lang="css" scoped>
</style>

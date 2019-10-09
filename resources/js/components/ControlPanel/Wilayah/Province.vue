<template>
  <div>
    <div id="modal-provinsi" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <div class="uk-modal-title">
          <span v-if="forms.isedit">Edit Provinsi</span>
          <span v-else>Tambah Provinsi</span>
        </div>
        <form class="uk-form-stacked" @submit.prevent="forms.isedit === false ? addProvince() : saveProvince()">
          <div v-show="message.errorMessage" class="uk-margin uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
          <div class="uk-margin">
            <label class="uk-form-label">ID Provinsi</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.province_id}" maxlength="2" class="uk-input uk-width-1-1" v-model="forms.province_id" />
            </div>
            <div v-show="message.errors.province_id" class="uk-text-danger">{{ message.errors.province_id }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label">Nama Provinsi</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.province_name}" class="uk-input uk-width-1-1" v-model="forms.province_name" />
            </div>
            <div v-show="message.errors.province_name" class="uk-text-danger">{{ message.errors.province_name }}</div>
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
        <li class="uk-disabled"><span>Manajemen</span></li>
        <li><span>Provinsi</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Provinsi</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getProvince()" />
            </div>
          </div>
          <div>
            <a @click="onClickModal()" class="uk-button uk-button-primary">Tambah Provinsi</a>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getprovince.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada provinsi
          </div>
          <div v-else>
            <label class="uk-label">{{ getprovince.total }} Provinsi</label>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>ID</th>
                  <th>Nama Provinsi</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="province in getprovince.results">
                  <td>
                    <a @click="onClickModal( province )" class="uk-icon-link uk-margin-small-right" uk-icon="file-edit"></a>
                    <a @click="deleteProvince( province.province_id )" href="#" class="uk-icon-link uk-margin-small-right" uk-icon="trash"></a>
                  </td>
                  <td>{{ province.province_id }}</td>
                  <td>{{ province.province_name }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getprovince.paginate.prev_page_url" @click="getProvince( getprovince.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getprovince.paginate.next_page_url" @click="getProvince( getprovince.paginate.next_page_url )">
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
        province_name: '',
        province_id: '',
        isedit: false,
        submit: 'Tambah'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getprovince: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        }
      }
    }
  },
  methods: {
    getProvince( p )
    {
      var params = 'keywords=' + this.forms.keywords;
      var url = this.$root.url + '/cp/wilayah/province/get_province?page=' + this.getprovince.paginate.current_page + '&' + params;
      if( p !== undefined ) url = p + '&' + params;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getprovince.total = result.total;
        this.getprovince.results = result.data;

        this.getprovince.paginate = {
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
        this.forms.province_name = '';
        this.forms.province_id = '';
        this.forms.isedit = false;
        this.forms.submit = 'Tambah';
      }
      else
      {
        this.forms.province_name = data.province_name;
        this.forms.province_id = data.province_id;
        this.forms.isedit = true;
        this.forms.submit = 'Simpan';
      }

      UIkit.modal('#modal-provinsi').show();
    },
    addProvince()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.province_name === '' )
      {
        this.message.errors.province_id = 'ID provinsi tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.forms.province_name === '' )
      {
        this.message.errors.province_name = 'Nama provinsi tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'post',
        url: this.$root.url + '/cp/wilayah/province/store',
        params: {
          province_id: this.forms.province_id,
          province_name: this.forms.province_name
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Provinsi baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getProvince();
          UIkit.modal('#modal-provinsi').hide();
        }, 1000);
      }).catch( err => {
        if( err.response.status === 500 ) this.message.errorMessage = err.response.statusText;
        else this.message.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Tambah';
      });
    },
    saveProvince()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.province_name === '' )
      {
        this.message.errors.province_id = 'ID provinsi tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.forms.province_name === '' )
      {
        this.message.errors.province_name = 'Nama provinsi tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/wilayah/province/save/' + this.forms.province_id,
        params: {
          province_id: this.forms.province_id,
          province_name: this.forms.province_name
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Provinsi berhasil disimpan',
          icon: 'success'
        });
        setTimeout(() => {
          this.getProvince();
          UIkit.modal('#modal-provinsi').hide();
        }, 1000);
      }).catch( err => {
        if( err.response.status === 500 ) this.message.errorMessage = err.response.statusText;
        else this.message.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Simpan';
      });
    },
    deleteProvince( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus provinsi ini?',
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
            url: this.$root.url + '/cp/wilayah/province/delete/' + id
          }).then( res => {
            swal({
              title: 'Berhasil',
              text: 'Provinsi berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => {
              this.getProvince();
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
    this.getProvince();
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div id="modal-fasilitas" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <div class="uk-modal-title">
          <span v-if="forms.isedit">Edit Fasilitas</span>
          <span v-else>Tambah Fasilitas</span>
        </div>
        <form class="uk-form-stacked" @submit.prevent="forms.isedit === false ? addFacility() : saveFacility()">
          <div v-show="message.errors.errorMessage" class="uk-margin uk-alert-danger" uk-alert>{{ message.errors.errorMessage }}</div>
          <div class="uk-margin">
            <label class="uk-form-label">Nama Fasilitas</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.facility_name}" class="uk-input uk-width-1-1" v-model="forms.facility_name" />
            </div>
            <div v-show="message.errors.facility_name" class="uk-text-danger">{{ message.errors.facility_name }}</div>
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
        <li class="uk-disabled"><span>Properti</span></li>
        <li><span>Fasilitas</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Fasilitas</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getFacility()" />
            </div>
          </div>
          <div>
            <a @click="onClickModal()" class="uk-button uk-button-primary">Tambah Fasilitas</a>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getfacility.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Fasilitas
          </div>
          <div v-else>
            <label class="uk-label">{{ getfacility.total }} fasilitas</label>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Fasilitas</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="facility in getfacility.results">
                  <td>
                    <a @click="onClickModal( facility )" class="uk-icon-link uk-margin-small-right" uk-icon="file-edit"></a>
                    <a @click="deleteFacility( facility.id_facility )" href="#" class="uk-icon-link uk-margin-small-right" uk-icon="trash"></a>
                  </td>
                  <td>{{ facility.facility_name }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getfacility.paginate.prev_page_url" @click="getFacility( getfacility.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getfacility.paginate.next_page_url" @click="getFacility( getfacility.paginate.next_page_url )">
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
        limit: 10,
        facility_name: '',
        id_facility: '',
        isedit: false,
        submit: 'Tambah'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getfacility: {
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
    getFacility( p )
    {
      var params = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit;
      var url = this.$root.url + '/cp/property/facility/get_facility?page=' + this.getfacility.paginate.current_page + '&' + params;
      if( p !== undefined ) url = p + '&' + params;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getfacility.total = result.total;
        this.getfacility.results = result.data;

        this.getfacility.paginate = {
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
        this.forms.facility_name = '';
        this.forms.id_facility = '';
        this.forms.isedit = false;
        this.forms.submit = 'Tambah';
      }
      else
      {
        this.forms.facility_name = data.facility_name;
        this.forms.id_facility = data.id_facility;
        this.forms.isedit = true;
        this.forms.submit = 'Simpan';
      }

      UIkit.modal('#modal-fasilitas').show();
    },
    addFacility()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.facility_name === '' )
      {
        this.message.errors.facility_name = 'Nama Fasilitas tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'post',
        url: this.$root.url + '/cp/property/facility/store',
        params: {
          facility_name: this.forms.facility_name
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Fasilitas baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getFacility();
          UIkit.modal('#modal-fasilitas').hide();
        }, 1000);
      }).catch( err => {
        this.message.errorMessage = err.response.statusText;
        this.forms.submit = 'Tambah';
      });
    },
    saveFacility()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.facility_name === '' )
      {
        this.message.errors.facility_name = 'Nama Fasilitas tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/property/facility/save/' + this.forms.id_facility,
        params: {
          facility_name: this.forms.facility_name
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Fasilitas berhasil disimpan',
          icon: 'success'
        });
        setTimeout(() => {
          this.getFacility();
          UIkit.modal('#modal-fasilitas').hide();
        }, 1000);
      }).catch( err => {
        this.message.errorMessage = err.response.statusText;
        this.forms.submit = 'Simpan';
      });
    },
    deleteFacility( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus fasilitas ini?',
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
            url: this.$root.url + '/cp/property/facility/delete/' + id
          }).then( res => {
            swal({
              title: 'Berhasil',
              text: 'Fasilitas berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => {
              this.getFacility();
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
    this.getFacility();
  }
}
</script>

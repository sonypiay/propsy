<template>
  <div>
    <!-- modal tambah proyek -->
    <div id="modal-proyek" uk-modal>
      <div class="uk-modal-dialog modal-form">
        <form class="uk-form-stacked" @submit.prevent="onAddOrSaveProject">
          <div class="uk-modal-header">
            <h3 class="modal-form-heading" v-if="forms.isEdit">Ubah Proyek</h3>
            <h3 class="modal-form-heading" v-else>Tambah Proyek</h3>
          </div>
          <div class="uk-modal-body" uk-overflow-auto>
            <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
            <div class="uk-text-small uk-margin-bottom">Lengkapi formulir dibawah ini (*)</div>
            <div class="uk-form-stacked">
              <div class="uk-margin">
                <label class="uk-form-label modal-label">*Nama Proyek</label>
                <div class="uk-form-controls">
                  <input type="text" class="uk-input modal-input" v-model="forms.project_name">
                </div>
                <div v-show="errors.name.project_name" class="uk-text-small uk-text-danger">{{ errors.name.project_name }}</div>
              </div>
              <div class="uk-margin">
                <label class="uk-form-label modal-label">*Provinsi</label>
                <div class="uk-form-controls">
                  <select class="uk-select modal-input" v-model="forms.project_region" @change="getRegionData()">
                    <option value="">-- Pilih --</option>
                    <option v-for="reg in getregion" :value="reg.area_id">{{ reg.area_name }}</option>
                  </select>
                </div>
                <div v-show="errors.name.project_region" class="uk-text-small uk-text-danger">{{ errors.name.project_region }}</div>
              </div>
              <div class="uk-margin">
                <label class="uk-form-label modal-label">*Kota</label>
                <div class="uk-form-controls">
                  <select class="uk-select modal-input" v-model="forms.project_city">
                    <option value="">-- Pilih --</option>
                    <option v-for="city in getcity" :value="city.area_id">{{ city.area_name }}</option>
                  </select>
                </div>
                <div v-show="errors.name.project_city" class="uk-text-small uk-text-danger">{{ errors.name.project_city }}</div>
              </div>
              <div class="uk-margin">
                <label class="uk-form-label modal-label">*Alamat</label>
                <div class="uk-form-controls">
                  <textarea class="uk-textarea uk-height-small modal-input" v-model="forms.project_address"></textarea>
                </div>
                <div v-show="errors.name.project_address" class="uk-text-small uk-text-danger">{{ errors.name.project_address }}</div>
              </div>
              <div class="uk-margin">
                <label class="uk-form-label modal-label">Link Google Maps</label>
                <div class="uk-form-controls">
                  <input type="text" class="uk-input modal-input" v-model="forms.project_gmaps">
                </div>
              </div>
              <div class="uk-margin">
                <label class="uk-form-label modal-label">*Deskripsi Proyek</label>
                <div class="uk-form-controls">
                  <textarea class="uk-textarea uk-height-small modal-input" v-model="forms.project_description"></textarea>
                </div>
                <div v-show="errors.name.project_description" class="uk-text-small uk-text-danger">{{ errors.name.project_description }}</div>
              </div>
              <div class="uk-margin">
                <label class="uk-form-label modal-label">Status Proyek</label>
                <div class="uk-form-controls">
                  <select class="uk-select modal-input" v-model="forms.project_status">
                    <option value="available">Available</option>
                    <option value="prelaunch">Pre-Launch</option>
                    <option value="hold">Hold</option>
                    <option value="booked">Booked</option>
                    <option value="sold">Sold</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="uk-modal-footer uk-text-right">
            <button class="uk-button uk-button-primary modal-form-add" v-html="forms.submit"></button>
            <a class="uk-button uk-button-primary modal-form-cancel uk-modal-close">Batal</a>
          </div>
        </form>
      </div>
    </div>

    <!-- modal tambah proyek -->
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Proyek</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <a class="uk-button uk-button-primary uk-margin dash-btn" @click="onPopUpModal()">Tambah Proyek</a>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.getstatus" @change="getProjectList()">
            <option value="all">Semua</option>
            <option value="available">Available</option>
            <option value="prelaunch">Pre-Launch</option>
            <option value="hold">Hold</option>
            <option value="booked">Booked</option>
            <option value="sold">Sold</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <a @click="getProjectList()" class="uk-form-icon" uk-icon="search"></a>
            <input @keyup.enter="getProjectList()" type="search" v-model="forms.keywords" class="uk-input dash-form-input" placeholder="Cari proyek...">
          </div>
        </div>
      </div>
      <div v-if="project_list.isLoading === true" class="uk-text-center">
        <span uk-spinner></span>
      </div>
      <div v-else>
        <div v-if="project_list.total === 0" class="uk-alert-warning" uk-alert>
          Belum ada proyek.
        </div>
        <div v-else class="uk-grid-small uk-grid-match" uk-grid>
          <div v-for="project in project_list.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-card uk-card-default dash-grid-box">
              <div class="uk-card-media-top">
                <div v-if="project.project_thumbnail === null" class="uk-tile uk-tile-default grid-image">
                  <div class="uk-position-top-right">
                    <div class="grid-badge">
                      <label class="uk-label">
                        <span v-if="project.project_status === 'available'">Available</span>
                        <span v-else-if="project.project_status === 'prelaunch'">Pre-Launch</span>
                        <span v-else-if="project.project_status === 'hold'">Hold</span>
                        <span v-else-if="project.project_status === 'booked'">Booked</span>
                        <span v-else>Sold</span>
                      </label>
                    </div>
                  </div>
                  <div class="uk-text-center">
                    <span uk-icon="icon: image; ratio: 3"></span>
                  </div>
                </div>
                <div v-else class="uk-inline">
                  <img :src="$root.url + '/images/banner/homepage1.jpg'" alt="">
                  <div class="uk-overlay uk-overlay-default uk-position-top">
                    <p>Top</p>
                  </div>
                </div>
              </div>
              <div class="uk-card-body uk-card-small">
                <div class="uk-margin-small uk-card-title grid-box-title">{{ project.project_name }}</div>
                <div class="uk-margin-small grid-box-lead">
                  Terakhir diubah: {{ $root.formatDate( project.created_at, 'DD MMM YYYY', 'id' ) }}
                </div>
                <div class="uk-text-truncate uk-margin-small grid-box-content">{{ project.project_description }}</div>
              </div>
              <div class="uk-position-relative uk-margin-bottom grid-box-footer">
                <div class="uk-grid-collapse" uk-grid>
                  <div class="uk-width-1-3">
                    <a @click="onPopUpModal( project )" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i class="icon ion-ios-create"></i></a>
                  </div>
                  <div class="uk-width-1-3">
                    <a @click="onDeleteProject( project.project_id )" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i class="icon ion-ios-trash"></i></a>
                  </div>
                  <div class="uk-width-1-3">
                    <a class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i class="icon ion-ios-more"></i></a>
                    <div class="grid-dropdown-nav" uk-dropdown="pos: top-right">
                      <ul class="uk-nav uk-dropdown-nav">
                        <li><a :href="$root.url + '/developer/project/detail/' + project.project_id"><span class="uk-margin-small-right" uk-icon="forward"></span> Lihat Proyek</a></li>
                        <li><a :href="$root.url + '/developer/project/gallery/' + project.project_id"><span class="uk-margin-small-right" uk-icon="image"></span> Galeri</a></li>
                        <li><a><span class="uk-margin-small-right" uk-icon="plus"></span> Tambah Unit</a></li>
                        <li><a><span class="uk-margin-small-right" uk-icon="plus"></span> Tambah Tipe Unit</a></li>
                      </ul>
                    </div>
                  </div>
                </div>
              </div>
            </div>
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
      forms: {
        isEdit: false,
        project_name: '',
        project_description: '',
        project_address: '',
        project_city: '',
        project_region: '',
        project_gmaps: '',
        project_status: 'available',
        project_id: null,
        submit: 'Tambah',
        keywords: '',
        getstatus: 'all'
      },
      files: null,
      getregion: {},
      getcity: {},
      project_list: {
        isLoading: true,
        errorMessage: null,
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null,
          path: this.$root.url + '/developer/project/list_project'
        }
      },
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    onPopUpModal( data )
    {
      if( data === undefined )
      {
        this.forms.project_name = '';
        this.forms.project_description = '';
        this.forms.project_address = '';
        this.forms.project_city = '';
        this.forms.project_region = '';
        this.forms.project_gmaps = '';
        this.forms.project_status = 'available';
        this.forms.project_id = null;
        this.forms.isEdit = false;
        this.forms.submit = 'Tambah';
      }
      else
      {
        this.forms.project_name = data.project_name;
        this.forms.project_description = data.project_description;
        this.forms.project_address = data.project_address;
        this.forms.project_city = data.project_city;
        this.forms.project_region = data.project_region;
        this.forms.project_gmaps = data.project_gmaps;
        this.forms.project_status = data.project_status;
        this.forms.project_id = data.project_id;
        this.forms.isEdit = true;
        this.forms.submit = 'Simpan';
      }
      this.getRegionData();
      UIkit.modal('#modal-proyek').show();
    },
    getRegionData()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/provinsi/all'
      }).then( res => {
        let results = res.data;
        this.getregion = results.results.data
        this.getCityData();
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getCityData()
    {
      var region = 0;
      if( this.forms.project_region !== '' ) region = this.forms.project_region;
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/kabupaten/all/' + region
      }).then( res => {
        let results = res.data;
        this.getcity = results.results.data.kabupaten;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onAddOrSaveProject()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      let url = '';
      let method = 'post';

      if( this.forms.project_name === '' )
      {
        this.errors.name.project_name = 'Silahkan isi nama proyek';
        this.errors.iserror = true;
      }
      if( this.forms.project_region === '' )
      {
        this.errors.name.project_region = 'Silahkan pilih provinsi';
        this.errors.iserror = true;
      }
      if( this.forms.project_city === '' )
      {
        this.errors.name.project_city = 'Silahkan pilih kota';
        this.errors.iserror = true;
      }
      if( this.forms.project_address === '' )
      {
        this.errors.name.project_address = 'Silahkan isi alamat';
        this.errors.iserror = true;
      }
      if( this.forms.project_description === '' )
      {
        this.errors.name.project_description = 'Silahkan isi deskripsi proyek';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      if( this.forms.project_id === null ) {
        url = this.$root.url + '/developer/project/add_project';
        method: 'post';
      }
      else {
        url = this.$root.url + '/developer/project/save_project/' + this.forms.project_id;
        method = 'put';
      }

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: method,
        url: url,
        params: {
          project_name: this.forms.project_name,
          project_region: this.forms.project_region,
          project_city: this.forms.project_city,
          project_address: this.forms.project_address,
          project_description: this.forms.project_description,
          project_status: this.forms.project_status,
          project_gmaps: this.forms.project_gmaps
        }
      }).then( res => {
        let result = res.data;
        swal({
          title: 'Sukses',
          text: this.forms.isEdit === false ? 'Proyek baru berhasil ditambah' : 'Proyek berhasil diubah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getProjectList();
          UIkit.modal('#modal-proyek').hide();
        }, 2000);
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getProjectList( p )
    {
      this.project_list.isLoading = true;
      var paramurl = 'keywords=' + this.forms.keywords + '&status=' + this.forms.getstatus;
      var url = this.project_list.pagination.path + '?page=' + this.project_list.pagination.current_page + '&' + paramurl;
      if( p !== undefined ) url = p + '&' + paramurl;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.project_list.results = result.results.data;
        this.project_list.total = result.results.total;
        this.project_list.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url,
          path: result.results.path
        };
        this.project_list.isLoading = false;
      }).catch( err => {
        this.project_list.errorMessage = err.response.statusText;
      });
    },
    onDeleteProject( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus proyek ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal',
          confirm: { text: 'Ya', value: true }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/developer/project/delete_project/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Proyek berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => {
              this.getProjectList();
            }, 2000);
          });
        }
      });
    }
  },
  mounted() {
    this.getProjectList();
  }
}
</script>

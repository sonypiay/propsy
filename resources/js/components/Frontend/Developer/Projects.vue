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
      <a class="uk-button uk-button-primary uk-margin dash-btn" @click="onPopUpModal()">Tambah Proyek</a>
      <div class="uk-grid-small uk-grid-match" uk-grid>
        <div class="uk-width-1-3">
          <div class="uk-card uk-card-default dash-grid-box">
            <div class="uk-card-media-top">
              <img :src="$root.url + '/images/banner/homepage1.jpg'" alt="">
            </div>
            <div class="uk-card-body uk-card-small">
              <div class="uk-margin-small uk-card-title grid-box-title">Project Meikarta, Karawang</div>
              <div class="uk-margin-small grid-box-lead">
                12 Jun, 2019
              </div>
              <div class="uk-text-truncate uk-margin-small grid-box-content">
                Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.
              </div>
            </div>
            <div class="uk-position-relative uk-margin-bottom grid-box-footer">
              <div class="uk-grid-collapse" uk-grid>
                <div class="uk-width-1-3">
                  <a class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i class="icon ion-ios-create"></i></a>
                </div>
                <div class="uk-width-1-3">
                  <a class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i class="icon ion-ios-trash"></i></a>
                </div>
                <div class="uk-width-1-3">
                  <a class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i class="icon ion-ios-more"></i></a>
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
        submit: 'Tambah'
      },
      files: null,
      getregion: {},
      getcity: {},
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    onSelectFile( event )
    {
      this.forms.project_thumbnail = '';
      this.files = null;

      if( event.target.files.length !== 0 )
      {
        this.forms.project_thumbnail = event.target.files[0];
        this.files = URL.createObjectURL( this.forms.project_thumbnail );
      }
    },
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

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'post',
        url: this.$root.url + '/developer/project/add_project',
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
          text: 'Proyek baru berhasil ditambah',
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
    getProjectList()
    {

    }
  },
  mounted() {
    this.getRegionData();
  }
}
</script>

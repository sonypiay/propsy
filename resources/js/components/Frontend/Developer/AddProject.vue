<template>
  <div>
    <div class="uk-card dashboard-content">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/developer/project/dashboard'">Dashboard</a></li>
        <li><a :href="$root.url + '/developer/project/manage_project'">Kelola Proyek</a></li>
        <li><span>Tambah Proyek</span></li>
      </ul>
      <div class="uk-card-title uk-margin dashboard-content-heading">Tambah Proyek Baru</div>
      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <form class="uk-form-stacked" @submit.prevent="onAddProject">
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Nama Proyek <span v-html="formRequired"></span> </label>
          <div class="uk-form-controls">
            <input type="text" class="uk-input dash-form-input" v-model="forms.project_name">
          </div>
          <div v-show="errors.name.project_name" class="uk-text-small uk-text-danger">{{ errors.name.project_name }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Tipe Proyek</label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.project_type">
              <option value="residensial">Residensial</option>
              <option value="apartemen">Apartemen</option>
            </select>
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Provinsi <span v-html="formRequired"></span></label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.project_region" @change="getCityData()">
              <option value="">-- Pilih --</option>
              <option v-for="reg in getregion" :value="reg.province_id">{{ reg.province_name }}</option>
            </select>
          </div>
          <div v-show="errors.name.project_region" class="uk-text-small uk-text-danger">{{ errors.name.project_region }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Kota <span v-html="formRequired"></span></label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.project_city">
              <option value="">-- Pilih --</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <div v-show="errors.name.project_city" class="uk-text-small uk-text-danger">{{ errors.name.project_city }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Lokasi <span v-html="formRequired"></span> </label>
          <div class="uk-form-controls">
            <textarea class="uk-textarea uk-height-small dash-form-input" v-model="forms.project_address"></textarea>
          </div>
          <div v-show="errors.name.project_address" class="uk-text-small uk-text-danger">{{ errors.name.project_address }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Deskripsi Proyek <span v-html="formRequired"></span></label>
          <div class="uk-form-controls">
            <div class="uk-height-large">
              <quill-editor
                v-model="forms.project_description"
                :options="forms.editor" />
            </div>
          </div>
          <div v-show="errors.name.project_description" class="uk-text-small uk-text-danger">{{ errors.name.project_description }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Link Maps</label>
          <div class="uk-form-controls">
            <input type="text" class="uk-input dash-form-input" v-model="forms.project_link_map">
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Map Embed</label>
          <div class="uk-form-controls">
            <input type="text" class="uk-input dash-form-input" v-model="forms.project_map_embed">
          </div>
          <a class="uk-text-small" target="_blank" href="https://support.google.com/maps/answer/144361?co=GENIE.Platform%3DDesktop&hl=en">Buka Bantuan Google</a>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Thumbnail</label>
          <div class="uk-form-controls">
            <div class="uk-placeholder uk-text-center">
              <div uk-form-custom>
                <span uk-icon="icon: cloud-upload"></span>
                <span class="uk-text-middle">Attach binaries by dropping them here or</span>
                <input type="file" id="selectedThumbnail" @change="selectedThumbnail" accept="image/*">
                <span class="uk-link uk-text-middle">selecting one</span>
              </div>
            </div>
            <div v-show="forms.project_thumbnail.url !== null" class="uk-margin uk-width-1-2 uk-inline-clip uk-transition-toggle">
              <img class="uk-width-1-1" :src="forms.project_thumbnail.url" alt="">
              <div class="uk-transition-fade uk-position-cover uk-overlay uk-overlay-primary uk-flex uk-flex-center uk-flex-middle">
                <a @click="deleteThumbnail()" class="uk-link">
                  <span uk-icon="close"></span> Hapus
                </a>
              </div>
            </div>
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Status Proyek</label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.project_status">
              <option value="available">Tersedia</option>
              <option value="sold">Terjual</option>
              <option value="soon">Segera</option>
            </select>
          </div>
        </div>
        <div v-show="forms.project_status === 'soon'" class="uk-margin">
          <label class="uk-form-label dash-form-label">Estimasi Launching</label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.project_estimate_launch">
              <option v-for="year in years" :value="year">{{ year }}</option>
            </select>
          </div>
        </div>
        <div class="uk-margin">
          <button class="uk-button uk-button-primary dash-btn" v-html="forms.submit"></button>
          <a :href="$root.url + '/developer/manage_project'" class="uk-button uk-button-primary dash-btn dash-btn-cancel">Batal</a>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import 'quill/dist/quill.core.css';
import 'quill/dist/quill.snow.css';
import 'quill/dist/quill.bubble.css';
import { quillEditor } from 'vue-quill-editor';

export default {
  props: ['session_user'],
  components: {
    quillEditor
  },
  data() {
    return {
      forms: {
        project_name: '',
        project_description: '',
        project_address: '',
        project_region: '',
        project_city: '',
        project_link_map: '',
        project_map_embed: '',
        project_status: 'available',
        project_status: 'available',
        project_type: 'residensial',
        project_estimate_launch: new Date().getFullYear(),
        project_thumbnail: {
          url: null,
          data: null
        },
        submit: 'Tambah Proyek',
        editor: {
          modules: {
            toolbar: [
              ['bold', 'italic', 'underline', 'strike'],
              ['blockquote', 'code-block'],
              [{ 'header': 1 }, { 'header': 2 }],
              [{ 'list': 'ordered' }, { 'list': 'bullet' }],
              [{ 'script': 'sub' }, { 'script': 'super' }],
              [{ 'indent': '-1' }, { 'indent': '+1' }],
              [{ 'direction': 'rtl' }],
              [{ 'size': ['small', false, 'large', 'huge'] }],
              [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
              [{ 'font': [] }],
              [{ 'color': [] }, { 'background': [] }],
              [{ 'align': [] }],
              ['clean'],
              ['link', 'image', 'video']
            ]
          },
          theme: 'snow',
          placeholder: 'Deskripsi proyek...'
        }
      },
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      },
      getregion: {},
      getcity: {},
      formRequired: '<span class="uk-text-danger">*</span>'
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
        url: this.$root.url + '/api/region/kota/all/' + region
      }).then( res => {
        let results = res.data;
        this.getcity = results.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    selectedThumbnail( event )
    {
      var targetFile = event.target.files;
      this.forms.project_thumbnail.url = null;
      this.forms.project_thumbnail.data = null;
      if( targetFile.length !== 0 )
      {
        this.forms.project_thumbnail.url = URL.createObjectURL( targetFile[0] );
        this.forms.project_thumbnail.data = targetFile[0];
      }
    },
    deleteThumbnail()
    {
      this.forms.project_thumbnail = {
        url: null,
        data: null
      };
      $("#selectedThumbnail").val('');
    },
    onAddProject()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.project_name === '' )
      {
        this.errors.name.project_name = 'Silakan masukkan nama proyek';
        this.errors.iserror = true;
      }
      if( this.forms.project_region === '' )
      {
        this.errors.name.project_region = 'Silakan pilih provinsi';
        this.errors.iserror = true;
      }
      if( this.forms.project_city === '' )
      {
        this.errors.name.project_city = 'Silakan pilih kota';
        this.errors.iserror = true;
      }
      if( this.forms.project_address === '' )
      {
        this.errors.name.project_address = 'Silakan masukkan alamat proyek';
        this.errors.iserror = true;
      }
      if( this.forms.project_description === '' )
      {
        this.errors.name.project_description = 'Silakan masukkan deskripsi proyek';
        this.errors.iserror = true;
      }

      if( this.errors.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      let fd = new FormData();
      let project_thumbnail = this.forms.project_thumbnail.data !== null ? this.forms.project_thumbnail.data : '';
      let project_estimate_launch = this.forms.project_status === 'soon' ? this.forms.project_estimate_launch : '';

      fd.append('project_name', this.forms.project_name);
      fd.append('project_city', this.forms.project_city);
      fd.append('project_description', this.forms.project_description);
      fd.append('project_link_map', this.forms.project_link_map);
      fd.append('project_map_embed', this.forms.project_map_embed);
      fd.append('project_status', this.forms.project_status);
      fd.append('project_type', this.forms.project_type);
      fd.append('project_address', this.forms.project_address);
      fd.append('project_thumbnail', project_thumbnail);
      fd.append('project_estimate_launch', project_estimate_launch);

      axios.post( this.$root.url + '/developer/project/add_project', fd).then( res => {
        swal({
          title: 'Sukses',
          text: 'Proyek baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          document.location = this.$root.url + '/developer/project/manage_project';
        }, 2000);
      }).catch( err => {
        swal({
          title: 'Whoops',
          text: 'Terjadi kesalahan',
          icon: 'warning',
          dangerMode: true
        });
        this.forms.submit = 'Tambah Proyek';
      });
    }
  },
  computed: {
    years() {
      const now = new Date().getFullYear();
      let nextYear = [];
      for( let i = now; i < (now + 25); i++ )
      {
        nextYear.push(i);
      }
      return nextYear;
    }
  },
  mounted() {
    this.getRegionData();
  }
}
</script>

<style lang="scss" scoped>
  .quill-editor,
  .quill-code {
    height: 350px;
  }
  .quill-code {
    border: none;
    height: auto;
    > code {
      width: 100%;
      margin: 0;
      padding: 1rem;
      border: 1px solid #ccc;
      border-radius: 0;
      height: 10rem;
      overflow-y: auto;
    }
  }
</style>

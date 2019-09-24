<template>
  <div>
    <div class="uk-card dashboard-content">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/developer/project/dashboard'">Dashboard</a></li>
        <li><a :href="$root.url + '/developer/project/manage_project'">Kelola Proyek</a></li>
        <li><a :href="$root.url + '/developer/project/detail/' + getproject.project_unique_id">{{ getproject.project_name }}</a></li>
        <li><span>Tambah Unit</span></li>
      </ul>
      <div class="uk-card-title uk-margin dashboard-content-heading">Tambah Unit Baru</div>
      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <form class="uk-form-stacked uk-grid-small" @submit.prevent="onAddUnit" uk-grid>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Nama Tipe <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="text" class="uk-input dash-form-input" v-model="forms.unit_name">
          </div>
          <div v-show="errors.name.unit_name" class="uk-text-danger uk-text-small">{{ errors.name.unit_name }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Jumlah Lantai <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_floor">
          </div>
          <div v-show="errors.name.unit_floor" class="uk-text-danger uk-text-small">{{ errors.name.unit_floor }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Kamar Tidur <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_kt">
          </div>
          <div v-show="errors.name.unit_kt" class="uk-text-danger uk-text-small">{{ errors.name.unit_kt }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Kamar Mandi <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_km">
          </div>
          <div v-show="errors.name.unit_km" class="uk-text-danger uk-text-small">{{ errors.name.unit_km }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Luas Lahan <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_lt" uk-tooltip="m2">
          </div>
          <div v-show="errors.name.unit_lt" class="uk-text-danger uk-text-small">{{ errors.name.unit_lt }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Luas Bangunan <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_lb" uk-tooltip="m2">
          </div>
          <div v-show="errors.name.unit_lt" class="uk-text-danger uk-text-small">{{ errors.name.unit_lb }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Harga <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_price">
          </div>
          <div v-show="errors.name.unit_price" class="uk-text-danger uk-text-small">{{ errors.name.unit_price }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Kapasitas Watt <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <input type="number" class="uk-input dash-form-input" v-model="forms.unit_watt">
          </div>
          <div v-show="errors.name.unit_watt" class="uk-text-danger uk-text-small">{{ errors.name.unit_watt }}</div>
        </div>
        <div class="uk-width-1-3">
          <label class="uk-form-label dash-form-label">Status <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.unit_status">
              <option value="available">Tersedia</option>
              <option value="sold">Terjual</option>
            </select>
          </div>
        </div>
        <div class="uk-width-1-1">
          <label class="uk-form-label dash-form-label">Fasilitas <span v-html="forms.formrequired"></span></label>
          <div class="uk-form-controls">
            <div class="uk-grid-small uk-child-width-auto" uk-grid>
              <div v-for="fas in getfacility">
                <label class="uk-text-small">
                  <input type="checkbox" class="uk-checkbox" v-model="forms.unit_facility" :value="fas.value" />
                  <span class="uk-margin-small-left">{{ fas.value }}</span>
                </label>
              </div>
            </div>
          </div>
          <div v-show="errors.name.unit_facility" class="uk-text-danger uk-text-small">{{ errors.name.unit_facility }}</div>
        </div>
        <div class="uk-width-1-1">
          <label class="uk-form-label dash-form-label">Deskripsi Unit <span v-html="forms.formrequired"></span></label>
          <div class="uk-height-large">
            <quill-editor
              v-model="forms.unit_description"
              :options="forms.editor" />
          </div>
          <div v-show="errors.name.unit_description" class="uk-text-danger uk-text-small">{{ errors.name.unit_description }}</div>
        </div>
        <div class="uk-width-1-1">
          <button class="uk-button uk-button-primary dash-btn" v-html="forms.submit"></button>
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
  props: ['session_user', 'getproject', 'getfacility'],
  components: {
    quillEditor
  },
  data() {
    return {
      forms: {
        unit_name: '',
        unit_description: '',
        unit_status: 'available',
        unit_watt: '',
        unit_facility: [],
        unit_floor: '',
        unit_lb: '',
        unit_lt: '',
        unit_kt: '',
        unit_km: '',
        unit_price: 0,
        submit: 'Tambah Unit',
        formrequired: '<span class="uk-text-small uk-text-danger">*</span>',
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
          placeholder: 'Deskripsi unit...'
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
    onAddUnit()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.unit_name === '' )
      {
        this.errors.name.unit_name = 'Nama unit harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_floor < 1 || this.forms.unit_floor === '' )
      {
        this.errors.name.unit_floor = 'Jumlah lantai harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_kt < 1 || this.forms.unit_kt === '' )
      {
        this.errors.name.unit_kt = 'Jumlah kamar tidur harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_km < 1 || this.forms.unit_km === '' )
      {
        this.errors.name.unit_km = 'Jumlah kamar mandi harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_lt < 1 || this.forms.unit_lt === '' )
      {
        this.errors.name.unit_lt = 'Luas lahan harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_lb < 1 || this.forms.unit_lb === '' )
      {
        this.errors.name.unit_lb = 'Luas bangunan harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_price < 1 || this.forms.unit_price === '' )
      {
        this.errors.name.unit_price = 'Harga harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_watt < 1 || this.forms.unit_watt === '' )
      {
        this.errors.name.unit_watt = 'Watt harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_facility.length === 0 )
      {
        this.errors.name.unit_facility = 'Fasilitas harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_description === '' )
      {
        this.errors.name.unit_description = 'Deskripsi unit harap diisi';
        this.errors.iserror = true;
      }

      if( this.errors.iserror === true ) return false;

      axios({
        method: 'post',
        url: this.$root.url + '/developer/project/add_unit_tipe/' + this.getproject.project_unique_id,
        params: {
          unit_name: this.forms.unit_name,
          unit_description: this.forms.unit_description,
          unit_floor: this.forms.unit_floor,
          unit_lb: this.forms.unit_lb,
          unit_lt: this.forms.unit_lt,
          unit_kt: this.forms.unit_kt,
          unit_km: this.forms.unit_km,
          unit_status: this.forms.unit_status,
          unit_watt: this.forms.unit_watt,
          unit_facility: this.forms.unit_facility,
          unit_price: this.forms.unit_price
        }
      }).then( res => {
        let result = res.data;
        swal({
          title: 'Sukses',
          text: 'Unit baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getProjectUnitType();
          UIkit.modal('#modal-tipe-unit').hide();
        }, 2000);
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
    }
  },
  mounted() {

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

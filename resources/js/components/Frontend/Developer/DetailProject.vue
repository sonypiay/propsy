<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">
        {{ getproject.project_name }}
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ getproject.province_name }},
        {{ getproject.city_name }}<br>
        {{ getproject.project_address }}
        <div v-show="getproject.project_map_embed"></div>
      </div>

      <div id="modal-view-gallery" class="uk-modal-full" uk-modal>
        <div class="uk-modal-dialog uk-modal-body uk-height-viewport">
          <a class="uk-modal-close-large uk-modal-close" uk-close></a>
          <h3>Galeri Proyek</h3>
          <div class="uk-grid-small uk-margin" uk-grid="masonry: true" uk-lightbox>
            <div v-for="gallery in galleries.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-2@s">
              <a class="uk-display-block" :href="$root.url + '/images/project/gallery/' + gallery.gallery_filename">
                <img :src="$root.url + '/images/project/gallery/' + gallery.gallery_filename">
              </a>
            </div>
          </div>
        </div>
      </div>
      <div class="uk-card-title uk-margin dashboard-content-heading">
        Deskripsi Proyek
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ getproject.project_description }} <br>
        <a class="uk-button uk-button-primary uk-margin-small-top dash-btn" uk-toggle="target: #modal-view-gallery">Lihat Galeri</a>
      </div>

      <!-- Unit -->
      <!-- modal tambah unit -->
      <div id="modal-tipe-unit" class="uk-modal-full" uk-modal>
        <div class="uk-modal-dialog modal-form">
          <a class="uk-modal-close-default uk-modal-close" uk-close></a>
          <div class="uk-modal-body uk-height-viewport">
            <div class="uk-width-3-4@xl uk-width-3-4@l uk-width-2-3@m uk-width-1-2@s uk-align-center uk-margin-top">
              <h3 class="modal-form-heading">
                <span>Tambah Tipe Unit</span>
              </h3>
              <form class="uk-form-stacked uk-grid-small" @submit.prevent="onAddOrSaveUnitType" uk-grid>
                <div class="uk-width-1-3">
                  <label class="uk-form-label modal-label">Nama Tipe <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <input type="text" class="uk-input modal-input" v-model="forms.unit_tipe.unit_name">
                  </div>
                  <div v-show="errors.name.unit_name" class="uk-text-danger uk-text-small">{{ errors.name.unit_name }}</div>
                </div>
                <div class="uk-width-1-3">
                  <label class="uk-form-label modal-label">Jumlah Lantai <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_name">
                  </div>
                  <div v-show="errors.name.unit_name" class="uk-text-danger uk-text-small">{{ errors.name.unit_name }}</div>
                </div>
                <div class="uk-width-1-3">
                  <label class="uk-form-label modal-label">Jumlah Kamar Tidur <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_kt">
                  </div>
                  <div v-show="errors.name.unit_kt" class="uk-text-danger uk-text-small">{{ errors.name.unit_kt }}</div>
                </div>
                <div class="uk-width-1-3">
                  <label class="uk-form-label modal-label">Jumlah Kamar Mandi <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_km">
                  </div>
                  <div v-show="errors.name.unit_km" class="uk-text-danger uk-text-small">{{ errors.name.unit_km }}</div>
                </div>
                <div class="uk-width-1-3">
                  <label class="uk-form-label modal-label">Harga <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_price">
                  </div>
                  <div v-show="errors.name.unit_price" class="uk-text-danger uk-text-small">{{ errors.name.unit_price }}</div>
                </div>
                <div class="uk-width-1-3">
                  <label class="uk-form-label modal-label">Watt <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_price">
                  </div>
                  <div v-show="errors.name.unit_price" class="uk-text-danger uk-text-small">{{ errors.name.unit_price }}</div>
                </div>
                <div class="uk-width-1-1">
                  <label class="uk-form-label modal-label">Fasilitas <span v-html="forms.formrequired"></span></label>
                  <div class="uk-form-controls">
                    <tags-input element-id="tags"
                    v-model="forms.unit_tipe.unit_facility"
                    :existing-tags="getfacility"
                    :add-tags-on-comma="true"
                    :only-existing-tags="true"
                    :typeahead="true"
                    placeholder="Masukkan kata kunci..."
                     />
                  </div>
                  <div v-show="errors.name.unit_facility" class="uk-text-danger uk-text-small">{{ errors.name.unit_facility }}</div>
                </div>
                <div class="uk-width-1-1">
                  <div class="uk-height-large">
                    <quill-editor
                      v-model="forms.unit_tipe.unit_description"
                      :options="forms.editor" />
                  </div>
                </div>
                <div class="uk-width-1-1">
                  <button class="uk-button uk-button-primary modal-form-add" v-html="forms.unit_tipe.submit"></button>
                </div>
              </form>
            </div>
          </div>
        </div>
      </div>
      <!-- modal tambah unit -->

      <div class="uk-card-title uk-margin dashboard-content-heading">
        Unit Proyek
      </div>
      <div class="uk-margin">
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn">{{ project_unit_tipe.total }} Unit</a>
          </div>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn" @click="onPopupUnit()">Tambah Unit</a>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="icon: search; ratio: 0.7"></span>
              <input type="search" class="uk-input uk-form-small dash-form-input" v-model="forms.keywords" @keyup.enter="">
            </div>
          </div>
        </div>
        <div v-if="project_unit_tipe.isLoading === true" class="uk-text-center">
          <span uk-spinner></span>
        </div>
        <div v-else>
          <div v-show="project_unit_tipe.errorMessage" class="uk-alert-danger" uk-alert>
            {{ project_unit_tipe.errorMessage }}
          </div>
          <div v-if="project_unit_tipe.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada unit yang ditambahkan
          </div>
          <div v-else class="uk-margin">
            <table class="uk-table uk-table-middle uk-table-hover uk-table-divider uk-table-striped uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Blok / Prefix</th>
                  <th>Jumlah Tipe</th>
                  <th>Harga</th>
                  <th>Terakhir diubah</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="project_unit_tipe.pagination.prev_page_url" @click="" uk-pagination-previous></a>
                <a v-else uk-pagination-previous></a>
              </li>
              <li>
                <a v-if="project_unit_tipe.pagination.next_page_url" @click="" uk-pagination-next></a>
                <a v-else uk-pagination-next></a>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <!-- Unit -->
    </div>
  </div>
</template>

<script>
import VoerroTagsInput from '@voerro/vue-tagsinput';
import 'quill/dist/quill.core.css';
import 'quill/dist/quill.snow.css';
import 'quill/dist/quill.bubble.css';
import { quillEditor } from 'vue-quill-editor';

export default {
  props: ['session_user', 'getproject', 'getfacility'],
  components: {
    'tags-input': VoerroTagsInput,
    quillEditor
  },
  data() {
    return {
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      },
      galleries: {
        isLoading: false,
        total: 0,
        results: []
      },
      project_unit_tipe: {
        isLoading: false,
        total: 0,
        results: [],
        errorMessage: '',
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null,
          path: this.$root.url + '/developer/project/get_unit_tipe'
        }
      },
      forms: {
        keywords: '',
        formrequired: '<span class="uk-text-small uk-text-danger">*</span>',
        unit_tipe: {
          unit_name: '',
          unit_description: 'This is a text',
          unit_status: '',
          unit_watt: '',
          unit_facility: [],
          unit_floor: 1,
          unit_lb: 0,
          unit_lt: 0,
          unit_kt: 1,
          unit_km: 1,
          unit_price: 0,
          unit_tipe_id: null,
          submit: 'Tambah',
          isEdit: false,
          isToggle: false
        },
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
          }
        }
      }
    }
  },
  methods: {
    getGalleries()
    {
      this.galleries.isLoading = true;
      axios({
        method: 'get',
        url: this.$root.url + '/developer/project/data_gallery/' + this.getproject.project_unique_id
      }).then( res => {
        let result = res.data;
        this.galleries.total = result.data.total;
        this.galleries.results = result.data.row;
        this.galleries.isLoading = false;
      }).catch( err => {
        this.galleries.errorMessage = err.response.statusText;
      });
    },
    getProjectUnitType( p )
    {
      this.project_unit_tipe.isLoading = true;
      var url = this.$root.url + '/developer/project/get_unit_tipe/' + this.projects.project_unique_id + '?page=' + this.project_unit_tipe.pagination.current_page;
      if( p !== undefined ) url = p;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.project_unit_tipe.total = result.total;
        this.project_unit_tipe.results = result.data;
        this.project_unit_tipe.pagination = {
          current_page: result.current_page,
          last_page: result.last_page,
          prev_page_url: result.prev_page_url,
          next_page_url: result.next_page_url,
          path: result.path
        };
        this.project_unit_tipe.isLoading = false;
      }).catch( err => {
        this.project_unit_tipe.errorMessage = err.response.statusText;
      });
    },
    onPopupUnit( data )
    {
      if( data === undefined )
      {
        this.forms.unit_tipe.unit_name = '';
        this.forms.unit_tipe.unit_floor = 0;
        this.forms.unit_tipe.unit_lb = 0;
        this.forms.unit_tipe.unit_lt = 0;
        this.forms.unit_tipe.unit_kt = 0;
        this.forms.unit_tipe.unit_km = 0;
        this.forms.unit_tipe.unit_price = 0;
        this.forms.unit_tipe.description = 0;
        this.forms.unit_tipe.unit_status = 'available';
        this.forms.unit_tipe.unit_watt = 0;
        this.forms.unit_tipe.unit_facility = [];
        this.forms.unit_tipe.isEdit = false;
        this.forms.unit_tipe.submit = 'Tambah Unit';
      }
      else
      {
        this.forms.unit_tipe.unit_name = '';
        this.forms.unit_tipe.unit_floor = 0;
        this.forms.unit_tipe.unit_lb = 0;
        this.forms.unit_tipe.unit_lt = 0;
        this.forms.unit_tipe.unit_kt = 0;
        this.forms.unit_tipe.unit_km = 0;
        this.forms.unit_tipe.unit_price = 0;
        this.forms.unit_tipe.description = 0;
        this.forms.unit_tipe.unit_status = 'available';
        this.forms.unit_tipe.unit_watt = 0;
        this.forms.unit_tipe.unit_facility = [];
        this.forms.unit_tipe.isEdit = false;
        this.forms.unit_tipe.submit = 'Edit Unit';
      }

      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      UIkit.modal('#modal-tipe-unit').show();
    },
    onAddOrSaveUnitType()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      console.log( this.forms.unit_tipe.unit_description );
    },
    onDeleteUnitType( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus unit ini?',
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
            url: this.$root.url + '/developer/project/delete_unit_tipe/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Unit proyek berhasil dihapus',
              icon: 'success'
            });
          });
        }
      });
    },
    onEditorBlur(editor) {
      console.log('editor blur!', editor)
    },
    onEditorFocus(editor) {
      console.log('editor focus!', editor)
    },
    onEditorReady(editor) {
      console.log('editor ready!', editor)
    }
  },
  mounted() {
    this.getGalleries();
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

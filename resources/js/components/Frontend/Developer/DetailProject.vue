<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">
        {{ projects.project_name }}
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ getarea.provinsi.area_name }},
        {{ getarea.kota.area_name }}<br>
        {{ projects.project_address }}
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
        {{ projects.project_description }} <br>
        <a class="uk-button uk-button-primary dash-btn" uk-toggle="target: #modal-view-gallery">Lihat Galeri</a>
      </div>

      <!-- Unit -->
      <!-- modal tambah unit -->
      <div id="modal-add-unit" uk-modal>
        <div class="uk-modal-dialog uk-modal-body modal-form">
          <a class="uk-modal-close-default uk-modal-close" uk-close></a>
          <h3 class="modal-form-heading">
            <span v-if="forms.unit.isEdit">Ubah Unit</span>
            <span v-else>Tambah Unit</span>
          </h3>
          <form class="uk-form-stacked" @submit.prevent="onAddOrSaveUnit">
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Blok / Prefix</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.unit.unit_name" placeholder="Contoh: Blok A">
              </div>
              <div v-show="errors.name.unit_name" class="uk-text-danger uk-text-small">{{ errors.name.unit_name }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Nomor Blok / Prefix</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit.unit_number">
              </div>
              <div v-show="errors.name.unit_number" class="uk-text-danger uk-text-small">{{ errors.name.unit_number }}</div>
            </div>
            <div class="uk-margin">
              <button class="uk-button uk-button-primary modal-form-add" v-html="forms.unit.submit"></button>
            </div>
          </form>
        </div>
      </div>
      <!-- modal tambah unit -->

      <!-- modal tambah tipe unit -->
      <div id="modal-add-unit-tipe" uk-modal>
        <div class="uk-modal-dialog uk-modal-body modal-form">
          <a class="uk-modal-close-default uk-modal-close" uk-close></a>
          <h3 class="modal-form-heading">
            <span v-if="forms.unit_tipe.isEdit">Ubah Tipe Unit</span>
            <span>Tambah Tipe Unit</span>
          </h3>
          <form class="uk-form-stacked" @submit.prevent="onAddOrSaveUnitType">
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Blok / Prefix</label>
              <div class="uk-form-controls">
                <input type="text" class="uk-input modal-input" v-model="forms.unit_tipe.project_unit.unit_name + ' No .' + this.forms.unit_tipe.project_unit.unit_number" disabled>
              </div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Jumlah Lantai</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_floor">
              </div>
              <div v-show="errors.name.unit_floor" class="uk-text-danger uk-text-small">{{ errors.name.unit_floor }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Jumlah Kamar Tidur</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_kt">
              </div>
              <div v-show="errors.name.unit_kt" class="uk-text-danger uk-text-small">{{ errors.name.unit_kt }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Jumlah Kamar Mandi</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_km">
              </div>
              <div v-show="errors.name.unit_km" class="uk-text-danger uk-text-small">{{ errors.name.unit_km }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Luas Bangunan</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_lb">
              </div>
              <div v-show="errors.name.unit_lb" class="uk-text-danger uk-text-small">{{ errors.name.unit_lb }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Luas Tanah</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_lt">
              </div>
              <div v-show="errors.name.unit_lt" class="uk-text-danger uk-text-small">{{ errors.name.unit_lt }}</div>
            </div>
            <div class="uk-margin">
              <label class="uk-form-label modal-label">Harga</label>
              <div class="uk-form-controls">
                <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_price">
              </div>
              <div v-show="errors.name.unit_price" class="uk-text-danger uk-text-small">{{ errors.name.unit_price }}</div>
            </div>
            <div class="uk-margin">
              <button class="uk-button uk-button-primary modal-form-add" v-html="forms.unit.submit"></button>
            </div>
          </form>
        </div>
      </div>
      <!-- modal tambah tipe unit -->
      <div class="uk-card-title uk-margin dashboard-content-heading">
        Unit Proyek
      </div>
      <div class="uk-margin">
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn">{{ project_unit.total }} Unit</a>
          </div>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn" @click="onPopupUnit()">Tambah Unit</a>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="icon: search; ratio: 0.7"></span>
              <input type="search" class="uk-input uk-form-small dash-form-input" v-model="forms.keywords" @keyup.enter="getProjectUnit()">
            </div>
          </div>
        </div>
        <div v-if="project_unit.isLoading === true" class="uk-text-center">
          <span uk-spinner></span>
        </div>
        <div v-else>
          <div v-show="project_unit.errorMessage" class="uk-alert-danger" uk-alert>
            {{ project_unit.errorMessage }}
          </div>
          <div v-if="project_unit.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada unit yang ditambahkan
          </div>
          <div v-else class="uk-margin">
            <table class="uk-table uk-table-middle uk-table-hover uk-table-divider uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Blok / Prefix</th>
                  <th>Jumlah Tipe</th>
                  <th>Terakhir diubah</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="unit in project_unit.results">
                  <td class="uk-width-small">
                    <div class="uk-inline">
                      <a class="uk-button uk-button-primary uk-button-small dash-btn" @click=""><span uk-icon="icon: more-vertical; ratio: 0.5"></span></a>
                      <div class="tb-dropdown-nav" uk-dropdown="pos: right; mode: click">
                        <ul class="uk-nav uk-dropdown-nav">
                          <li><a @click="onPopupUnit( unit )"><span class="uk-margin-small-right" uk-icon="pencil"></span> Ubah Unit</a></li>
                          <li><a @click="onDeleteUnit( unit.project_unit_id )"><span class="uk-margin-small-right" uk-icon="trash"></span> Hapus</a></li>
                          <li><a @click="onPopupUnitType({
                              unit_id: unit.project_unit_id,
                              unit_name: unit.project_unit_name,
                              unit_number: unit.project_unit_number
                            })">
                            <span class="uk-margin-small-right" uk-icon="plus"></span> Tambah Tipe Unit</a>
                          </li>
                        </ul>
                      </div>
                    </div>
                  </td>
                  <td>{{ unit.project_unit_name }} No. {{ unit.project_unit_number }}</td>
                  <td>0</td>
                  <td>
                    {{ $root.formatDate( unit.updated_at, 'DD MMM, YYYY HH:mm', 'id' ) }}
                  </td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a href="#" v-if="project_unit.pagination.prev_page_url" @click="getProjectUnit( project_unit.pagination.prev_page_url )" uk-pagination-previous></a>
                <a v-else uk-pagination-previous></a>
              </li>
              <li>
                <a v-if="project_unit.pagination.next_page_url" @click="getProjectUnit( project_unit.pagination.next_page_url )" uk-pagination-next></a>
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
export default {
  props: ['session_user', 'projects', 'getarea'],
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
      project_unit: {
        isLoading: false,
        total: 0,
        results: [],
        errorMessage: '',
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null,
          path: this.$root.url + '/developer/project/get_unit/' + this.projects.project_id
        }
      },
      forms: {
        keywords: '',
        unit: {
          unit_id: null,
          unit_name: '',
          unit_number: 1,
          submit: 'Tambah',
          isEdit: false
        },
        unit_tipe: {
          unit_floor: 1,
          unit_lb: 0,
          unit_lt: 0,
          unit_kt: 1,
          unit_km: 1,
          unit_price: 0,
          unit_tipe_id: null,
          project_unit: {
            unit_id: null,
            unit_name: null,
            unit_number: null
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
        url: this.$root.url + '/developer/project/data_gallery/' + this.projects.project_id
      }).then( res => {
        let result = res.data;
        this.galleries.total = result.data.total;
        this.galleries.results = result.data.row;
        this.galleries.isLoading = false;
      }).catch( err => {
        this.galleries.errorMessage = err.response.statusText;
      });
    },
    getProjectUnit( p )
    {
      this.project_unit.isLoading = true;
      var params = '&keywords=' + this.forms.keywords;
      var url = this.project_unit.pagination.path + '?page=' + this.project_unit.pagination.current_page + params;
      if( p !== undefined ) url = p + params;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.project_unit.total = result.total;
        this.project_unit.results = result.data;
        this.project_unit.pagination = {
          current_page: result.current_page,
          last_page: result.last_page,
          prev_page_url: result.prev_page_url,
          next_page_url: result.next_page_url,
          path: result.path
        };
        this.project_unit.isLoading = false;
      }).catch( err => {
        this.project_unit.errorMessage = err.response.statusText;
      });
    },
    onPopupUnit( data )
    {
      if( data === undefined )
      {
        this.forms.unit.unit_id = null;
        this.forms.unit.unit_name = '';
        this.forms.unit.unit_number = 1;
        this.forms.unit.isEdit = false;
        this.forms.unit.submit = 'Tambah';
      }
      else
      {
        this.forms.unit.unit_id = data.project_unit_id;
        this.forms.unit.unit_name = data.project_unit_name;
        this.forms.unit.unit_number = data.project_unit_number;
        this.forms.unit.isEdit = true;
        this.forms.unit.submit = 'Ubah';
      }
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      UIkit.modal('#modal-add-unit').show();
    },
    onPopupUnitType( unit, data )
    {
      this.forms.unit_tipe.project_unit = unit;
      if( data === undefined )
      {
        this.forms.unit_tipe.unit_tipe_id = null;
        this.forms.unit_tipe.unit_floor = 1;
        this.forms.unit_tipe.unit_lb = 0;
        this.forms.unit_tipe.unit_lt = 0;
        this.forms.unit_tipe.unit_kt = 1;
        this.forms.unit_tipe.unit_km = 1;
        this.forms.unit.isEdit = false;
      }
      else
      {
        this.forms.unit_tipe.unit_tipe_id = data.unit_tipe_id;
        this.forms.unit_tipe.unit_floor = data.unit_floor;
        this.forms.unit_tipe.unit_lb = data.unit_lb;
        this.forms.unit_tipe.unit_lt = data.unit_lt;
        this.forms.unit_tipe.unit_kt = data.unit_kt;
        this.forms.unit_tipe.unit_km = data.unit_km;
        this.forms.unit.isEdit = true;
      }
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      UIkit.modal('#modal-add-unit-tipe').show();
    },
    onAddOrSaveUnit()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      let url, method;

      if( this.forms.unit.unit_name === '' )
      {
        this.errors.name.unit_name = 'Nama unit harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit.unit_number < 1 || this.forms.unit.unit_number === '' )
      {
        this.errors.name.unit_number = 'Silakan masukkan minimal 1 unit';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      if( this.forms.unit.isEdit === true )
      {
        url = this.$root.url + '/developer/project/save_unit/' + this.forms.unit.unit_id;
        method = 'put';
      }
      else
      {
        url = this.$root.url + '/developer/project/add_unit/' + this.projects.project_id;
        method = 'post';
      }
      this.forms.unit.submit = '<span uk-spinner></span>';
      axios({
        method: 'post',
        url: url,
        params: {
          unit_name: this.forms.unit.unit_name,
          unit_number: this.forms.unit.unit_number
        }
      }).then( res => {
        let result = res.data;
        swal({
          title: 'Sukses',
          text: this.forms.unit.isEdit === false ? 'Unit baru berhasil ditambah' : 'Unit baru berhasil diubah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getProjectUnit();
          UIkit.modal('#modal-add-unit').hide();
        }, 2000);
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
    },
    onAddOrSaveUnitType()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.unit_tipe.unit_floor === '' )
      {
        this.errors.name.unit_floor === 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_lb === '' )
      {
        this.errors.name.unit_lb === 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_lt === '' )
      {
        this.errors.name.unit_lt === 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_kt === '' )
      {
        this.errors.name.unit_kt === 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_km === '' )
      {
        this.errors.name.unit_km === 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_price === '' )
      {
        this.errors.name.unit_price === 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;
    },
    onDeleteUnit( id )
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
            url: this.$root.url + '/developer/project/delete_unit/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Unit proyek berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => { this.getProjectUnit(); }, 2000);
          });
        }
      });
    }
  },
  mounted() {
    this.getGalleries();
    this.getProjectUnit();
  }
}
</script>

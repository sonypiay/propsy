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
        <a class="uk-button uk-button-primary uk-margin-small-top dash-btn" uk-toggle="target: #modal-view-gallery">Lihat Galeri</a>
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

      <!-- modal lihat tipe unit -->
      <div id="modal-view-unit-type" class="uk-modal-full" uk-modal="esc-close: false">
        <div class="uk-modal-dialog uk-modal-body uk-height-viewport">
          <a class="uk-modal-close-large uk-modal-close" uk-close></a>
          <div class="uk-card uk-card-body">
            <div class="uk-margin uk-card-title">Tipe Unit &amp; Harga - {{ project_unit_tipe.project_unit.unit_name + ' No. ' + project_unit_tipe.project_unit.unit_number }}</div>
            <div class="uk-margin">
              <div v-if="project_unit_tipe.isLoading === true" class="uk-text-center">
                <span uk-spinner></span>
              </div>
              <div v-else class="modal-form">
                <a @click="onToggleAddUnit( project_unit_tipe.project_unit )" class="uk-button uk-button-primary uk-button-small modal-submit">Tambah Tipe Unit</a>
                <div class="uk-margin" v-show="this.forms.unit_tipe.isToggle === true">
                  <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
                  <form class="uk-form-stacked uk-grid-small" @submit.prevent="onAddOrSaveUnitType" uk-grid>
                    <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                      <label class="uk-form-label modal-label">Luas Bangunan</label>
                      <div class="uk-form-controls">
                        <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_lb" uk-tooltip="m2">
                      </div>
                      <div v-show="errors.name.unit_lb" class="uk-text-small uk-text-danger">{{ errors.name.unit_lb }}</div>
                    </div>
                    <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                      <label class="uk-form-label modal-label">Luas Tanah</label>
                      <div class="uk-form-controls">
                        <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_lt" uk-tooltip="hektare">
                      </div>
                      <div v-show="errors.name.unit_lt" class="uk-text-small uk-text-danger">{{ errors.name.unit_lt }}</div>
                    </div>
                    <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                      <label class="uk-form-label modal-label">Jumlah Lantai</label>
                      <div class="uk-form-controls">
                        <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_floor">
                      </div>
                      <div v-show="errors.name.unit_floor" class="uk-text-small uk-text-danger">{{ errors.name.unit_floor }}</div>
                    </div>
                    <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                      <label class="uk-form-label modal-label">Jumlah Kamar Mandi</label>
                      <div class="uk-form-controls">
                        <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_km">
                      </div>
                      <div v-show="errors.name.unit_km" class="uk-text-small uk-text-danger">{{ errors.name.unit_km }}</div>
                    </div>
                    <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                      <label class="uk-form-label modal-label">Jumlah Kamar Tidur</label>
                      <div class="uk-form-controls">
                        <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_kt">
                      </div>
                      <div v-show="errors.name.unit_kt" class="uk-text-small uk-text-danger">{{ errors.name.unit_kt }}</div>
                    </div>
                    <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                      <label class="uk-form-label modal-label">Harga</label>
                      <div class="uk-form-controls">
                        <input type="number" class="uk-input modal-input" v-model="forms.unit_tipe.unit_price">
                      </div>
                      <div v-show="errors.name.unit_price" class="uk-text-small uk-text-danger">{{ errors.name.unit_price }}</div>
                    </div>
                    <div class="uk-width-1-1">
                      <button class="uk-button uk-button-primary uk-button-small modal-submit" v-html="forms.unit_tipe.submit"></button>
                      <a class="uk-button uk-button-primary uk-button-small modal-submit" @click="forms.unit_tipe.isToggle = false">Tutup</a>
                    </div>
                  </form>
                </div>
                <div v-if="project_unit_tipe.total === 0" class="uk-alert-warning" uk-alert>
                  Belum ada unit ditambahkan
                </div>
                <div v-else>
                  <div v-show="installment.isActive === true" class="uk-margin-large-top">
                    <h4>Cicilan</h4>
                    <a @click="onToggleAddInstallment( installment.project_unit_type_id )" class="uk-button uk-button-primary uk-button-small modal-submit">Tambah Cicilan</a>
                    <a @click="installment.isActive = false; installment.project_unit_type_id = null" class="uk-button uk-button-primary uk-button-small modal-submit">Tutup</a>
                    <div v-show="forms.installment.isToggle === true" class="uk-margin">
                      <form class="uk-form-stacked uk-grid-small" @submit.prevent="onAddInstallment" uk-grid>
                        <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                          <label class="uk-form-label modal-label">DP</label>
                          <div class="uk-form-controls">
                            <input type="number" class="uk-input modal-input" v-model="forms.installment.dp">
                          </div>
                          <div v-show="errors.name.dp" class="uk-text-small uk-text-danger">{{ errors.name.dp }}</div>
                        </div>
                        <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                          <label class="uk-form-label modal-label">Angsuran</label>
                          <div class="uk-form-controls">
                            <input type="number" class="uk-input modal-input" v-model="forms.installment.angsuran">
                          </div>
                          <div v-show="errors.name.angsuran" class="uk-text-small uk-text-danger">{{ errors.name.angsuran }}</div>
                        </div>
                        <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-2@s">
                          <label class="uk-form-label modal-label">Tenor (Tahun)</label>
                          <div class="uk-form-controls">
                            <input type="number" class="uk-input modal-input" v-model="forms.installment.tenor">
                          </div>
                          <div v-show="errors.name.tenor" class="uk-text-small uk-text-danger">{{ errors.name.tenor }}</div>
                        </div>
                        <div class="uk-width-1-1">
                          <button class="uk-button uk-button-primary modal-submit" v-html="forms.installment.submit"></button>
                          <a class="uk-button uk-button-primary modal-submit" @click="forms.installment.isToggle = false">Batal</a>
                        </div>
                      </form>
                    </div>
                    <div v-if="installment.total === 0" class="uk-alert-warning" uk-alert>Tidak ada cicilan yang ditambahkan</div>
                    <table v-else class="uk-table uk-table-divider uk-table-small uk-table-hover uk-table-striped uk-table-middle">
                      <thead>
                        <tr>
                          <th>Aksi</th>
                          <th>Tenor</th>
                          <th>DP</th>
                          <th>Angsuran</th>
                          <th>Jumlah Kredit</th>
                        </tr>
                      </thead>
                      <tbody>
                        <tr v-for="cicilan in installment.results">
                          <td class="uk-width-small">
                            <a @click="onToggleAddInstallment( cicilan.project_unit_type_id, cicilan )" class="uk-button uk-button-primary uk-button-small modal-submit"><i class="icon ion-ios-create"></i></a>
                            <a @click="onDeleteInstallment( cicilan.installment_id, cicilan.project_unit_type_id )" class="uk-button uk-button-primary uk-button-small modal-submit"><i class="icon ion-ios-trash"></i></a>
                          </td>
                          <td class="uk-width-small">{{ parseFloat( cicilan.installment_tenor / 12 ) }} tahun</td>
                          <td>IDR {{ $root.formatNumeral( cicilan.installment_dp, '0,0' ) }}</td>
                          <td>IDR {{ $root.formatNumeral( cicilan.installment_price, '0,0' ) }}</td>
                          <td>IDR {{ calcInstallmentCredit( cicilan.installment_dp, cicilan.installment_price, cicilan.installment_tenor ) }}</td>
                        </tr>
                      </tbody>
                    </table>
                  </div>

                  <table class="uk-table uk-table-divider uk-table-small uk-table-middle">
                    <thead>
                      <tr>
                        <th>Aksi</th>
                        <th>Cicilan</th>
                        <th>Jumlah Lantai</th>
                        <th>Luas Bangunan / Luas Tanah</th>
                        <th>Kamar Mandi / Kamar Tidur</th>
                        <th>Harga</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="unit_tipe in project_unit_tipe.results" :class="{
                        'modal-table-active': installment.project_unit_type_id === unit_tipe.project_unit_type_id
                      }">
                        <td class="uk-width-small">
                          <a @click="onToggleAddUnit({
                            unit_id: project_unit_tipe.project_unit.unit_id,
                            unit_name: project_unit_tipe.project_unit.unit_name,
                            unit_number: project_unit_tipe.project_unit.unit_number
                            }, unit_tipe)" class="uk-button uk-button-primary uk-button-small modal-submit"><i class="icon ion-ios-create"></i></a>
                          <a @click="onDeleteUnitType( unit_tipe.project_unit_type_id )" class="uk-button uk-button-primary uk-button-small modal-submit"><i class="icon ion-ios-trash"></i></a>
                        </td>
                        <td class="uk-width-small">
                          <a @click="onGetInstallmentUnit( unit_tipe.project_unit_type_id )" class="uk-button uk-button-primary uk-button-small modal-submit">Lihat Cicilan</a>
                        </td>
                        <td class="uk-width-small">{{ unit_tipe.unit_floor }}</td>
                        <td class="uk-width-medium">{{ unit_tipe.unit_lb }} m2 / {{ unit_tipe.unit_lt }} h</td>
                        <td class="uk-width-small">{{ unit_tipe.unit_km }} / {{ unit_tipe.unit_kt }}</td>
                        <td>IDR {{ $root.formatNumeral( unit_tipe.unit_price, '0,0' ) }}</td>
                      </tr>
                    </tbody>
                  </table>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- modal lihat tipe unit -->

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
                  <th>Harga</th>
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
                        </ul>
                      </div>
                    </div>
                  </td>
                  <td>{{ unit.project_unit_name }} No. {{ unit.project_unit_number }}</td>
                  <td>0</td>
                  <td>
                    <a @click="onPopupUnitType({
                        unit_id: unit.project_unit_id,
                        unit_name: unit.project_unit_name,
                        unit_number: unit.project_unit_number
                      })" class="uk-button uk-button-primary uk-button-small dash-btn">Lihat Harga</a>
                  </td>
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
        },
        project_unit: {
          unit_id: null,
          unit_name: null,
          unit_number: null
        }
      },
      installment: {
        total: 0,
        results: [],
        errorMessage: '',
        isActive: false,
        project_unit_type_id: null
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
          submit: 'Tambah',
          isEdit: false,
          isToggle: false
        },
        installment: {
          id: null,
          dp: 0,
          angsuran: 0,
          tenor: 0,
          unit_tipe_id: null,
          isToggle: false,
          isEdit: false
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
    getProjectUnitType( unit_id, p )
    {
      this.project_unit_tipe.isLoading = true;
      var url = this.$root.url + '/developer/project/get_unit_tipe/' + unit_id + '?page=' + this.project_unit_tipe.pagination.current_page;
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
    onGetInstallmentUnit( id )
    {
      axios({
        method: 'get',
        url: this.$root.url + '/developer/project/installment_unit/' + id
      }).then( res => {
        this.installment.isActive = true;
        this.installment.project_unit_type_id = id;
        let result = res.data;
        this.installment.results = result.data;
        this.installment.total = result.total;
      }).catch( err => {
        this.installment.errorMessage = err.response.statusText;
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
    onPopupUnitType( unit )
    {
      this.forms.unit_tipe.isToggle = false;
      this.project_unit_tipe.project_unit = unit;
      this.getProjectUnitType( unit.unit_id );
      UIkit.modal('#modal-view-unit-type').show();
    },
    onToggleAddUnit( project_unit, data )
    {
      if( data === undefined )
      {
        this.forms.unit_tipe.unit_floor = 1;
        this.forms.unit_tipe.unit_price = 0;
        this.forms.unit_tipe.unit_kt = 1;
        this.forms.unit_tipe.unit_km = 1;
        this.forms.unit_tipe.unit_lb = 0;
        this.forms.unit_tipe.unit_lt = 0;
        this.forms.unit_tipe.unit_tipe_id = null;
        this.forms.unit_tipe.isEdit = false;
        this.forms.unit_tipe.submit = 'Tambah';
      }
      else
      {
        this.forms.unit_tipe.unit_floor = data.unit_floor;
        this.forms.unit_tipe.unit_price = data.unit_price;
        this.forms.unit_tipe.unit_kt = data.unit_kt;
        this.forms.unit_tipe.unit_km = data.unit_km;
        this.forms.unit_tipe.unit_lb = data.unit_lb;
        this.forms.unit_tipe.unit_lt = data.unit_lt;
        this.forms.unit_tipe.unit_tipe_id = data.project_unit_type_id;
        this.forms.unit_tipe.isEdit = true;
        this.forms.unit_tipe.submit = 'Ubah';
      }

      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.unit_tipe.isToggle === false ) this.forms.unit_tipe.isToggle = true;
    },
    onToggleAddInstallment( unit_tipe, data )
    {
      if( data === undefined )
      {
        this.forms.installment.id = null;
        this.forms.installment.dp = 0;
        this.forms.installment.angsuran = 0;
        this.forms.installment.tenor = 0;
        this.forms.installment.unit_tipe_id = unit_tipe;
        this.forms.installment.isEdit = false;
        this.forms.installment.submit = 'Tambah';
      }
      else
      {
        this.forms.installment.id = data.installment_id;
        this.forms.installment.dp = data.installment_dp;
        this.forms.installment.angsuran = data.installment_price;
        this.forms.installment.tenor = parseFloat( data.installment_tenor / 12 );
        this.forms.installment.unit_tipe_id = unit_tipe;
        this.forms.installment.isEdit = true;
        this.forms.installment.submit = 'Ubah';
      }

      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      if( this.forms.installment.isToggle === false ) this.forms.installment.isToggle = true;
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

      if( this.forms.unit_tipe.unit_floor < 1 )
      {
        this.errors.name.unit_floor = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_lb < 1 )
      {
        this.errors.name.unit_lb = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_lt < 1 )
      {
        this.errors.name.unit_lt = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_kt < 1 )
      {
        this.errors.name.unit_kt = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_km < 1 )
      {
        this.errors.name.unit_km = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.unit_tipe.unit_price < 1 )
      {
        this.errors.name.unit_price = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      let url, method;
      if( this.forms.unit_tipe.isEdit === false )
      {
        url = this.$root.url + '/developer/project/add_unit_tipe/' + this.project_unit_tipe.project_unit.unit_id;
        method = 'post';
      }
      else
      {
        url = this.$root.url + '/developer/project/save_unit_tipe/' + this.forms.unit_tipe.unit_tipe_id;
        method = 'put';
      }
      this.forms.unit_tipe.submit = '<span uk-spinner></span>';

      axios({
        method: method,
        url: url,
        params: {
          unit_floor: this.forms.unit_tipe.unit_floor,
          unit_lb: this.forms.unit_tipe.unit_lb,
          unit_lt: this.forms.unit_tipe.unit_lt,
          unit_km: this.forms.unit_tipe.unit_km,
          unit_kt: this.forms.unit_tipe.unit_kt,
          unit_price: this.forms.unit_tipe.unit_price
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Tipe unit baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.forms.unit_tipe.isToggle = false;
          this.forms.unit_tipe.submit = this.forms.unit_tipe.isEdit === false ? 'Tambah' : 'Ubah';
          this.getProjectUnitType( this.project_unit_tipe.project_unit.unit_id );
        }, 2000);
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
    },
    onAddInstallment()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      let url, method;

      if( this.forms.installment.dp < 1 || this.forms.installment.dp === '' )
      {
        this.errors.name.dp = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.installment.angsuran < 1 || this.forms.installment.angsuran === '' )
      {
        this.errors.name.angsuran = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.forms.installment.tenor < 1 || this.forms.installment.tenor === '' )
      {
        this.errors.name.tenor = 'Harap diisi';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      if( this.forms.installment.isEdit === false )
      {
        url = this.$root.url + '/developer/project/add_installment/' + this.forms.installment.unit_tipe_id;
        method = 'post';
      }
      else
      {
        url = this.$root.url + '/developer/project/save_installment/' + this.forms.installment.id;
        method = 'put';
      }

      this.forms.installment.submit = '<span uk-spinner></span>';
      axios({
        method: method,
        url: url,
        params: {
          dp: this.forms.installment.dp,
          angsuran: this.forms.installment.angsuran,
          tenor: this.forms.installment.tenor
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: this.forms.installment.isEdit === false ? 'Cicilan berhasil ditambah' : 'Cicilan berhasil diubah',
          icon: 'success'
        });
        setTimeout(() => {
          this.forms.installment.isToggle = false;
          this.onGetInstallmentUnit( this.forms.installment.unit_tipe_id );
        }, 2000);
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
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
            setTimeout(() => { this.getProjectUnitType( this.project_unit_tipe.project_unit.unit_id ); }, 2000);
          });
        }
      });
    },
    onDeleteInstallment( id, unit )
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
            url: this.$root.url + '/developer/project/delete_installment/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Cicilan berhasil dihapus',
              icon: 'success',
              timer: 1000
            });
            setTimeout(() => { this.onGetInstallmentUnit( unit ); }, 2000);
          });
        }
      });
    },
    calcInstallmentCredit( dp, angsuran, tenor )
    {
      let res = ( parseInt( angsuran ) * parseInt( tenor ) ) + parseInt( dp );
      res = this.$root.formatNumeral( res, '0,0' );
      return res;
    }
  },
  mounted() {
    this.getGalleries();
    this.getProjectUnit();
  }
}
</script>

<template>
  <div>
    <ul class="uk-breadcrumb">
      <li><a :href="$root.url + '/developer/project/dashboard'">Dashboard</a></li>
      <li><a :href="$root.url + '/developer/project/manage_project'">Kelola Proyek</a></li>
      <li><span>{{ getproject.project_name }}</span></li>
    </ul>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">
        {{ getproject.project_name }}
        <a uk-tooltip="Edit Proyek" :href="$root.url + '/developer/project/edit_project/' + getproject.project_unique_id" class="uk-float-right uk-button uk-button-primary uk-button-small dash-btn dash-btn-action" uk-icon="pencil"></a>
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ getproject.province_name }},
        {{ getproject.city_name }}<br>
        {{ getproject.project_address }}
      </div>
      <div v-show="getproject.project_thumbnail" class="uk-background-cover uk-height-large uk-panel" :style="{'background-image': 'url(' + $root.url + '/images/project/gallery/' + getproject.project_thumbnail + ')'}"></div>
      <div v-show="getproject.project_map_embed"></div>
      <!-- gallery -->
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
      <!-- gallery -->

      <!-- detail unit -->
      <div id="modal-detail-unit" class="uk-modal-full" uk-modal>
        <div class="uk-modal-dialog">
          <a class="uk-modal-close-large uk-modal-close" uk-close></a>
          <div class="uk-grid-collapse uk-grid-match" uk-grid>
            <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
              <div class="uk-background-cover" v-if="unit_tipe.detail.unit_thumbnail === null" uk-height-viewport  :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage2.jpg)'}">
              </div>
              <div v-else class="uk-background-cover" uk-height-viewport :style="{'background-image': 'url(' + $root.url + '/images/project/gallery/' + unit_tipe.detail.unit_thumbnail + ')'}"></div>
            </div>
            <div class="uk-width-expand">
              <div class="uk-card uk-card-body uk-overflow-auto" style="height: 620px;">
                <h1 class="uk-h1">Rp. {{ $root.formatNumeral( unit_tipe.detail.unit_price, '0,0' ) }}</h1>
                <h3 class="uk-h3">{{ unit_tipe.detail.unit_name }}</h3>
                <table class="uk-table uk-table-striped uk-table-hover uk-table-small uk-table-middle uk-table-responsive">
                  <tbody>
                    <tr>
                      <td>Kamar Tidur</td>
                      <td><strong>{{ unit_tipe.detail.unit_kt }}</strong></td>
                      <td>Kamar Mandi</td>
                      <td><strong>{{ unit_tipe.detail.unit_km }}</strong></td>
                    </tr>
                    <tr>
                      <td>Jumlah Lantai</td>
                      <td><strong>{{ unit_tipe.detail.unit_floor }}</strong></td>
                      <td>Kapasitas Watt</td>
                      <td><strong>{{ unit_tipe.detail.unit_watt }}</strong></td>
                    </tr>
                    <tr>
                      <td>Luas Bangunan (m2)</td>
                      <td><strong>{{ unit_tipe.detail.unit_lb }}</strong></td>
                      <td>Luas Lahan (m2)</td>
                      <td><strong>{{ unit_tipe.detail.unit_lt }}</strong></td>
                    </tr>
                  </tbody>
                </table>
                <hr>
                <h3 class="uk-h3">Deskripsi</h3>
                <div v-html="unit_tipe.detail.unit_description"></div>
                <hr>
                <h3 class="uk-h3">Fasilitas</h3>
                <div class="uk-grid-small uk-child-width-1-3@s" uk-grid>
                  <div v-for="fac in getFacility( unit_tipe.detail.unit_facility )" class="uk-text-small">
                    <span uk-icon="icon: check; ratio: 0.6"></span> {{ fac }}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- detail unit -->

      <!-- gallery unit -->
      <div id="modal-gallery-unit" class="uk-modal-full" uk-modal>
        <div class="uk-modal-dialog uk-modal-body uk-height-viewport">
          <a class="uk-modal-close-large uk-modal-close" uk-close></a>
          <h3 class="uk-modal-title">Galeri - {{ gallery_unit.unit_tipe.unit_name }}</h3>
          <div class="uk-margin-top modal-form">
            <div class="uk-width-1-1 uk-placeholder uk-text-center" uk-form-custom>
              <span uk-icon="icon: cloud-upload"></span>
              <span class="uk-text-middle">Attach binaries by dropping them here or</span>
              <input id="file-gallery-unit" type="file" @change="selectedGalleryUnit" accept="image/*" multiple>
              <span class="uk-link uk-text-middle">selecting one</span>
            </div>
            <div v-show="forms.imageselected.length !== 0" class="uk-text-small">{{ forms.imageselected.length }} gambar akan diupload...</div>
            <div class="uk-margin-small-top">
              <progress class="uk-progress" :value="forms.uploadProgress" max="100"></progress>
              <button class="uk-button uk-button-primary uk-margin modal-form-add" @click="onUploadGallery()">Upload</button>
            </div>
          </div>
          <div v-show="gallery_unit.errorMessage" class="uk-margin-top">
            {{ gallery_unit.errorMessage }}
          </div>
          <div class="uk-grid-small" uk-grid="masonry: true" uk-lightbox="animation: slide">
            <div v-for="gallery in gallery_unit.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
              <div class="uk-inline-clip uk-transition-toggle">
                <img class="uk-transition-scale-up uk-transition-opaque" :src="$root.url + '/images/project/gallery/' + gallery.unit_gallery_filename" />
                <div class="uk-transition-fade uk-overlay uk-overlay-default uk-position-cover">
                  <div class="uk-position-center">
                    <a class="uk-button uk-button-link" :href="$root.url + '/images/project/gallery/' + gallery.unit_gallery_filename">
                      <i uk-icon="icon: forward; ratio: 1"></i>
                    </a>
                    <button class="uk-button uk-button-link" uk-tooltip="Jadikan sebagai thumbnail" @click="setAsThumbnail( gallery.unit_gallery_id )">
                      <i uk-icon="icon: image; ratio: 1"></i>
                    </button>
                    <button class="uk-button uk-button-link" uk-tooltip="Hapus" @click="onDeleteGalleryUnit( gallery.unit_gallery_id )">
                      <i uk-icon="icon: trash; ratio: 1"></i>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <!-- gallery unit -->

      <div class="uk-card-title uk-margin dashboard-content-heading">
        Deskripsi Proyek
      </div>
      <div class="uk-margin dashboard-content-subheading">
        {{ getproject.project_description }} <br>
        <a class="uk-button uk-button-primary uk-margin-small-top dash-btn" uk-toggle="target: #modal-view-gallery">Lihat Galeri</a>
      </div>

      <!-- Unit -->
      <div class="uk-card-title uk-margin dashboard-content-heading">
        Unit Proyek
      </div>
      <div class="uk-margin">
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn">{{ unit_tipe.total }} Unit</a>
          </div>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn" :href="$root.url + '/developer/project/add_unit/' + getproject.project_unique_id">Tambah Unit</a>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="icon: search; ratio: 0.7"></span>
              <input type="search" class="uk-input uk-form-small dash-form-input" v-model="forms.keywords" @keyup.enter="getProjectUnitType();">
            </div>
          </div>
        </div>
        <div v-if="unit_tipe.isLoading === true" class="uk-text-center uk-margin-top">
          <span uk-spinner></span>
        </div>
        <div v-else class="uk-margin-top">
          <div v-if="unit_tipe.total === 0" class="uk-alert-warning" uk-alert>
            <span v-if="unit_tipe.errorMessage">{{ unit_tipe.errorMessage }}</span>
            <span v-else>Belum ada proyek.</span>
          </div>
          <div v-else class="uk-grid-small uk-grid-match" uk-grid>
            <div v-for="unit in unit_tipe.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
              <div class="uk-card uk-card-default dash-grid-box">
                <div class="uk-card-media-top">
                  <div v-if="unit.unit_thumbnail === null" class="uk-tile uk-tile-default grid-image">
                    <div class="uk-position-top-right">
                      <div class="grid-badge">
                        <label v-if="unit.unit_status === 'available'" class="uk-label uk-label-success">Tersedia</label>
                        <label v-else class="uk-label uk-label-danger">Terjual</label>
                      </div>
                    </div>
                    <div class="uk-text-center">
                      <span uk-icon="icon: image; ratio: 3"></span>
                    </div>
                  </div>
                  <div v-else class="uk-cover-container grid-image">
                    <img :src="$root.url + '/images/project/gallery/' + unit.unit_thumbnail" alt="" uk-cover>
                    <div class="uk-overlay uk-position-cover">
                      <div class="uk-position-top-right">
                        <div class="grid-badge">
                          <label v-if="unit.unit_status === 'available'" class="uk-label uk-label-success">Tersedia</label>
                          <label v-else class="uk-label uk-label-danger">Terjual</label>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="uk-card-body uk-card-small">
                  <div class="uk-margin-small uk-card-title grid-box-title">{{ unit.unit_name }}</div>
                  <div class="uk-margin-small grid-box-lead">
                    Terakhir diubah: {{ $root.formatDate( unit.updated_at, 'DD MMM YYYY', 'id' ) }} <br>
                    Rp. {{ $root.formatNumeral( unit.unit_price, '0,0' ) }}
                  </div>
                  <!--<div class="uk-text-truncate uk-margin-small grid-box-content">{{ project.project_description }}</div>-->
                </div>
                <div class="uk-position-relative uk-margin-bottom grid-box-footer">
                  <div class="uk-grid-collapse" uk-grid>
                    <div class="uk-width-1-3">
                      <a uk-tooltip="Edit Unit" :href="$root.url + '/developer/project/edit_unit/' + unit.unit_type_id" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i uk-icon="pencil"></i></a>
                    </div>
                    <div class="uk-width-1-3">
                      <a uk-tooltip="Hapus Unit" @click="onDeleteUnitType( unit.unit_type_id )" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i uk-icon="trash"></i></a>
                    </div>
                    <div class="uk-width-1-3">
                      <a uk-tooltip="Lainnya" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i uk-icon="more-vertical"></i></a>
                      <div class="grid-dropdown-nav" uk-dropdown="pos: top-right; mode: click">
                        <ul class="uk-nav uk-dropdown-nav">
                          <li><a @click="onDetailUnit( unit )"><span class="uk-margin-small-right" uk-icon="forward"></span> Lihat Detail</a></li>
                          <li><a @click="onViewGalleryUnit( unit )"><span class="uk-margin-small-right" uk-icon="image"></span> Galeri</a></li>
                        </ul>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <ul class="uk-margin-top uk-pagination uk-flex-center">
            <li v-if="unit_tipe.pagination.prev_page_url">
              <a @click="getProjectUnitType( unit_tipe.pagination.prev_page_url )" uk-icon="chevron-left"></a>
            </li>
            <li v-else class="uk-disabled">
              <span uk-icon="chevron-left"></span>
            </li>

            <li v-if="unit_tipe.pagination.next_page_url">
              <a @click="getProjectUnitType( unit_tipe.pagination.next_page_url )" uk-icon="chevron-right"></a>
            </li>
            <li v-else class="uk-disabled">
              <span uk-icon="chevron-right"></span>
            </li>
          </ul>
        </div>
      </div>
      <!-- Unit -->
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getproject'],
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
      unit_tipe: {
        isLoading: false,
        total: 0,
        results: [],
        errorMessage: '',
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null,
          path: this.$root.url + '/developer/project/get_unit/' + this.getproject.project_unique_id
        },
        detail: {}
      },
      gallery_unit: {
        isLoading: false,
        total: 0,
        results: [],
        errorMessage: '',
        unit_tipe: {
          unit_id: null,
          unit_name: null
        }
      },
      forms: {
        keywords: '',
        imageselected: [],
        uploadProgress: 0
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
      this.unit_tipe.isLoading = true;
      var url = this.$root.url + '/developer/project/get_unit/' + this.getproject.project_unique_id + '?page=' + this.unit_tipe.pagination.current_page;
      if( p !== undefined ) url = p;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.unit_tipe.total = result.total;
        this.unit_tipe.results = result.data;
        this.unit_tipe.pagination = {
          current_page: result.current_page,
          last_page: result.last_page,
          prev_page_url: result.prev_page_url,
          next_page_url: result.next_page_url,
          path: result.path
        };
        this.unit_tipe.isLoading = false;
      }).catch( err => {
        this.unit_tipe.errorMessage = err.response.statusText;
      });
    },
    onDetailUnit( data )
    {
      this.unit_tipe.detail = data;
      UIkit.modal('#modal-detail-unit').show();
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
            setTimeout(() => {
              this.getProjectUnitType();
            }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: err.response.statusText,
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
    },
    onViewGalleryUnit( data )
    {
      this.gallery_unit.unit_tipe = {
        unit_id: data.unit_type_id,
        unit_name: data.unit_name
      };
      this.getGalleriesUnit( data.unit_type_id );
      UIkit.modal('#modal-gallery-unit').show();
    },
    selectedGalleryUnit( event )
    {
      var targetfile = event.target.files;
      this.forms.imageselected = [];

      if( targetfile.length !== 0 )
      {
        for( let i = 0; i < targetfile.length; i++ )
        {
          this.forms.imageselected.push(targetfile[i]);
        }
      }
    },
    onUploadGallery()
    {
      this.forms.uploadProgress = 0;
      if( this.forms.imageselected.length !== 0 )
      {
        let fd = new FormData();
        this.forms.imageselected.forEach( file => {
          fd.append('images[]', file);
        });

        let url = this.$root.url + '/developer/project/upload_gallery_unit/' + this.gallery_unit.unit_tipe.unit_id;
        axios.post( url, fd, {
          onUploadProgress: function( e )
          {
            this.forms.uploadProgress = parseInt( Math.round( e.loaded * 100 ) / e.total );
          }.bind(this)
        }).then( res => {
          $("#file-gallery-unit").val('');
          setTimeout(() => { this.getGalleriesUnit( this.gallery_unit.unit_tipe.unit_id ); }, 1000);
          this.forms.imageselected = [];
        }).catch( err => {
          this.gallery_unit.errorMessage = err.response.statusText;
        });
      }
    },
    getGalleriesUnit( id )
    {
      this.forms.uploadProgress = 0;
      axios({
        method: 'get',
        url: this.$root.url + '/developer/project/gallery_unit/' + id
      }).then( res => {
        let result = res.data;
        this.gallery_unit.results = result.results.data;
        this.gallery_unit.total = result.results.total;
      }).catch( err => {
        this.gallery_unit.errorMessage = err.response.statusText;
      });
    },
    setAsThumbnail( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Jadikan sebagai thumbnail?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal',
          confirm: {
            value: true,
            text: 'Ya'
          }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/developer/project/gallery_set_thumbnail/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Foto berhasil dijadikan thumbnail.',
              icon: 'success'
            });
            setTimeout(() => {
              UIkit.modal('#modal-gallery-unit').hide();
              this.getProjectUnitType();
            }, 2000);
          }).catch( err => {
            this.gallery_unit.errorMessage = err.response.statusText;
          });
        }
      });
    },
    onDeleteGalleryUnit( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus galeri ini?',
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
            url: this.$root.url + '/developer/project/delete_gallery_unit/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Gambar berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => {
              this.getProjectUnitType();
              this.getGalleriesUnit( this.gallery_unit.unit_tipe.unit_id );
            }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: err.response.statusText,
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
    },
    getFacility( facility )
    {
      if( facility !== undefined )
      {
        return facility.split(',');
      }
    }
  },
  mounted() {
    this.getGalleries();
    this.getProjectUnitType();
  }
}
</script>

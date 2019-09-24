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
      <div class="uk-card-title uk-margin dashboard-content-heading">
        Unit Proyek
      </div>
      <div class="uk-margin">
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn">{{ project_unit_tipe.total }} Unit</a>
          </div>
          <div>
            <a class="uk-button uk-button-primary uk-button-small dash-btn" :href="$root.url + '/developer/project/add_unit/' + getproject.project_unique_id">Tambah Unit</a>
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
        <div v-else></div>
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
    }
  },
  mounted() {
    this.getGalleries();
  }
}
</script>

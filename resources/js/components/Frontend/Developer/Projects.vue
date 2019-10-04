<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Proyek</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <a class="uk-button uk-button-primary uk-margin dash-btn" :href="$root.url + '/developer/project/add_project'">Tambah Proyek Baru</a>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.getstatus" @change="getProjectList()">
            <option value="all">Semua</option>
            <option value="available">Tersedia</option>
            <option value="sold">Terjual</option>
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
                      <label v-if="project.project_status === 'available'" class="uk-label uk-label-success">Tersedia</label>
                      <label v-else-if="project.project_status === 'soon'" class="uk-label">Segera</label>
                      <label v-else class="uk-label uk-label-danger">Terjual</label>
                    </div>
                  </div>
                  <div class="uk-text-center">
                    <span uk-icon="icon: image; ratio: 3"></span>
                  </div>
                </div>
                <div v-else class="uk-cover-container grid-image">
                  <img :src="$root.url + '/images/project/gallery/' + project.project_thumbnail" alt="" uk-cover>
                  <div class="uk-overlay uk-position-cover">
                    <div class="uk-position-top-right">
                      <div class="grid-badge">
                        <label v-if="project.project_status === 'available'" class="uk-label uk-label-success">Tersedia</label>
                        <label v-else-if="project.project_status === 'soon'" class="uk-label">Segera</label>
                        <label v-else class="uk-label uk-label-danger">Terjual</label>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="uk-card-body uk-card-small">
                <div class="uk-margin-small uk-card-title grid-box-title">{{ project.project_name }}</div>
                <div class="uk-margin-small grid-box-lead">
                  Terakhir diubah: {{ $root.formatDate( project.created_at, 'DD MMM YYYY', 'id' ) }} <br>
                  <span class="uk-text-bold" v-if="project.project_type === 'residensial'">Residensial</span>
                  <span class="uk-text-bold" v-else="project.project_type === 'apartemen'">Apartemen</span>
                </div>
                <!--<div class="uk-text-truncate uk-margin-small grid-box-content">{{ project.project_description }}</div>-->
              </div>
              <div class="uk-position-relative uk-margin-bottom grid-box-footer">
                <div class="uk-grid-collapse" uk-grid>
                  <div class="uk-width-1-3">
                    <a uk-tooltip="Edit Proyek" :href="$root.url + '/developer/project/edit_project/' + project.project_id" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i uk-icon="pencil"></i></a>
                  </div>
                  <div class="uk-width-1-3">
                    <a uk-tooltip="Hapus Proyek" @click="onDeleteProject( project.project_id )" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i uk-icon="trash"></i></a>
                  </div>
                  <div class="uk-width-1-3">
                    <a uk-tooltip="Lainnya" class="uk-width-1-1 uk-button uk-button-primary dash-btn dash-btn-action"><i uk-icon="more-vertical"></i></a>
                    <div class="grid-dropdown-nav" uk-dropdown="pos: top-right; mode: click">
                      <ul class="uk-nav uk-dropdown-nav">
                        <li><a :href="$root.url + '/developer/project/detail/' + project.project_unique_id"><span class="uk-margin-small-right" uk-icon="forward"></span> Lihat Proyek</a></li>
                        <li><a :href="$root.url + '/developer/project/gallery/' + project.project_unique_id"><span class="uk-margin-small-right" uk-icon="image"></span> Galeri</a></li>
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
        keywords: '',
        getstatus: 'all',
      },
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
  computed: {},
  mounted() {
    this.getProjectList();
  }
}
</script>

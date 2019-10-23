<template>
  <div>
    <div id="modal-customer" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-h3">Detail Proyek</h3>
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-1">
            <div class="uk-panel uk-margin">
              <img v-if="getproject.detail.project_thumbnail" :src="this.$root.url + '/storage/assets/images/project/gallery/' + getproject.detail.project_thumbnail" />
              <img v-else :src="this.$root.url + '/images/banner/homepage3.jpg'" alt="" />
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">{{ getproject.detail.project_name }}</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Tanggal Posting
                <span v-show="getproject.detail.created_at">
                  {{ $root.formatDate( getproject.detail.created_at, 'DD MMMM YYYY' ) }}
                </span>
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Pengembang</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getproject.detail.dev_name }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Tipe Proyek</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                <span v-if="getproject.detail.project_type === 'residensial'">Residensial</span>
                <span v-else>Apartemen</span>
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Lokasi</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getproject.detail.project_address }} <br>
                {{ getproject.detail.city_name }}, {{ getproject.detail.province_name }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Jumlah Unit</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getproject.detail.total_unit }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Status Proyek</h4>
              <label v-if="getproject.detail.project_status === 'sold'" class="uk-label uk-label-danger">Terjual</label>
              <label v-else-if="getproject.detail.project_status === 'soon'" class="uk-label">Segera Hadir {{ getproject.detail.project_estimate_launch }}</label>
              <label v-else class="uk-label uk-label-success">Tersedia</label>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Properti</span></li>
        <li><span>Proyek</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Proyek</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getProjectList()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.status" @change="getProjectList()">
              <option value="all">Semua status</option>
              <option value="available">Tersedia</option>
              <option value="soon">Segera Hadir</option>
              <option value="sold">Terjual</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.city" @change="getProjectList()">
              <option value="all">Semua kota</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getProjectList()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getproject.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada proyek
          </div>
          <div v-else>
            <label class="uk-label">{{ getproject.total }} proyek</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Proyek</th>
                  <th>Pengembang</th>
                  <th>Kota</th>
                  <th>Jumlah Unit</th>
                  <th>Status</th>
                  <th>Tanggal Posting</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="project in getproject.results">
                  <td>
                    <a uk-tooltip="Lihat Detail" @click="onDetailProject( project )" class="uk-icon-link" uk-icon="forward"></a>
                  </td>
                  <td>{{ project.project_name }}</td>
                  <td>{{ project.dev_name }}</td>
                  <td>{{ project.city_name }}</td>
                  <td>{{ project.total_unit }} unit</td>
                  <td>
                    <label v-if="project.project_status === 'sold'" class="uk-label uk-label-danger">Terjual</label>
                    <label v-else-if="project.project_status === 'soon'" class="uk-label">Segera Hadir</label>
                    <label v-else class="uk-label uk-label-success">Tersedia</label>
                  </td>
                  <td>{{ $root.formatDate( project.created_at, 'DD/MM/YYYY' ) }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getproject.paginate.prev_page_url" @click="getProjectList( getproject.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getproject.paginate.next_page_url" @click="getProjectList( getproject.paginate.next_page_url )">
                  <span uk-pagination-next></span>
                </a>
                <a v-else>
                  <span uk-pagination-next></span>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['getcity'],
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        city: 'all',
        status: 'all'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getproject: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        },
        detail: {}
      }
    }
  },
  methods: {
    getProjectList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city + '&status=' + this.forms.status;
      var url = this.$root.url + '/cp/property/project/get_project?page=' + this.getproject.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getproject.total = result.total;
        this.getproject.results = result.data;
        this.getproject.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailProject( data )
    {
      this.getproject.detail = data;
      UIkit.modal('#modal-customer').show();
    },
    saveReport()
    {
      let param = 'city=' + this.forms.city + '&status=' + this.forms.status;
      let url = this.$root.url + '/cp/property/project/save_report?' + param;
      window.open( url, '_blank' );
    }
  },
  mounted() {
    this.getProjectList();
  }
}
</script>

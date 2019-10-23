<template>
  <div>
    <div id="modal-developer" class="uk-modal-container" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <h3 class="uk-h3">Detail Pengembang</h3>
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-panel uk-margin">
              <img v-if="getdeveloper.detail.dev_logo" :src="this.$root.url + '/images/devlogo/' + getdeveloper.detail.dev_logo" />
              <img v-else :src="this.$root.url + '/images/avatar/avatar.jpg'" alt="" />
            </div>
          </div>
          <div class="uk-width-expand">
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">No. ID</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getdeveloper.detail.dev_user_id }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">{{ getdeveloper.detail.dev_name }}</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                Bergabung pada
                <span v-show="getdeveloper.detail.created_at">
                  {{ $root.formatDate( getdeveloper.detail.created_at, 'DD MMMM YYYY' ) }}
                </span>
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Nama Pemilik</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getdeveloper.detail.dev_ownername }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat Email</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getdeveloper.detail.dev_email }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Telepon</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                <span uk-icon="receiver"></span> {{ getdeveloper.detail.dev_phone_office }} <br />
                <span uk-icon="whatsapp"></span> {{ getdeveloper.detail.dev_mobile_phone }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Alamat</h4>
              <p class="uk-text-meta uk-margin-remove-top">
                {{ getdeveloper.detail.dev_address }} <br>
                {{ getdeveloper.detail.city_name }}
              </p>
            </div>
            <div class="uk-panel uk-margin">
              <h4 class="uk-h5 uk-margin-remove-bottom">Status Verifikasi</h4>
              <label v-if="getdeveloper.detail.status_verification === 'Y'" class="uk-label uk-label-success">Terverifikasi</label>
              <label v-else class="uk-label uk-label-warning">Belum Verifikasi</label>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Developer</span></li>
        <li><span>Developer</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Pengembang</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getDeveloperList()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.status" @change="getDeveloperList()">
              <option value="all">Semua status</option>
              <option value="N">Belum Verifikasi</option>
              <option value="Y">Terverifikasi</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.city" @change="getDeveloperList()">
              <option value="all">Semua kota</option>
              <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getDeveloperList()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getdeveloper.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Pengembang
          </div>
          <div v-else>
            <label class="uk-label">{{ getdeveloper.total }} Pengembang</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama Pengembang</th>
                  <th>Email</th>
                  <th>Kota</th>
                  <th>Status Verifikasi</th>
                  <th>Tanggal Registrasi</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="dev in getdeveloper.results">
                  <td>
                    <a uk-tooltip="Lihat Detail" @click="onDetailDeveloper( dev )" class="uk-icon-link" uk-icon="forward"></a>
                    <a uk-tooltip="Hapus" @click="onDeleteDeveloper( dev.dev_user_id )" class="uk-icon-link" uk-icon="trash"></a>
                  </td>
                  <td>{{ dev.dev_name }}</td>
                  <td>{{ dev.dev_email }}</td>
                  <td>{{ dev.city_name }}</td>
                  <td>
                    <label v-if="dev.status_verification === 'Y'" class="uk-label uk-label-success">Terverifikasi</label>
                    <label v-else class="uk-label uk-label-warning">Belum Verifikasi</label>
                  </td>
                  <td>{{ $root.formatDate( dev.created_at, 'DD/MM/YYYY' ) }}</td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getdeveloper.paginate.prev_page_url" @click="getDeveloperList( getdeveloper.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getdeveloper.paginate.next_page_url" @click="getDeveloperList( getdeveloper.paginate.next_page_url )">
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
      getdeveloper: {
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
    getDeveloperList( p )
    {
      var param = 'status=' + this.forms.status + '&keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&city=' + this.forms.city;
      var url = this.$root.url + '/cp/developer/get_developer?page=' + this.getdeveloper.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getdeveloper.total = result.total;
        this.getdeveloper.results = result.data;
        this.getdeveloper.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onDetailDeveloper( data )
    {
      this.getdeveloper.detail = data;
      UIkit.modal('#modal-developer').show();
    },
    saveReport()
    {
      let param = 'status=' + this.forms.status + '&city=' + this.forms.city;
      let url = this.$root.url + '/cp/developer/save_report?' + param;
      window.open( url, '_blank' );
    },
    onDeleteDeveloper( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus developer ini?',
        icon: 'warning',
        buttons: {
          confirm: { value: true, text: 'Ya' },
          cancel: 'Tidak'
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/cp/developer/delete/' + id
          }).then( res => {
            swal({
              title: 'Berhasil',
              text: 'Developer telah dihapus',
              icon: 'success'
            });
            this.getDeveloperList();
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error',
              dangerMode: true
            });
          });
        }
      });
    }
  },
  mounted() {
    this.getDeveloperList();
  }
}
</script>

<style lang="css" scoped>
</style>

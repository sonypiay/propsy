<template>
  <div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Developer</span></li>
        <li><span>Pengajuan Verifikasi</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">Pengajuan Verifikasi</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <select class="uk-select" v-model="forms.limit" @change="getRequestList()">
              <option value="10">10</option>
              <option value="20">20</option>
              <option value="50">50</option>
              <option value="100">100</option>
            </select>
          </div>
          <div>
            <select class="uk-select" v-model="forms.status" @change="getRequestList()">
              <option value="all">Semua status</option>
              <option value="N">Menunggu Verifikasi</option>
              <option value="R">Verifikasi Ditolak</option>
              <option value="Y">Terverifikasi</option>
            </select>
          </div>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getRequestList()" />
            </div>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getrequest.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada Pengajuan Verifikasi
          </div>
          <div v-else>
            <label class="uk-label">{{ getrequest.total }} Pengajuan</label>
            <a uk-tooltip="Cetak" class="uk-link uk-link-text" @click="saveReport()">
              <span uk-icon="print"></span>
            </a>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Pengembang</th>
                  <th>NPWP</th>
                  <th>Sertifikat</th>
                  <th>Tanggal Pengajuan</th>
                  <th>Status</th>
                  <th>Aksi</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="req in getrequest.results">
                  <td>{{ req.dev_name }}</td>
                  <td><a target="_blank" :href="$root.url + '/storage/assets/document_file/request_verification/' + req.npwp_image" class="uk-width-1-1 uk-button uk-button-small uk-button-default">Lihat</a></td>
                  <td><a target="_blank" :href="$root.url + '/storage/assets/document_file/request_verification/' + req.official_certificate" class="uk-width-1-1 uk-button uk-button-small uk-button-default">Lihat</a></td>
                  <td>{{ $root.formatDate( req.created_at, 'DD/MM/YYYY' ) }}</td>
                  <td>
                    <label class="uk-label" v-if="req.status_verification === 'N'">Menunggu Verifikasi</label>
                    <label class="uk-label uk-label-danger" v-else-if="req.status_verification === 'R'">Verifikasi Ditolak</label>
                    <label class="uk-label uk-label-success" v-else>Terverifikasi</label>
                  </td>
                  <td>
                    <a v-if="req.status_verification === 'N'" @click="onApprovalRequest( req.hash_id, 'accept' )" uk-tooltip="Setuju" class="uk-button uk-button-default uk-button-small" uk-icon="check"></a>
                    <a v-if="req.status_verification === 'N'" @click="onApprovalRequest( req.hash_id, 'reject' )" uk-tooltip="Tolak" class="uk-button uk-button-default uk-button-small" uk-icon="close"></a>
                  </td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getrequest.paginate.prev_page_url" @click="getRequestList( getrequest.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getrequest.paginate.next_page_url" @click="getRequestList( getrequest.paginate.next_page_url )">
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
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        status: 'all'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getrequest: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        },
        detail: {
          data: {},
          log_request: []
        }
      }
    }
  },
  methods: {
    getRequestList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit + '&status=' + this.forms.status;
      var url = this.$root.url + '/cp/developer/verification/get_verification?page=' + this.getrequest.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getrequest.total = result.total;
        this.getrequest.results = result.data;
        this.getrequest.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    saveReport()
    {
      let param = 'status=' + this.forms.status;
      let url = this.$root.url + '/cp/developer/verification/save_report?' + param;
      window.open( url, '_blank' );
    },
    onApprovalRequest( id, approval )
    {
      var messageConfimartion = approval === 'accept' ? 'Apakah anda ingin menerima permohonan ini?' : 'Apakah anda ingin menolak permohonan ini?';
      swal({
        title: 'Konfirmasi',
        text: messageConfimartion,
        icon: 'warning',
        buttons: {
          confirm: { value: true, text: 'Ya' },
          cancel: 'Tidak'
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/cp/developer/verification/approval/' + id + '/' + approval
          }).then( res => {
            var message = approval === 'accept' ? 'Verifikasi diterima' : 'Verifikasi ditolak';
            swal({
              title: 'Berhasil',
              text: message,
              icon: 'success'
            });
            this.getRequestList();
          }).catch( err => {
            swal({
              title: 'Error',
              text: 'Terjadi kesalahan',
              icon: 'error'
            });
          });
        }
      });
    }
  },
  mounted() {
    this.getRequestList();
  }
}
</script>

<style lang="css" scoped>
</style>

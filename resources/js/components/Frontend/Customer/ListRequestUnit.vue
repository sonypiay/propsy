<template>
  <div>
    <div class="uk-margin-large-top uk-margin-large-bottom uk-container">
      <div class="uk-card uk-card-body uk-card-default card-requestlist">
        <div class="uk-heading-line card-requestlist-heading"><span>Daftar Pengajuan Pemesanan</span></div>
        <div class="uk-margin-top">
          <div class="uk-margin-small-bottom card-requestlist-subtext">Status Pengajuan</div>
          <div class="uk-grid-small uk-child-width-auto" uk-grid>
            <div>
              <button @click="getRequestList('open')" :class="{'btn-status-active': forms.status_request === 'open'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Open</button>
            </div>
            <div>
              <button @click="getRequestList('hold')" :class="{'btn-status-active': forms.status_request === 'hold'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Hold</button>
            </div>
            <div>
              <button @click="getRequestList('cancel')" :class="{'btn-status-active': forms.status_request === 'cancel'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Cancel</button>
            </div>
            <div>
              <button @click="getRequestList('survey')" :class="{'btn-status-active': forms.status_request === 'survey'}" class="uk-button uk-button-primary uk-button-small btn-status-request">On Survey</button>
            </div>
            <div>
              <button @click="getRequestList('close')" :class="{'btn-status-active': forms.status_request === 'close'}" class="uk-button uk-button-primary uk-button-small btn-status-request">Close</button>
            </div>
          </div>
        </div>

        <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
        <div v-if="request_list.isLoading === true" class="uk-margin-top uk-text-center">
          <span uk-spinner></span>
        </div>
        <div v-else>
          <div v-if="request_list.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada pengajuan pesanan.
          </div>
          <div v-else class="uk-grid-small uk-grid-divider uk-margin-top" uk-grid>
            <div v-for="unit in request_list.results" class="uk-width-1-1">
              <div class="uk-card card-unit-project uk-grid-collapse uk-grid-match uk-margin" uk-grid>
                <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
                  <div class="uk-card-media-left">
                    <div v-if="unit.unit_thumbnail" class="uk-background-cover unit-thumbnail" :style="{'background-image': 'url(' + $root.url + '/images/project/gallery/' + unit.unit_thumbnail + ')'}">
                    </div>
                    <div v-else class="uk-background-cover unit-thumbnail" :style="{'background-image': 'url(' + $root.url + '/images/banner/homepage2.jpg)'}">
                    </div>
                  </div>
                </div>
                <div class="uk-width-expand">
                  <div class="uk-card-body uk-card-small card-unit-body">
                    <a class="uk-card-title unit-name">{{ unit.unit_name }}</a>
                    <div class="unit-location">
                      <span uk-icon="icon: location; ratio: 0.8"></span>
                      {{ unit.project_address }},
                      {{ unit.city_name }},
                      {{ unit.province_name }}
                    </div>
                    <div class="unit-price">
                      Rp. {{ unit.unit_price | currency }}
                    </div>
                  </div>
                  <div class="uk-card-footer card-unit-footer uk-padding-small">
                    <div class="uk-grid-small uk-child-width-auto" uk-grid>
                      <div>
                        <div class="unit-specification">
                          {{ unit.request_unique_id }}
                          <span>Request ID</span>
                        </div>
                      </div>
                      <div>
                        <div class="unit-specification">
                          {{ $root.formatDate( unit.created_at, 'DD MMMM YYYY' ) }}
                          <span>Tanggal Pengajuan</span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
                <div class="uk-width-1-1">
                  <div class="uk-card-footer card-unit-footer uk-padding-remove uk-margin-small-top">
                    <div class="uk-grid-small uk-child-width-auto" uk-grid>
                      <div>
                        <a class="uk-button uk-button-small uk-button-primary unit-readmore">
                          Lihat Lebih Lanjut
                        </a>
                      </div>
                      <div>
                        <button @click="onCancelRequest( unit.request_unique_id )" class="uk-button uk-button-small btn-cancel-request">Batalkan Pengajuan</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <ul class="uk-pagination uk-flex-center">
          <li v-if="request_list.pagination.prev_page_url !== null">
            <a @click="getRequestList( request_list.pagination.prev_page_url )" uk-icon="chevron-left"></a>
          </li>
          <li v-else class="uk-disabled">
            <a uk-icon="chevron-left"></a>
          </li>
          <li v-if="request_list.pagination.next_page_url !== null">
            <a @click="getRequestList( request_list.pagination.next_page_url )" uk-icon="chevron-right"></a>
          </li>
          <li v-else class="uk-disabled">
            <a uk-icon="chevron-right"></a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: [
    'session_user'
  ],
  data() {
    return {
      forms: {
        status_request: 'open'
      },
      errors: {
        errorMessage: ''
      },
      request_list: {
        isLoading: false,
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null
        }
      }
    }
  },
  methods: {
    getRequestList( status_request, p )
    {
      this.errors.errorMessage = '';

      if( status_request === undefined )
        status_request = 'open';

      this.forms.status_request = status_request;
      var url = this.$root.url + '/customer/get_request_list/' + this.forms.status_request;
      if( p !== undefined )
        url = p;

      this.request_list.isLoading = true;
      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.request_list.isLoading = false;
        this.request_list.results = result.results.data;
        this.request_list.total = result.results.total;
        this.request_list.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          prev_page_url: result.results.prev_page_url,
          next_page_url: result.results.next_page_url
        };
      }).catch( err => {
        this.request_list.isLoading = false;
        this.errors.errorMessage = err.response.statusText;
      });
    },
    onCancelRequest( id )
    {
      swal({
        title: 'Konfirmasi?',
        text: 'Apakah anda ingin membatalkan pengajuan ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Tidak',
          confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'put',
            url: this.$root.url + '/customer/cancel_request/' + id
          }).then( res => {
            swal({
              title: 'Sukses',
              text: 'Pengajuan berhasil dibatalkan',
              icon: 'success',
              timer: 3000
            });
            setTimeout(() => { this.getRequestList(); }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error',
              dangerMode: true,
              timer: 3000
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

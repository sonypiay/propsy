<template>
  <div>
    <div class="dashboard-container">
      <div class="dashboard-content">
        <div class="uk-grid-small uk-grid-match" uk-grid>
          <div class="uk-width-1-1">
            <div class="uk-margin dashboard-content-heading">
              Pengajuan Pemesanan Unit
            </div>
          </div>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default uk-card-body card-overview-default">
              <div class="card-overview-body">
                <div class="card-overview-value">
                  {{ overviewData.request_unit.total }}
                </div>
                <div class="card-overview-text">
                  Pengajuan Unit
                </div>
              </div>
            </div>
          </div>

          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default uk-card-body card-overview-default">
              <div class="card-overview-body">
                <div class="card-overview-value">
                  {{ overviewData.request_unit.accept }}
                </div>
                <div class="card-overview-text">
                  Pengajuan Diterima
                </div>
              </div>
            </div>
          </div>

          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default uk-card-body card-overview-default">
              <div class="card-overview-body">
                <div class="card-overview-value">
                  {{ overviewData.request_unit.waiting_response }}
                </div>
                <div class="card-overview-text">
                  Menunggu Tanggapan
                </div>
              </div>
            </div>
          </div>

          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default uk-card-body card-overview-default">
              <div class="card-overview-body">
                <div class="card-overview-value">
                  {{ overviewData.request_unit.meeting }}
                </div>
                <div class="card-overview-text">
                  Dijadwalkan Meeting
                </div>
              </div>
            </div>
          </div>

          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default uk-card-body card-overview-default">
              <div class="card-overview-body">
                <div class="card-overview-value">
                  {{ overviewData.request_unit.cancel }}
                </div>
                <div class="card-overview-text">
                  Dibatalkan
                </div>
              </div>
            </div>
          </div>

          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default uk-card-body card-overview-default">
              <div class="card-overview-body">
                <div class="card-overview-value">
                  {{ overviewData.request_unit.reject }}
                </div>
                <div class="card-overview-text">
                  Ditolak
                </div>
              </div>
            </div>
          </div>
        </div>
        
        <div class="uk-margin dashboard-content-heading">
          Proyek
        </div>
        <div class="uk-grid-small uk-grid-match" uk-grid>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-card uk-card-default card-overview-primary">
              <div class="uk-card-header card-overview-header">
                <div class="card-overview-value">
                  {{ overviewData.project.total }}
                </div>
                <div class="card-overview-text">
                  Proyek
                </div>
              </div>
              <div class="uk-card-body card-overview-body">
                <div class="uk-grid-small" uk-grid>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Tersedia
                    </div>
                    <div class="uk-float-right">
                      {{ overviewData.project.available }}
                    </div>
                  </div>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Terjual
                    </div>
                    <div class="uk-float-right">
                      {{ overviewData.project.sold }}
                    </div>
                  </div>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Segera Hadir
                    </div>
                    <div class="uk-float-right">
                      {{ overviewData.project.soon }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-card uk-card-default card-overview-primary">
              <div class="uk-card-header card-overview-header">
                <div class="card-overview-value">
                  {{ overviewData.unit.total }}
                </div>
                <div class="card-overview-text">
                  Unit
                </div>
              </div>
              <div class="uk-card-body card-overview-body">
                <div class="uk-grid-small" uk-grid>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Tersedia
                    </div>
                    <div class="uk-float-right">
                      {{ overviewData.unit.available }}
                    </div>
                  </div>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Terjual
                    </div>
                    <div class="uk-float-right">
                      {{ overviewData.unit.sold }}
                    </div>
                  </div>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Sudah dipesan
                    </div>
                    <div class="uk-float-right">
                      {{ overviewData.unit.booked }}
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div class="uk-grid-small uk-margin" uk-grid>
          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin dashboard-content-heading">
              Proyek Terkini
            </div>
            <div class="uk-grid-small uk-grid-divider" uk-grid>
              <div class="uk-width-1-1" v-for="project in overviewData.latest_data.project.results">
                <article class="uk-article card-latest-data">
                  <div class="uk-article-title grid-latest-title">
                    {{ project.project_name }}
                  </div>
                  <div class="uk-article-meta grid-latest-date">
                    Di posting pada {{ $root.formatDate( project.created_at, 'dddd, DD MMMM YYYY HH:mm' ) }}
                  </div>
                  <div class="uk-grid-small uk-child-width-auto uk-margin" uk-grid>
                    <div>
                      <a target="_blank" :href="$root.url + '/developer/project/edit_project/' + project.project_id" class="uk-button uk-button-text">
                        <span uk-icon="icon: pencil; ratio: 1"></span>
                        Edit Proyek
                      </a>
                    </div>
                    <div>
                      <a target="_blank" :href="$root.url + '/project/view/' + project.project_slug" class="uk-button uk-button-text">
                        <span uk-icon="icon: file-text; ratio: 1"></span>
                        Ke Laman Proyek
                      </a>
                    </div>
                  </div>
                </article>
              </div>
            </div>
          </div>

          <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-1-2@m uk-width-1-1@s">
            <div class="uk-margin dashboard-content-heading">
              Tipe Unit Terkini
            </div>
            <div class="uk-grid-small uk-grid-divider" uk-grid>
              <div class="uk-width-1-1" v-for="unit in overviewData.latest_data.unit.results">
                <article class="uk-article card-latest-data">
                  <div class="uk-article-title grid-latest-title">
                    {{ unit.unit_name }}
                  </div>
                  <div class="uk-article-meta grid-latest-date">
                    Di posting pada {{ $root.formatDate( unit.created_at, 'dddd, DD MMMM YYYY HH:mm' ) }}
                  </div>
                  <div class="uk-grid-small uk-child-width-auto uk-margin" uk-grid>
                    <div>
                      <a target="_blank" :href="$root.url + '/developer/project/edit_unit/' + unit.unit_type_id" class="uk-button uk-button-text">
                        <span uk-icon="icon: pencil; ratio: 1"></span>
                        Edit Unit
                      </a>
                    </div>
                    <div>
                      <a target="_blank" :href="$root.url + '/project/detail_unit/' + unit.unit_slug" class="uk-button uk-button-text">
                        <span uk-icon="icon: file-text; ratio: 1"></span>
                        Ke Laman Unit
                      </a>
                    </div>
                  </div>
                </article>
              </div>
            </div>
          </div>
        </div>

        <div class="uk-margin-top">
          <div class="uk-margin dashboard-content-heading">
            Track Pengajuan Pemesanan
          </div>
          <div class="uk-grid-medium uk-grid-divider uk-margin" uk-grid>
            <div v-for="log in overviewData.latest_data.log_request.results" class="uk-width-1-2">
              <article class="uk-article card-latest-data">
                <div class="uk-article-meta">
                  <strong>#{{ log.request_id }}</strong>
                </div>
                <div class="uk-article-meta grid-latest-date">
                  {{ $root.formatDate( log.log_date, 'dddd, DD MMMM YYYY HH:mm' ) }}
                </div>
                <p v-html="log.log_message" class="uk-margin-remove-top"></p>
              </article>
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
      overviewData: {
        project: {
          total: 0,
          available: 0,
          sold: 0,
          soon: 0
        },
        unit: {
          total: 0,
          available: 0,
          sold: 0,
          booked: 0
        },
        request_unit: {
          total: 0,
          waiting_response: 0,
          accept: 0,
          reject: 0,
          cancel: 0,
          meeting: 0
        },
        log_request: {
          total: 0,
          results: [],
          errorMessage: ''
        },
        latest_data: {
          project: {
            total: 0,
            results: []
          },
          unit: {
            total: 0,
            results: []
          },
          log_request: {
            total: 0,
            results: []
          }
        }
      }
    }
  },
  methods: {
    getOverviewProject()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/overview/project'
      }).then( res => {
        let result = res.data;
        let data_project = result.data.project;
        let data_unit = result.data.unit;

        this.overviewData.project = {
          total: data_project.total === null ? 0 : data_project.total,
          available: data_project.available === null ? 0 : data_project.available,
          soon: data_project.soon === null ? 0 : data_project.soon,
          sold: data_project.sold === null ? 0 : data_project.sold
        };
        this.overviewData.unit = {
          total: data_unit.total === null ? 0 : data_unit.total,
          available: data_unit.available === null ? 0 : data_unit.available,
          booked: data_unit.booked === null ? 0 : data_unit.booked,
          sold: data_unit.sold === null ? 0 : data_unit.sold
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getOverviewRequestUnit()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/overview/request_unit'
      }).then( res => {
        let result = res.data;
        let data_request = result.data;

        this.overviewData.request_unit = {
          total: data_request.total === null ? 0 : data_request.total,
          accept: data_request.accept === null ? 0 : data_request.accept,
          waiting_response: data_request.waiting_response === null ? 0 : data_request.waiting_response,
          cancel: data_request.cancel === null ? 0 : data_request.cancel,
          reject: data_request.reject === null ? 0 : data_request.reject,
          meeting: data_request.meeting === null ? 0 : data_request.meeting,
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getLatestProject()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/overview/latest_project'
      }).then( res => {
        let result = res.data;
        this.overviewData.latest_data.project.total = result.data.latest_project.length;
        this.overviewData.latest_data.project.results = result.data.latest_project;

        this.overviewData.latest_data.unit.total = result.data.latest_unit.length;
        this.overviewData.latest_data.unit.results = result.data.latest_unit;

      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getLatestLogRequest()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/overview/latest_log_request'
      }).then( res => {
        let result = res.data;
        this.overviewData.latest_data.log_request.total = result.data.length;
        this.overviewData.latest_data.log_request.results = result.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    }
  },
  mounted() {
    this.getOverviewProject();
    this.getOverviewRequestUnit();
    this.getLatestProject();
    this.getLatestLogRequest();
  }
}
</script>

<style lang="css" scoped>
</style>

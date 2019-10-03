<template>
  <div>
    <div class="dashboard-container">
      <div class="dashboard-content">
        <div class="uk-margin dashboard-content-heading">
          Overview
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
        <div class="uk-grid-small uk-grid-match" uk-grid>
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
        }
      }
    }
  },
  methods: {
    getOverviewProject()
    {
      this.overviewData.project = {
        total: 0,
        available: 0,
        sold: 0,
        soon: 0
      };
      this.overviewData.unit = {
        total: 0,
        available: 0,
        sold: 0,
        booked: 0
      };

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
      this.overviewData.request_unit = {
        total: 0,
        waiting_response: 0,
        accept: 0,
        reject: 0,
        cancel: 0,
        meeting: 0
      };

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
        console.log( this.overviewData.request_unit );
      }).catch( err => {
        console.log( err.response.statusText );
      });
    }
  },
  mounted() {
    this.getOverviewProject();
    this.getOverviewRequestUnit();
  }
}
</script>

<style lang="css" scoped>
</style>

<template>
  <div>
    <div class="uk-container dashboard_container">
      <div class="heading">Dashboard</div>
      <div class="stats_container">
        <div class="stats_heading">Pelanggan</div>
        <div class="stats_body">
          <div class="uk-grid-small" uk-grid>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.customer.current_registered }}
                </div>
                <div class="stats_lead">Terdaftar Hari ini</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.customer.verified }}
                </div>
                <div class="stats_lead">Terverifikasi</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.customer.unverified }}
                </div>
                <div class="stats_lead">Belum Verifikasi</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.customer.all }}
                </div>
                <div class="stats_lead">Total</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="stats_container">
        <div class="stats_heading">Pengembang</div>
        <div class="stats_body">
          <div class="uk-grid-small" uk-grid>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.developer.current_registered }}
                </div>
                <div class="stats_lead">Terdaftar Hari ini</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.developer.verified }}
                </div>
                <div class="stats_lead">Terverifikasi</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.developer.unverified }}
                </div>
                <div class="stats_lead">Belum Verifikasi</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_users.developer.all }}
                </div>
                <div class="stats_lead">Total</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="stats_container">
        <div class="stats_heading">Proyek Terdaftar</div>
        <div class="stats_body">
          <div class="uk-grid-small" uk-grid>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.project.available }}
                </div>
                <div class="stats_lead">Tersedia</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.project.soon }}
                </div>
                <div class="stats_lead">Segera Hadir</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.project.sold }}
                </div>
                <div class="stats_lead">Terjual</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.project.all }}
                </div>
                <div class="stats_lead">Total</div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="stats_container">
        <div class="stats_heading">Unit Terdaftar</div>
        <div class="stats_body">
          <div class="uk-grid-small" uk-grid>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.unit.available }}
                </div>
                <div class="stats_lead">Tersedia</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.unit.booked }}
                </div>
                <div class="stats_lead">Dipesan</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.unit.sold }}
                </div>
                <div class="stats_lead">Terjual</div>
              </div>
            </div>
            <div class="uk-width-1-4">
              <div class="uk-card uk-card-body uk-card-default stats_gridbox">
                <div class="stats_item">
                  {{ stats_project.unit.all }}
                </div>
                <div class="stats_lead">Total</div>
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
  props: [],
  data() {
    return {
      stats_users: {
        customer: {
          all: 0,
          verified: 0,
          unverified: 0,
          current_registered: 0,
        },
        developer: {
          all: 0,
          verified: 0,
          unverified: 0,
          current_registered: 0,
        },
        marketing: {
          all: 0,
        },
      },
      stats_project: {
        project: {
          all: 0,
          available: 0,
          soon: 0,
          sold: 0,
        },
        unit: {
          all: 0,
          available: 0,
          sold: 0,
          booked: 0,
        },
      }
    }
  },
  methods: {
    getStatsUsers()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/cp/stats/users'
      }).then( res => {
        const result = res.data;
        this.stats_users.customer   = result.data.customer;
        this.stats_users.developer  = result.data.developer;
        this.stats_users.marketing  = result.data.marketing;
      }).catch( err => {
        console.log( 'Error ' + err.response.status + '. Unable to load data...' );
      });
    },
    getStatsProject()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/cp/stats/project'
      }).then( res => {
        const result = res.data;
        this.stats_project.project.available = result.data.project.available;
        this.stats_project.project.soon      = result.data.project.soon;
        this.stats_project.project.sold      = result.data.project.sold;
        this.stats_project.project.all       = result.data.project.all;

        this.stats_project.unit.available = result.data.unit.available;
        this.stats_project.unit.booked    = result.data.unit.booked;
        this.stats_project.unit.sold      = result.data.unit.sold;
        this.stats_project.unit.all       = result.data.project.all;
      }).catch( err => {
        console.log( 'Error ' + err.response.status + '. Unable to load data...' );
      });
    }
  },
  mounted() {
    this.getStatsUsers();
    this.getStatsProject();
  }
}
</script>

<style lang="css" scoped>
</style>

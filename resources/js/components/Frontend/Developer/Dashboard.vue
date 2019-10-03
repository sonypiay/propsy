<template>
  <div>
    <div class="dashboard-container">
      <div class="dashboard-content">
        <div class="uk-margin dashboard-content-heading">
          Overview
        </div>
        <div class="uk-grid-small uk-grid-match" uk-grid>
          <div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s">
            <div class="uk-card uk-card-default card-overview-analytic">
              <div class="uk-card-header card-overview-header">
                <div class="card-overview-value">
                  2
                </div>
                <div class="card-overview-text">
                  Proyek Terdaftar
                </div>
              </div>
              <div class="uk-card-body card-overview-body">
                <div class="uk-grid-divider uk-grid-small" uk-grid>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Tersedia
                    </div>
                    <div class="uk-float-right">
                      {{ analytic.project.available }}
                    </div>
                  </div>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Terjual
                    </div>
                    <div class="uk-float-right">
                      {{ analytic.project.available }}
                    </div>
                  </div>
                  <div class="uk-width-1-1">
                    <div class="uk-float-left">
                      Segera
                    </div>
                    <div class="uk-float-right">
                      {{ analytic.project.available }}
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
      analytic: {
        project: {
          total: 0,
          available: 0,
          sold: 0,
          soon: 0
        }
      }
    }
  }
}
</script>

<style lang="css" scoped>
</style>

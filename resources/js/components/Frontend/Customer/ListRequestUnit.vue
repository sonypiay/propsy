<template>
  <div>
    <div class="uk-margin-large-top uk-margin-large-bottom uk-container">
      <div class="uk-card uk-card-body uk-card-default card-requestlist">
        <div class="uk-heading-line card-requestlist-heading"><span>Daftar Pengajuan Pemesanan</span></div>
        <div class="uk-margin-top">
          <div class="uk-margin-small-bottom card-requestlist-subtext">Status Pengajuan</div>
          <div class="uk-grid-small uk-child-width-auto" uk-grid>
            <div>
              <button class="uk-button uk-button-primary uk-button-small btn-status-request btn-status-active">Open</button>
            </div>
            <div>
              <button class="uk-button uk-button-primary uk-button-small btn-status-request">Hold</button>
            </div>
            <div>
              <button class="uk-button uk-button-primary uk-button-small btn-status-request">Cancel</button>
            </div>
            <div>
              <button class="uk-button uk-button-primary uk-button-small btn-status-request">On Survey</button>
            </div>
            <div>
              <button class="uk-button uk-button-primary uk-button-small btn-status-request">Close</button>
            </div>
          </div>
        </div>

        <div class="uk-grid-small uk-grid-divider" uk-grid>

        </div>
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
      forms: {},
      errors: {
        errorMessage: ''
      }
    }
  },
  methods: {},
  mounted() {

  }
}
</script>

<style lang="css" scoped>
</style>

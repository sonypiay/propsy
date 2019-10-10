<template>
  <div>
    <div class="uk-panel uk-margin">
      <h3 class="uk-h3">Agen Marketing</h3>
      <div class="uk-grid-small uk-grid-match" uk-grid>
        <div v-for="mkt in marketinglist.results" class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-2@m uk-width-1-1@s">
          <div class="uk-card uk-card-default">
            <div class="uk-card-header">
              <div class="uk-grid-small uk-flex-middle" uk-grid>
                <div class="uk-width-auto">
                  <img v-if="mkt.mkt_profile_photo" class="uk-border-circle" width="40" height="40" :src="$root.url + '/storage/assets/images/avatar/marketing/' + mkt.mkt_profile_photo" />
                  <img v-else class="uk-border-circle" width="40" height="40" :src="$root.url + '/images/avatar/avatar.jpg'" />
                </div>
                <div class="uk-width-expand">
                  <h4 class="uk-h4 uk-margin-remove-bottom">{{ mkt.mkt_fullname }}</h4>
                </div>
              </div>
            </div>
            <div class="uk-card-body">
              <div class="uk-panel uk-margin">
                <h4 class="uk-h4 uk-margin-remove-bottom">Email</h4>
                <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
                  {{ mkt.mkt_email }}
                </p>
              </div>
              <div class="uk-panel uk-margin">
                <h4 class="uk-h4 uk-margin-remove-bottom">Alamat</h4>
                <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
                  {{ mkt.mkt_address }}
                </p>
              </div>
              <div class="uk-panel uk-margin">
                <h4 class="uk-h4 uk-margin-remove-bottom">Kota</h4>
                <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
                  {{ mkt.city_name }}, {{ mkt.province_name }}
                </p>
              </div>
            </div>
            <div class="uk-card-footer">
              <div class="uk-panel uk-grid-small" uk-grid>
                <div class="uk-width-1-2 uk-text-meta uk-text-center">
                  <a class="uk-button uk-button-text">
                    <div>
                      <span uk-icon="receiver"></span>
                    </div>
                    {{ mkt.mkt_phone_number }}
                  </a>
                </div>
                <div class="uk-width-1-2 uk-text-meta uk-text-center">
                  <a class="uk-button uk-button-text">
                    <div>
                      <span uk-icon="whatsapp"></span>
                    </div>
                    {{ mkt.mkt_mobile_phone }}
                  </a>
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
  props: ['session_user', 'getdeveloper'],
  data() {
    return {
      marketinglist: {
        total: 0,
        results: []
      }
    }
  },
  methods: {
    getMarketingList()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/project/marketing_developer/' + this.getdeveloper.dev_user_id
      }).then( res => {
        let result = res.data;
        this.marketinglist.total = result.result.total;
        this.marketinglist.results = result.result.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    }
  },
  mounted() {
    this.getMarketingList();
  }
}
</script>

<style lang="css" scoped>
</style>

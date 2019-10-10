<template>
  <div>
    <div class="uk-panel uk-margin">
      <h3 class="uk-h3 uk-margin-remove-bottom">Tentang Pengembang</h3>
      <p class="uk-text-meta uk-text-justify">
        {{ getdeveloper.dev_biography }}
      </p>
    </div>
    <div class="uk-panel uk-margin">
      <h3 class="uk-h3 uk-margin-remove-bottom">Alamat</h3>
      <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
        <span v-show="getdeveloper.dev_address">{{ getdeveloper.dev_address }} <br /></span>
        <span v-show="getdeveloper.city_name">{{ getdeveloper.city_name }}, {{ getdeveloper.province_name }}</span>
      </p>
    </div>
    <div class="uk-panel uk-margin">
      <h3 class="uk-h3 uk-margin-remove-bottom">Kontak</h3>
      <p class="uk-text-meta uk-text-justify uk-margin-remove-top">
        <span v-show="getdeveloper.dev_phone_office"><span uk-icon="receiver"></span> {{ getdeveloper.dev_phone_office }} <br /></span>
        <span v-show="getdeveloper.dev_mobile_phone"><span uk-icon="whatsapp"></span> {{ getdeveloper.dev_mobile_phone }}</span>
      </p>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getdeveloper']
}
</script>

<style lang="css" scoped>
</style>

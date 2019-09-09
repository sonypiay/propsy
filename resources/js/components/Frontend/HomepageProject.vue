<template>
  <div>
    <div class="uk-margin-large-top uk-card uk-card-body uk-card-large hpmg-listproject">
      <div class="uk-container">
        <div class="uk-margin-large-bottom hpmg-listproject-heading">Proyek Pengembang yang Tersedia</div>
          <div uk-slider="center: true">
            <div class="uk-position-relative uk-visible-toggle uk-dark" tabindex="-1">
              <ul class="uk-slider-items uk-child-width-1-3@s uk-grid">
                <li v-for="n in 10">
                  <div class="uk-card uk-card-default uk-card-small">
                    <div class="uk-card-media-top">
                      <div class="uk-cover-container">
                        <img :src="$root.url + '/images/banner/homepage1.jpg'" alt="" uk-cover>
                      </div>
                    </div>
                    <div class="uk-card-body">
                      <h3 class="uk-card-title">Headline</h3>
                      <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
                    </div>
                  </div>
                </li>
              </ul>
              <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slider-item="previous"></a>
              <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slider-item="next"></a>
            </div>
            <ul class="uk-slider-nav uk-dotnav uk-flex-center uk-margin"></ul>
          </div>
          <div class="uk-text-center">
            <a class="uk-margin-top uk-button uk-button-primary browse_project_btn">Lihat Proyek Lainnya</a>
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

    }
  },
  methods: {},
  mounted() {}
}
</script>

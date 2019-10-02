<template>
  <div id="background">
    <div class="uk-background-cover uk-height-medium uk-flex uk-flex-center uk-flex-middle" :style="{'background-image': 'url(' + this.$root.url + '/images/banner/homepage3.jpg' + ')'}">
      <div class="container-bannersearch">
        <div class="bannersearch-heading">Cari Proyek Murah</div>
        <div class="bannersearch-form">
          <form class="uk-form-stacked uk-grid-small" uk-grid>
            <div class="uk-width-1-4">
              <select class="uk-width-1-1 uk-select search-form" v-model="forms.type">
                <option value="all">Semua Tipe</option>
                <option value="apartemen">Apartemen</option>
                <option value="residensial">Residensial</option>
              </select>
            </div>
            <div class="uk-width-1-4">
              <select class="uk-width-1-1 uk-select search-form" v-model="forms.type">
                <option value="all">Semua Kota</option>
                <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
              </select>
            </div>
            <div class="uk-width-expand">
              <div class="uk-inline">
                <span class="uk-form-icon" uk-icon="search"></span>
                <input type="search" class="uk-width-1-1 uk-input search-form" v-model="forms.keywords" placeholder="Cari proyek atau nama developer" />
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getcity', 'session_active'],
  data() {
    return {
      forms: {
        keywords: '',
        type: 'all',
        city: 'all'
      },
      errors: {
        name: {},
        errorMessage: ''
      },
      getproject: {
        isLoading: false,
        total: 0,
        results: [],
        pagination: {
          current_page: 1,
          last_page: 1,
          next_prev_url: null,
          prev_page_url: null
        }
      }
    }
  },
  methods: {
    getProjectList( p )
    {
      var param = 'keywords=' + this.forms.keywords + '&type=' + this.forms.type + '&filtercity=' + this.forms.city;
      var url = this.$root.url + '/project/project_list?page=' + this.getproject.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      this.getproject.isLoading = true;
      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getproject.results = result.results.data;
        this.getproject.total = result.results.total;
      }).catch( err => {
        this.errors.errorMessage = err.response.statusText;
      });
    }
  },
  mounted() {
    this.getProjectList();
  }
}
</script>

<style lang="scss" scoped>
#background { background: #f2f2f2; }
</style>

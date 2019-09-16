<template>
  <div>
    <div id="galeri" class="uk-modal-full" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close-full uk-close" uk-close></a>
        <div class="uk-height-viewport">
          <div class="uk-grid-small" uk-grid uk-lightbox>
            <div v-for="galeri in getgallery" class="uk-width-1-3">
              <a :href="$root.url + '/images/project/gallery/' + galeri.gallery_filename">
                <div class="uk-cover-container uk-height-medium">
                  <img :src="$root.url + '/images/project/gallery/' + galeri.gallery_filename" alt="" uk-cover>
                </div>
              </a>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="uk-margin-large-top uk-margin-large-bottom">
      <div class="uk-container">
        <div class="uk-grid-small " uk-grid>
          <div class="uk-width-expand">
            <div class="uk-card container-projectinfo">
              <div class="uk-card-title uk-padding-small container-projectheading">
                {{ getproject.project_name }}
              </div>
              <div class="uk-card-body uk-card-small container-projectbody">
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Deskripsi Proyek
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    {{ getproject.project_description }}
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Alamat
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    {{ getproject.project_address }} <br>
                    <strong>{{ projectcity.city_name }},</strong>
                    <strong>{{ projectcity.province_name }}</strong>
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Google Maps
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    <a :href="getproject.project_link_map">Lihat Google Map</a>
                    <div v-html="getproject.project_map_embed"></div>
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Galeri
                  </div>
                  <div class="uk-margin-small content-projectlead">
                    <a uk-toggle="target: #galeri" class="uk-button uk-button-primary content-viewbutton">Lihat Galeri</a>
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <select class="uk-select content-projectform" v-model="forms.filterUnit" @change="getProjectUnit()">
                    <option value="all">Semua Unit</option>
                    <option :value="unit.project_unit_id" v-for="unit in getunit">{{ unit.project_unit_name }}</option>
                  </select>
                  <table class="uk-table uk-table-divider uk-table-hover uk-table-striped uk-table-small uk-table-middle">
                    <thead>
                      <tr>
                        <th>Cicilan</th>
                        <th>Blok / Prefix</th>
                        <th uk-tooltip="Luas Tanah / Luas Bangunan">LT / LB</th>
                        <th uk-tooltip="Kamar Mandi / Kamar Tidur">KM / KT</th>
                        <th>Harga</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr v-for="unit in projectunit.results">
                        <td>
                          <a class="uk-button uk-button-small uk-button-primary content-viewbutton" @click="">Lihat Cicilan</a>
                        </td>
                        <td>{{ unit.project_unit_name }}</td>
                        <td>{{ unit.unit_lt + ' / ' + unit.unit_lb }}</td>
                        <td>{{ unit.unit_km + ' / ' + unit.unit_kt }}</td>
                        <td>IDR {{ $root.formatNumeral( unit.unit_price, '0,0' ) }}</td>
                      </tr>
                    </tbody>
                  </table>
                  <ul class="uk-pagination uk-flex-center">
                    <li v-if="projectunit.pagination.prev_page_url !== null">
                      <a @click="getProjectUnit( projectunit.pagination.prev_page_url )" uk-icon="chevron-left"></a>
                    </li>
                    <li v-else class="uk-disabled">
                      <a uk-icon="chevron-left"></a>
                    </li>
                    <li v-if="projectunit.pagination.next_page_url !== null">
                      <a @click="getProjectUnit( projectunit.pagination.next_page_url )" uk-icon="chevron-right"></a>
                    </li>
                    <li v-else class="uk-disabled">
                      <a uk-icon="chevron-right"></a>
                    </li>
                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="uk-width-1-4@xl uk-width-1-4@l uk-width-1-4@m uk-width-1-2@s">
            <div class="uk-card uk-card-body sidebar-dev-info">
              <div v-if="getproject.dev_logo === null" class="dev-withnologo">
                <span uk-icon="icon: users; ratio: 4"></span>
              </div>
              <div v-else class="dev-withlogo">
                <img class="uk-align-center" :src="$root.url + '/images/devlogo/' + getproject.dev_logo" :alt="getproject.dev_name">
              </div>
              <div class="uk-margin sidebar-dev-profile">
                <a class="dev-profile-name" href="#">{{ getproject.dev_name }}</a>
                <div class="dev-profile-region">{{ devcity.province_name + ', ' + devcity.city_name }}</div>
              </div>
              <div class="uk-margin uk-text-center">
                <a class="uk-width-1-1 uk-button uk-button-primary sidebar-viewproject" href="#">Lihat Pengembang</a>
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
  props: [
    'session_user',
    'getproject',
    'getgallery',
    'getunit',
    'projectcity',
    'devcity'
  ],
  data() {
    return {
      forms: {
        filterUnit: 'all'
      },
      projectunit: {
        total: 0,
        results: [],
        isLoading: false,
        currentOffset: 0,
        isUpdating: true,
        pagination: {
          current_page: 1,
          last_page: 1,
          next_page_url: null,
          prev_page_url: null
        }
      },
      installment: {
        total: 0,
        results: [],
        isLoading: false
      }
    }
  },
  methods: {
    getProjectUnit( p )
    {
      var param = 'filterUnit=' + this.forms.filterUnit;
      var url = this.$root.url + '/project/unit/' + this.getproject.project_id + '?page=' + this.projectunit.pagination.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.projectunit.results = result.results.data;
        this.projectunit.results.total = result.results.total;
        this.projectunit.pagination = {
          current_page: result.results.current_page,
          last_page: result.results.last_page,
          next_page_url: result.results.next_page_url,
          prev_page_url: result.results.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getProjectUnitInstallment( unit_type )
    {

    }
  },
  mounted() {
    this.getProjectUnit();
  }
}
</script>

<style lang="css" scoped>
</style>

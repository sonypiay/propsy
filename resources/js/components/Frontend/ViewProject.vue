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
        <div class="uk-grid-small" uk-grid>
          <div class="uk-width-1-4@xl uk-width-1-4@l uk-width-1-3@m uk-width-1-2@s">
            <div class="uk-card uk-card-body sidebar-dev-info" uk-sticky="media: 640">
              <div class="uk-margin sidebar-dev-logo">
                <div v-if="getproject.dev_logo === null" class="uk-tile uk-tile-default dev-nologo">
                  <div class="uk-position-center">
                    <span uk-icon="icon: users; ratio: 4"></span>
                  </div>
                </div>
                <div v-else class="uk-text-center dev-withlogo">
                  <img :src="$root.url + '/images/devlogo/' + getproject.dev_logo" :alt="getproject.dev_name">
                </div>
              </div>
              <div class="uk-margin sidebar-dev-profile">
                <a class="dev-profile-name" href="#">{{ getproject.dev_name }}</a>
                <div class="dev-profile-region">{{ devregion.provinsi.area_name + ', ' + devregion.kota.area_name }}</div>
              </div>
              <a class="uk-margin uk-width-1-1 uk-button uk-button-primary sidebar-viewproject" href="#">Lihat Profil</a>
            </div>
          </div>
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
                    <strong>{{ projectregion.provinsi.area_name }},</strong>
                    <strong>{{ projectregion.kota.area_name }}</strong>
                  </div>
                </div>
                <div class="uk-margin content-projectdetail">
                  <div class="uk-margin-small content-projectheading">
                    Google Maps
                  </div>
                  <div class="uk-margin-small content-projectlead" v-html="getproject.project_gmaps">
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
                  <div class="uk-grid-small uk-child-width-auto" uk-grid>
                    <div>
                      <select class="uk-select content-projectform" v-model="forms.unitname">
                        <option :value="''">-- Blok / Prefix --</option>
                        <option v-for="unit in getunit.unit_name" :value="unit.unit_name">{{ unit.unit_name }}</option>
                      </select>
                    </div>
                    <div>
                      <select class="uk-select content-projectform" v-model="forms.unitnumber">
                        <option :value="''">-- Nomor Unit --</option>
                        <option v-for="unit in getunit.unit_number" :value="unit.unit_number">{{ unit.unit_number }}</option>
                      </select>
                    </div>
                    <div>
                      <button class="uk-button uk-button-primary content-viewbutton" @click="getProjectUnit()">Filter</button>
                    </div>
                  </div>
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
                        <td>{{ unit.project_unit_name + ' No. ' + unit.project_unit_number }}</td>
                        <td>{{ unit.unit_lt + ' / ' + unit.unit_lb }}</td>
                        <td>{{ unit.unit_km + ' / ' + unit.unit_kt }}</td>
                        <td>IDR {{ $root.formatNumeral( unit.unit_price, '0,0' ) }}</td>
                      </tr>
                    </tbody>
                  </table>
                  <button class="uk-margin-top uk-button uk-button-primary content-viewbutton" @click="getProjectUnit(5)">Lihat Lebih Banyak</button>
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
  props: [
    'session_user',
    'getproject',
    'getgallery',
    'getunit',
    'projectregion',
    'devregion'
  ],
  data() {
    return {
      forms: {
        unitname: '',
        unitnumber: ''
      },
      projectunit: {
        total: 0,
        results: [],
        isLoading: false,
        currentOffset: 0,
        nextOffset: null
      },
      installment: {
        total: 0,
        results: [],
        isLoading: false
      }
    }
  },
  methods: {
    getProjectUnit( offset, filter )
    {
      if( offset === undefined && this.projectunit.nextOffset === null )
      {
        this.projectunit.nextOffset = 0;
      }
      else
      {
        this.projectunit.nextOffset = this.projectunit.nextOffset + offset;
      }
      this.projectunit.currentOffset = this.projectunit.nextOffset;
      var params = 'unit_name=' + this.forms.unitname + '&unit_number=' + this.forms.unitnumber;

      axios({
        method: 'get',
        url: this.$root.url + '/project/view/unit/' + this.getproject.project_id + '?offset=' + this.projectunit.currentOffset + '&' + params
      }).then( res => {
        let result = res.data;
        if( this.projectunit.results.length === 0 )
        {
          this.projectunit.results = result.results.data;
        }
        else
        {
          let data = result.results;
          if( data.total !== 0 )
          {
            for( let i = 0; i < data.total; i++ )
            {
              this.projectunit.results.push(data.data[i]);
            }
          }
        }
        this.projectunit.results.total = this.projectunit.results.length;
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

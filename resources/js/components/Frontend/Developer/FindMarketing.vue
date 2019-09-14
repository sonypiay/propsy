<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Cari Marketing</div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.column">
            <option value="mkt_fullname">Nama Lengkap</option>
            <option value="mkt_email">Email</option>
            <option value="mkt_mobile_phone">No. Handphone</option>
          </select>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.city">
            <option value="all">Semua Kota</option>
            <option v-for="city in getarea" :value="city.area_id">{{ city.area_name }}</option>
          </select>
        </div>
        <div>
          <select class="uk-select dash-form-input" v-model="forms.sorting">
            <option value="asc">A - Z</option>
            <option value="desc">Z - A</option>
          </select>
        </div>
        <div>
          <div class="uk-inline">
            <span class="uk-form-icon" uk-icon="search"></span>
            <input @keyup.enter="" type="search" v-model="forms.keywords" class="uk-input dash-form-input" placeholder="Masukkan kata kunci...">
          </div>
        </div>
      </div>
      <div class="uk-margin uk-overflow-auto">
        <table class="uk-table uk-table-responsive uk-table-divider uk-table-middle uk-table-small">
          <thead>
            <tr>
              <th>Aksi</th>
              <th>Nama</th>
              <th>Telepon / Handphone</th>
              <th>Email</th>
              <th>Kota</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="mkt in marketingList.results">
              <td></td>
              <td>{{ mkt.mkt_fullname }}</td>
              <td>{{ mkt.mkt_mobile_phone }} / {{ mkt.mkt_phone_number }}</td>
              <td>{{ mkt.mkt_email }}</td>
              <td>{{ mkt.area_name }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getarea'],
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        column: 'mkt_fullname',
        sorting: 'asc',
        city: 'all'
      },
      marketingList: {
        currentOffset: 0,
        total: 0,
        results: [],
        isUpdating: true
      }
    }
  },
  methods: {
    getMarketingList( offset )
    {
      if( offset !== undefined )
      {
        if( this.marketingList.isUpdating === true )
          this.marketingList.currentOffset = this.marketingList.currentOffset + offset;
      }

      var param = 'offset=' + this.marketingList.currentOffset +
      '&keywords=' + this.forms.keywords +
      '&city=' + this.forms.city +
      '&column=' + this.forms.column +
      '&sorting=' + this.forms.sorting;
      var url = this.$root.url + '/developer/marketing/list_marketing?' + param;

      axios.get( url ).then( res => {
        let result = res.data;
        if( this.marketingList.total === 0 )
        {
          this.marketingList.results = result.results.data;
        }
        else
        {
          let data = result.results;
          if( data.total === 0 )
          {
            this.marketingList.isUpdating = false;
          }
          else
          {
            data.data.forEach( d => { this.marketingList.results.push(d); });
          }
        }
        this.marketingList.total = this.marketingList.results.length;
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

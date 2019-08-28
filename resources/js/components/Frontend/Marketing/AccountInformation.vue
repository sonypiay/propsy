<template>
  <div>
    <div class="uk-heading-line uk-text-center uk-margin-bottom side-content-profile-heading"><span>Informasi Akun</span></div>
    <div v-show="errors.errorMessage" class="uk-margin uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
    <form class="uk-form-stacked uk-grid-small content-form" @submit.prevent="onChangeEmail" uk-grid>
      <div class="uk-width-1-2">
        <label class="content-form-label">Nama Lengkap</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.fullname" class="uk-input content-form-input">
        </div>
        <div v-show="errors.name.fullname" class="uk-text-danger uk-text-small">{{ errors.name.fullname }}</div>
      </div>
      <div class="uk-width-1-2">
        <label class="content-form-label">Username</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.username" class="uk-input content-form-input">
        </div>
        <div v-show="errors.name.username" class="uk-text-danger uk-text-small">{{ errors.name.username }}</div>
      </div>
      <div class="uk-width-1-2">
        <label class="content-form-label">Telepon Kantor / Rumah</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.phone_number" class="uk-input content-form-input">
        </div>
      </div>
      <div class="uk-width-1-2">
        <label class="content-form-label">No. Handphone / Whatsapp </label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.mobile_phone" class="uk-input content-form-input">
        </div>
      </div>
      <div class="uk-width-1-2">
        <label class="content-form-label">Provinsi</label>
        <div class="uk-form-controls">
          <select class="uk-select content-form-input" v-model="forms.region" @change="getRegionData()">
            <option value="">-- Pilih --</option>
            <option v-for="reg in getregion" :value="reg.area_id">{{ reg.area_name }}</option>
          </select>
        </div>
      </div>
      <div class="uk-width-1-2">
        <label class="content-form-label">Kota</label>
        <div class="uk-form-controls">
          <select class="uk-select content-form-input" v-model="forms.city">
            <option value="">-- Pilih --</option>
            <option v-for="city in getcity" :value="city.area_id">{{ city.area_name }}</option>
          </select>
        </div>
      </div>
      <div class="uk-width-1-1">
        <label class="content-form-label">Deskripsikan Anda</label>
        <div class="uk-form-controls">
          <textarea class="uk-textarea uk-height-small content-form-input" v-model="forms.biography"></textarea>
        </div>
      </div>
      <div class="uk-width-1-1">
        <button class="uk-button uk-button-primary content-form-btn" v-html="forms.submit"></button>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'isMenuActive'],
  data() {
    return {
      forms: {
        fullname: this.session_user.mkt_fullname,
        phone_number: this.session_user.mkt_phone_number,
        mobile_phone: this.session_user.mkt_mobile_phone,
        city: this.session_user.mkt_city === null ? '' : this.session_user.mkt_city,
        region: this.session_user.mkt_region === null ? '' : this.session_user.mkt_region,
        biography: this.session_user.mkt_biography,
        username: this.session_user.mkt_username,
        submit: 'Simpan'
      },
      getregion: {},
      getcity: {},
      errors: {
        name: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    getRegionData()
    {
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/provinsi/all'
      }).then( res => {
        let results = res.data;
        this.getregion = results.results.data
        this.getCityData();
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    getCityData()
    {
      var region = 0;
      if( this.forms.region !== '' ) region = this.forms.region;
      axios({
        method: 'get',
        url: this.$root.url + '/api/region/kabupaten/all/' + region
      }).then( res => {
        let results = res.data;
        this.getcity = results.results.data.kabupaten;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onChangeEmail()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.fullname === '' )
      {
        this.errors.name.fullname = 'Nama lengkap tidak boleh kosong';
        this.errors.iserror = true;
      }
      if( this.forms.username === '' )
      {
        this.errors.name.username = 'Username tidak boleh kosong';
        this.errors.iserror = true;
      }
      if( this.forms.fullname === '' )
      {
        this.errors.name.fullname = 'Nama lengkap tidak boleh kosong';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/marketing/profile/change_account_information',
        params: this.forms
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Informasi Akun berhasil disimpan.',
          icon: 'success'
        });
        this.forms.submit = 'Simpan';
      }).catch( err => {
        if( err.response.status === 500 ) this.errors.errorMessage = err.response.statusText;
        else this.errors.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Simpan';
      });
    }
  },
  mounted() {
    this.getRegionData();
  }
}
</script>

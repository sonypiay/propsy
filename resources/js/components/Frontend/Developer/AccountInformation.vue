<template>
  <div>
    <div class="uk-heading-line uk-text-center uk-margin-bottom side-content-profile-heading"><span>Informasi Akun</span></div>
    <div v-show="errors.errorMessage" class="uk-margin uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
    <form class="uk-form-stacked uk-grid-small content-form" @submit.prevent="onUpdateAccountInfo" uk-grid>
      <div class="uk-width-1-3">
        <label class="uk-form-label content-form-label">Nama Pengembang</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.name" class="uk-input content-form-input">
        </div>
        <div v-show="errors.name.name" class="uk-text-danger uk-text-small">{{ errors.name.name }}</div>
      </div>
      <div class="uk-width-1-3">
        <label class="uk-form-label content-form-label">Nama Pemilik</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.ownername" class="uk-input content-form-input">
        </div>
        <div v-show="errors.name.ownername" class="uk-text-danger uk-text-small">{{ errors.name.ownername }}</div>
      </div>
      <div class="uk-width-1-3">
        <label class="uk-form-label content-form-label">Username</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.username" class="uk-input content-form-input">
        </div>
        <div v-show="errors.name.username" class="uk-text-danger uk-text-small">{{ errors.name.username }}</div>
      </div>
      <div class="uk-width-1-2">
        <label class="uk-form-label content-form-label">Telepon Kantor</label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.phone_office" class="uk-input content-form-input">
        </div>
      </div>
      <div class="uk-width-1-2">
        <label class="uk-form-label content-form-label">No. Handphone / Whatsapp </label>
        <div class="uk-form-controls">
          <input type="text" v-model="forms.mobile_phone" class="uk-input content-form-input">
        </div>
      </div>
      <div class="uk-width-1-2">
        <label class="uk-form-label content-form-label">Provinsi</label>
        <div class="uk-form-controls">
          <select class="uk-select content-form-input" v-model="forms.region" @change="getCityData()">
            <option value="">-- Pilih --</option>
            <option v-for="reg in getregion" :value="reg.province_id">{{ reg.province_name }}</option>
          </select>
        </div>
      </div>
      <div class="uk-width-1-2">
        <label class="uk-form-label content-form-label">Kota</label>
        <div class="uk-form-controls">
          <select class="uk-select content-form-input" v-model="forms.city">
            <option value="">-- Pilih --</option>
            <option v-for="city in getcity" :value="city.city_id">{{ city.city_name }}</option>
          </select>
        </div>
      </div>
      <div class="uk-width-1-1">
        <label class="uk-form-label content-form-label">Alamat</label>
        <div class="uk-form-controls">
          <textarea class="uk-textarea uk-height-small content-form-input" v-model="forms.address"></textarea>
        </div>
      </div>
      <div class="uk-width-1-1">
        <label class="uk-form-label content-form-label">Tentang Pengembang</label>
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
        name: this.session_user.dev_name,
        ownername: this.session_user.dev_ownername,
        ownership: this.session_user.dev_ownership,
        phone_office: this.session_user.dev_phone_office,
        mobile_phone: this.session_user.dev_mobile_phone,
        city: this.session_user.city_id === null ? '' : this.session_user.city_id,
        region: this.session_user.province_id === null ? '' : this.session_user.province_id,
        biography: this.session_user.dev_biography,
        username: this.session_user.dev_username,
        address: this.session_user.dev_address,
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
        url: this.$root.url + '/api/region/kota/all/' + region
      }).then( res => {
        let results = res.data;
        this.getcity = results.results.data;
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onUpdateAccountInfo()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.name === '' )
      {
        this.errors.name.name = 'Nama Pengembang tidak boleh kosong';
        this.errors.iserror = true;
      }
      if( this.forms.ownername === '' )
      {
        this.errors.name.ownername = 'Nama Pemilik tidak boleh kosong';
        this.errors.iserror = true;
      }
      if( this.forms.username === '' )
      {
        this.errors.name.username = 'Username tidak boleh kosong';
        this.errors.iserror = true;
      }
      if( this.errors.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/developer/profile/change_account_information',
        params: this.forms
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Informasi Akun berhasil disimpan.',
          icon: 'success'
        });
        this.forms.submit = 'Simpan';
        setTimeout(() => { document.location = ''; }, 2000);
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

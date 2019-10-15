<template>
  <div>
    <div class="verification-backtohome uk-margin-bottom">
      <a :href="$root.url + '/developer/profile'"><span uk-icon="icon: chevron-left; ratio: 0.8"></span> Kembali ke Profil</a>
    </div>
    <div class="uk-card uk-card-body uk-card-default verification-container">
      <h2 class="uk-h2 verification-heading">Pengajuan Verifikasi Akun</h2>
      <p class="verification-info">
        Lencana verifikasi hijau <a class="badge-verification badge-verification-small" uk-icon="icon: check; ratio: 0.6"></a> di Propsy memudahkan orang
        mengenali bahwa sebuah akun Pengembang adalah resmi.
        Lencana ditampilkan di samping nama pada profil akun dan di samping nama akun di hasil pencarian.
      </p>
      <!--<p class="verification-info">
        Akun yang tidak memiliki lencana di samping nama mereka, meski lencana tersebut ditampilkan di tempat lain,
        misalnya, di logo perusahaan atau bio, bukan akun terverifikasi.
      </p>-->
      <p class="verification-info">
        Mengajukan verifkasi akun tidak menjamin bahwa akun Anda akan diverifikasi.
      </p>
      <hr>
      <div v-if="session_user.status_verification === 'Y'">
        <div class="uk-alert-success" uk-alert> <span uk-icon="check"></span> Akun anda telah terverifikasi.</div>
      </div>
      <div v-else class="verification-form">
        <div v-show="message.errorMessage" class="uk-margin-bottom uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
        <form class="uk-form-stacked" @submit.prevent="onSubmitRequest">
          <div v-if="getverification === null" class="uk-margin-bottom verification-info"><strong>Silakan lengkapi formulir untuk permohonan verifikasi.</strong></div>
          <div v-else class="uk-margin-bottom">
            <div v-if="getverification.status_verification === 'N'" class="uk-alert-warning uk-text-small" uk-alert>
              Pengajuan verifkasi akun sudah terkirim. Silakan menunggu kembali 1 x 24 jam.
            </div>
            <div v-if="getverification.status_verification === 'R'" class="uk-alert-danger" uk-alert>
              <strong>Sepertinya pengajuan Anda telah ditolak. Silakan lengkapi formulir kembali untuk pengajuan verifikasi.</strong>
            </div>
          </div>
          <div class="uk-margin">
            <div class="uk-form-controls">
              <div class="uk-width-1-1 uk-margin-small-top" uk-form-custom>
                <input accept="image/*" type="file" @change="onGetNpwp">
                <div v-if="forms.npwp.url === ''" class="uk-tile uk-tile-default content-upload-picture">
                  <span uk-icon="icon: plus-circle;"></span>
                  <div class="uk-text-small">Upload / Scan NPWP (jpg atau png)</div>
                </div>
                <div v-else class="content-upload-picture">
                  <img class="uk-width-1-1" :src="forms.npwp.url" />
                </div>
              </div>
              <div v-show="message.errors.npwp" class="uk-text-small uk-text-danger">{{ message.errors.npwp }}</div>
            </div>
          </div>
          <div class="uk-margin">
            <div class="uk-form-controls">
              <div class="uk-width-1-1 uk-margin-small-top" uk-form-custom>
                <input accept="image/*" type="file" @change="onGetCertificate">
                <div v-if="forms.certificate.url === ''" class="uk-tile uk-tile-default content-upload-picture">
                  <span uk-icon="icon: plus-circle;"></span>
                  <div class="uk-text-small">Upload / Scan Sertifikat Resmi (jpg atau png)</div>
                </div>
                <div v-else class="content-upload-picture">
                  <img class="uk-width-1-1" :src="forms.certificate.url" alt="">
                </div>
              </div>
              <div v-show="message.errors.certificate" class="uk-text-small uk-text-danger">{{ message.errors.certificate }}</div>
            </div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label form-label">Dokumen tambahan</label>
            <div class="uk-form-controls">
              <div class="uk-width-1-1" uk-form-custom="target: true">
                <input type="file" accept="application/x-zip-compressed" @change="onGetAdditionalDocument">
                <input class="uk-input uk-width-1-1" type="text" placeholder="Select a zip file" disabled>
                <span class="uk-text-small uk-text-muted"><i>Opsional</i> </span>
              </div>
            </div>
          </div>
          <div class="uk-margin">
            <div v-if="getverification === null">
              <button class="uk-width-1-1 uk-button uk-button-default form-submit-verification" v-html="forms.submit"></button>
            </div>
            <div v-else>
              <button v-if="getverification.status_verification === 'R'" class="uk-width-1-1 uk-button uk-button-default form-submit-verification" v-html="forms.submit"></button>
              <button v-if="getverification.status_verification === 'N'" class="uk-width-1-1 uk-button uk-button-default form-submit-verification" v-html="forms.submit" disabled></button>
            </div>
          </div>
        </form>
      </div>
    </div>
    <div class="uk-text-center uk-text-small uk-text-muted uk-margin-top">
      Copyright &copy; {{ $root.formatDate( new Date(), 'YYYY') }} Propsy, All Rights Reserved.
    </div>
  </div>
</template>

<script>
export default {
  props: ['session_user', 'getverification'],
  data() {
    return {
      forms: {
        npwp: {
          url: '',
          data: ''
        },
        certificate: {
          url: '',
          data: ''
        },
        additional_document: '',
        submit: 'Kirim Permohonan'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    onGetNpwp(event)
    {
      var targetfile = event.target.files;
      this.forms.npwp.url = '';
      this.forms.npwp.data = '';
      if( targetfile.length !== 0 )
      {
        var formatfile = this.$root.getFormatFile( targetfile[0].name );
        if( formatfile === 'jpg' || formatfile === 'png' )
        {
          this.forms.npwp.data = targetfile[0];
          this.forms.npwp.url = URL.createObjectURL(targetfile[0]);
        }
        else
        {
          this.message.errors.npwp = 'Format gambar tidak sesuai';
        }
      }
    },
    onGetCertificate(event)
    {
      var targetfile = event.target.files;
      this.forms.certificate.url = '';
      this.forms.certificate.data = '';
      if( targetfile.length !== 0 )
      {
        var formatfile = this.$root.getFormatFile( targetfile[0].name );
        if( formatfile === 'jpg' || formatfile === 'png' )
        {
          this.forms.certificate.data = targetfile[0];
          this.forms.certificate.url = URL.createObjectURL(targetfile[0]);
        }
        else
        {
          this.message.errors.certificate = 'Format gambar tidak sesuai';
        }
      }
    },
    onGetAdditionalDocument(event)
    {
      var targetfile = event.target.files;
      this.forms.additional_document = '';
      if( targetfile.length !== 0 )
      {
        this.forms.additional_document = targetfile[0];
      }
    },
    onSubmitRequest()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.npwp.url === '' )
      {
        this.message.errors.npwp = 'Silakan unggah foto / scan npwp';
        this.message.iserror = true;
      }
      if( this.forms.certificate.url === '' )
      {
        this.message.errors.certificate = 'Silakan unggah foto / scan sertifikat';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      let url = this.$root.url + '/developer/request_verification';
      let formdata = new FormData();
      formdata.append( 'npwp', this.forms.npwp.data);
      formdata.append( 'certificate', this.forms.certificate.data);
      formdata.append( 'additional_document', this.forms.additional_document === '' ? '' : this.forms.additional_document );
      this.forms.submit = '<span uk-spinner></span>';

      axios.post( url, formdata).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Pengajuan verifikasi akun berhasil terkirim',
          icon: 'success'
        });
        setTimeout(() => { document.location = ''; }, 2000);
        this.forms.submit = 'Kirim Permohonan';
      }).catch( err => {
        this.forms.submit = 'Kirim Permohonan';
        this.message.errorMessage = err.response.statusText;
      });
    }
  }
}
</script>

<style lang="scss" scoped>
.verification-backtohome {
  a {
    color: #555555;
    text-decoration: none;
    font-size: 14px;
  }
}
</style>

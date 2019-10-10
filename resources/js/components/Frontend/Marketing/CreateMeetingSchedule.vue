<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Buat Jadwal Meeting</div>
      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <form class="uk-form-stacked" @submit.prevent="onCreateSchedule">
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Request ID</label>
          <div class="uk-form-controls">
            <input v-if="forms.request_id" type="text" class="uk-width-1-1 uk-input dash-form-input" v-model="forms.request_id" readonly>
            <input v-else type="text" class="uk-width-1-1 uk-input dash-form-input" v-model="forms.request_id" placeholder="Masukkan Request ID">
          </div>
          <div v-show="errors.name.request_id" class="uk-text-small uk-text-danger">{{ errors.name.request_id }}</div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Tanggal</label>
          <div class="uk-form-controls">
            <div class="uk-margin">
              <vue-timepicker
                :format="forms.timepicker.format"
                v-model="forms.timepicker.selectedTime"
              >
              </vue-timepicker>
              <div v-show="errors.name.timepicker" class="uk-text-small uk-text-danger">{{ errors.name.timepicker }}</div>
            </div>
            <div class="uk-margin">
              <v-date-picker
                mode="single"
                v-model="forms.datepicker.selectedDate"
                :formats="forms.datepicker.formats"
                :is-inline="true"
                :select-attribute="forms.datepicker.attributes"
                :input-props="forms.datepicker.props"
                :theme-styles="forms.datepicker.themeStyles"
                show-caps is-expanded
              >
              </v-date-picker>
            </div>
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Pesan</label>
          <div class="uk-form-controls">
            <textarea v-model="forms.meeting_note" class="uk-textarea dash-form-input uk-height-small">
            </textarea>
          </div>
        </div>
        <div class="uk-margin">
          <button class="uk-button uk-button-primary dash-btn" v-html="forms.submit"></button>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import VCalendar from 'v-calendar';
import 'v-calendar/lib/v-calendar.min.css';

import VueTimepicker from 'vue2-timepicker';
import 'vue2-timepicker/dist/VueTimepicker.css';

export default {
  props: ['session_user','getrequest'],
  components: {
    VCalendar,
    'vue-timepicker': VueTimepicker
  },
  data() {
    return {
      forms: {
        request_id: this.getrequest.request_id !== '' ? this.getrequest.request_id : '',
        meeting_note: 'Terima kasih atas ketertarikan Anda untuk membeli properti ' + this.getrequest.unit_name +
        `. Kami mengundang Anda untuk meeting & survey lokasi sehingga kita dapat berdiskusi lebih lanjut. Kami tunggu kabar dari Anda. Hormat kami, Tim Marketing`,
        submit: 'Buat Jadwal',
        timepicker: {
          selectedTime: {
            HH: '09',
            mm: '00'
          },
          format: 'HH:mm'
        },
        datepicker: {
          selectedDate: new Date(),
          props: {
            class: 'uk-width-1-1 uk-input',
            placeholder: 'Masukkan tanggal',
            readonly: true
          },
          attributes: {},
          themeStyles: {},
          formats: {
            title: 'MMMM YYYY',
            weekdays: 'W',
            navMonths: 'MMM',
            input: ['L', 'YYYY-MM-DD', 'YYYY/MM/DD'], // Only for `v-date-picker`
            dayPopover: 'L', // Only for `v-date-picker`
            data: ['L', 'YYYY-MM-DD', 'YYYY/MM/DD'] // For attribute dates
          }
        }
      },
      errors: {
        name: '',
        errorMessage: '',
        iserror: false
      }
    }
  },
  methods: {
    onCreateSchedule()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;
      this.forms.submit = '<span uk-spinner></span>';

      if( this.forms.request_id === '' )
      {
        this.errors.name.request_id = 'Silakan masukkan Request ID';
        this.errors.iserror = true;
      }

      if( this.forms.timepicker.selectedTime.HH === '' || this.forms.timepicker.selectedTime.mm === '' )
      {
        this.errors.name.timepicker = 'Silakan pilih jam meeting';
        this.errors.iserror = true;
      }

      if( this.errors.iserror === true ) return false;

      let tanggal_meeting = this.$root.formatDate( this.forms.datepicker.selectedDate, 'YYYY-MM-DD' );
      let jam_meeting = this.forms.timepicker.selectedTime.HH + ':' + this.forms.timepicker.selectedTime.mm;

      axios({
        method: 'post',
        url: this.$root.url + '/marketing/meeting/create_schedule/' + this.forms.request_id,
        params: {
          tanggal_meeting: tanggal_meeting,
          jam_meeting: jam_meeting,
          note: this.forms.meeting_note
        }
      }).then( res => {
        swal({
          title: 'Sukses',
          text: 'Jadwal meeting berhasil dibuat',
          icon: 'success',
          timer: 3000
        });

        setTimeout(() => {
          document.location = this.$root.url + '/marketing/meeting/meeting_list';
        }, 2000);
      }).catch( err => {
        this.forms.submit = 'Buat Jadwal';
        this.errors.errorMessage = err.response.statusText;
      });
    },
    onFindRequest()
    {

    }
  }
}
</script>

<style lang="scss" scoped>
</style>

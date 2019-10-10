<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Edit Jadwal Meeting</div>
      <div v-show="errors.errorMessage" class="uk-alert-danger" uk-alert>{{ errors.errorMessage }}</div>
      <form class="uk-form-stacked" @submit.prevent="onUpdateSchedule">
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Request ID</label>
          <div class="uk-form-controls">
            <input type="text" class="uk-width-1-1 uk-input dash-form-input" v-model="forms.request_id" readonly>
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Tanggal</label>
          <div class="uk-form-controls">
            <div v-show="getmeeting.meeting_status !== 'done'" class="uk-margin">
              <vue-timepicker
                :format="forms.timepicker.format"
                v-model="forms.timepicker.selectedTime"
              >
              </vue-timepicker>
              <div v-show="errors.name.timepicker" class="uk-text-small uk-text-danger">{{ errors.name.timepicker }}</div>
            </div>
            <div :class="{'uk-margin': getmeeting.meeting_status !== 'done'}">
              <div v-if="getmeeting.meeting_status === 'done'">
                <input class="uk-input dash-form-input" :value="$root.formatDate( getmeeting.meeting_time, 'dddd, DD MMMM YYYY HH:mm' )" disabled>
              </div>
              <div v-else>
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
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Pesan</label>
          <div class="uk-form-controls">
            <textarea v-model="forms.meeting_note" class="uk-textarea dash-form-input uk-height-small" :disabled="getmeeting.meeting_status === 'done'"></textarea>
          </div>
        </div>
        <div class="uk-margin">
          <label class="uk-form-label dash-form-label">Status</label>
          <div class="uk-form-controls">
            <select class="uk-select dash-form-input" v-model="forms.status_meeting" :disabled="getmeeting.meeting_status === 'done'">
              <option value="revision">Revisi</option>
              <option value="done">Selesai</option>
            </select>
          </div>
        </div>
        <div v-show="forms.status_meeting === 'done'" class="uk-margin">
          <label class="uk-form-label dash-form-label">Catatan Hasil Meeting</label>
          <div class="uk-form-controls">
            <textarea class="uk-textarea dash-form-input uk-height-small" v-model="forms.meeting_result"></textarea>
          </div>
          <div v-show="errors.name.meeting_result" class="uk-text-small uk-text-danger">
            {{ errors.name.meeting_result }}
          </div>
        </div>
        <div v-show="forms.status_meeting === 'done'" class="uk-margin">
          <label class="uk-form-label dash-form-label">Upload Dokumen Penting</label>
          <div class="uk-form-controls">
            <div class="uk-width-1-1 uk-placeholder uk-text-center" uk-form-custom>
              <span uk-icon="icon: cloud-upload"></span>
              <span class="uk-text-middle">Dokumen dalam bentuk PDF / ZIP</span>
              <input type="file" id="selectedFile" @change="selectedFile" />
            </div>
            <div v-show="errors.name.document_file" class="uk-text-small uk-text-danger">
              {{ errors.name.document_file }}
            </div>
            <div v-show="forms.document_file.isSelected" class="uk-text-small">{{ forms.document_file.data.name }} akan diupload</div>
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
  props: ['session_user','getrequest', 'getmeeting'],
  components: {
    VCalendar,
    'vue-timepicker': VueTimepicker
  },
  data() {
    return {
      forms: {
        request_id: this.getrequest.request_id,
        meeting_note: this.getmeeting.meeting_note,
        status_meeting: this.getmeeting.meeting_status !== 'done' ? 'revision' : this.getmeeting.meeting_status,
        meeting_result: this.getmeeting.meeting_result === null ? '' : this.getmeeting.meeting_result,
        document_file: {
          data: {},
          isSelected: false
        },
        submit: 'Update Jadwal',
        timepicker: {
          selectedTime: {
            HH: this.$root.formatDate( this.getmeeting.meeting_time, 'HH' ),
            mm: this.$root.formatDate( this.getmeeting.meeting_time, 'mm' )
          },
          format: 'HH:mm'
        },
        datepicker: {
          selectedDate: new Date( this.getmeeting.meeting_time ),
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
    selectedFile( event )
    {
      var targetFile = event.target.files;
      this.forms.document_file.data = {};
      this.forms.document_file.isSelected = false;
      if( targetFile.length !== 0 )
      {
        this.forms.document_file.data = targetFile[0];
        this.forms.document_file.isSelected = true;
      }
    },
    onUpdateSchedule()
    {
      this.errors.name = {};
      this.errors.errorMessage = '';
      this.errors.iserror = false;

      if( this.forms.timepicker.selectedTime.HH === '' || this.forms.timepicker.selectedTime.mm === '' )
      {
        this.errors.name.timepicker = 'Silakan pilih jam meeting';
        this.errors.iserror = true;
      }
      if( this.forms.status_meeting === 'done' )
      {
        if( this.forms.meeting_result === '' )
        {
          this.errors.name.meeting_result = 'Catatan hasil meeting harap diisi';
          this.errors.iserror = true;
        }
        if( this.forms.document_file.isSelected === false && this.getmeeting.document_file === null )
        {
          this.errors.name.document_file = 'Dokumen harap diupload';
          this.errors.iserror = true;
        }
      }

      if( this.errors.iserror === true ) return false;

      let tanggal_meeting = this.$root.formatDate( this.forms.datepicker.selectedDate, 'YYYY-MM-DD' );
      let jam_meeting = this.forms.timepicker.selectedTime.HH + ':' + this.forms.timepicker.selectedTime.mm;
      let url = this.$root.url + '/marketing/meeting/update_schedule/' + this.forms.request_id;

      if( this.forms.status_meeting === 'done' )
      {
        var ax;
        var fd = new FormData();
        var documentfile = '';
        var getformat = this.forms.document_file.isSelected === true ? this.$root.getFormatFile( this.forms.document_file.data.name ) : '';
        fd.append('document_file', '');

        if( this.getmeeting.document_file === null )
        {
          if( getformat === 'pdf' || getformat === 'zip' )
          {
            fd.append('document_file', this.forms.document_file.data);
          }
          else
          {
            this.errors.name.document_file = 'Format dokumen tidak valid.';
            this.forms.document_file.isSelected = false;
            this.forms.document_file.data = {};
            return false;
          }
        }
        else
        {
          if( this.forms.document_file.isSelected )
          {
            if( getformat === 'pdf' || getformat === 'zip' )
            {
              fd.append('document_file', this.forms.document_file.data);
            }
            else
            {
              this.errors.name.document_file = 'Format dokumen tidak valid.';
              this.forms.document_file.isSelected = false;
              this.forms.document_file.data = {};
              return false;
            }
          }
        }

        fd.append('meeting_result', this.forms.meeting_result);
        fd.append('status_meeting', this.forms.status_meeting);

        ax = axios.post(url, fd);
      }
      else
      {
        ax = axios({
          method: 'post',
          url: url,
          params: {
            tanggal_meeting: tanggal_meeting,
            jam_meeting: jam_meeting,
            note: this.forms.meeting_note,
            status_meeting: this.forms.status_meeting
          }
        });
      }

      this.forms.submit = '<span uk-spinner></span>';
      ax.then( res => {
        swal({
          title: 'Sukses',
          text: 'Jadwal meeting berhasil diubah',
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
    }
  },
  computed: {

  },
  mounted() {

  }
}
</script>

<style lang="scss" scoped>
</style>

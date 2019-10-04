<template>
  <div>
    <div class="uk-card dashboard-content">
      <div class="uk-card-title uk-margin dashboard-content-heading">Laporan Unit Terjual</div>
      <div class="uk-width-1-1 uk-inline uk-margin">
        <button type="button" class="uk-button uk-button-primary dash-btn" v-html="filterdate.text"></button>
        <div id="dropdown-date" class="uk-width-3-4@xl uk-width-3-4@l uk-width-2-3@m uk-width-1-1@s" uk-dropdown="mode: click">
          <div class="uk-dropdown-grid uk-grid-small" uk-grid>
            <div class="uk-width-expand">
              <v-date-picker
                mode="range"
                v-model="forms.datepicker.selectedDate"
                :formats="forms.datepicker.formats"
                :is-inline="true"
                :select-attribute="forms.datepicker.attributes"
                :input-props="forms.datepicker.props"
                :theme-styles="forms.datepicker.themeStyles"
                show-caps
                is-double-paned
              >
              </v-date-picker>
            </div>
            <div class="uk-width-1-4@xl uk-width-1-4@l uk-width-1-3@m uk-width-1-1@s">
              <ul class="uk-nav uk-dropdown-nav">
                <li><a @click="onFilterRangeDate('today')">Hari ini</a></li>
                <li><a @click="onFilterRangeDate('yesterday')">Kemarin</a></li>
                <li><a @click="onFilterRangeDate('7day')">7 hari terakhir</a></li>
                <li><a @click="onFilterRangeDate('14day')">14 hari terakhir</a></li>
                <li><a @click="onFilterRangeDate('28day')">28 hari terakhir</a></li>
              </ul>
              <div class="uk-margin-small">
                <a @click="onFilterRangeDate()" class="uk-width-1-1 uk-button uk-button-small uk-button-primary">Terapkan Filter</a>
              </div>
              <div class="uk-margin-small">
                <a @click="onClearFilterDate()" class="uk-width-1-1 uk-button uk-button-small uk-button-danger">Hilangkan Filter</a>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="uk-margin uk-grid-small uk-child-width-auto" uk-grid>
        <div>
          <a class="uk-button uk-button-small uk-button-default dash-btn" @click="onSaveAs('pdf')"><span uk-icon="file-pdf"></span> Cetak PDF</a>
        </div>
      </div>
      <div class="uk-margin">
        <table class="uk-table uk-table-responsive uk-table-divider uk-table-middle uk-table-small">
          <thead>
            <tr>
              <th>ID</th>
              <th>Tipe Unit</th>
              <th>Tanggal</th>
              <th>Customer</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="unit in getunit.results">
              <td>{{ unit.request_unique_id }}</td>
              <td>{{ unit.unit_name }}</td>
              <td>{{ $root.formatDate( unit.created_at, 'dddd, DD MMM YYYY' ) }}</td>
              <td>{{ unit.customer_name }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>
</template>

<script>
import VCalendar from 'v-calendar';
import 'v-calendar/lib/v-calendar.min.css';

export default {
  props: [],
  components: {
    VCalendar
  },
  data() {
    return {
      forms: {
        status_request: ['sold'],
        datepicker: {
          selectedDate: {
            start: new Date(),
            end: new Date()
          },
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
      filterdate: {
        value: '',
        text: this.$root.formatDate( new Date(), 'MMM DD, YYYY' ) + ' <span uk-icon="chevron-down"></span>'
      },
      getunit: {
        total: 0,
        results: [],
        isLoading: false,
        paginate: {
          current_page: 1,
          last_page: 1,
          prev_page_url: null,
          next_page_url: null
        }
      },
      errors: {
        errorMessage: ''
      }
    }
  },
  methods: {
    onFilterRangeDate( val )
    {
      let datepicker = this.forms.datepicker.selectedDate;
      let icon_chevron = '<span uk-icon="chevron-down"></span>';

      if( val === undefined )
      {
        let start_datepicker = datepicker.start;
        let end_datepicker = datepicker.end;
        start_datepicker = this.$root.formatDate( start_datepicker, 'MMM DD, YYYY' );
        end_datepicker = this.$root.formatDate( end_datepicker, 'MMM DD, YYYY' );
        if( start_datepicker === end_datepicker )
        {
          this.filterdate.text = start_datepicker + ' ' + icon_chevron;
        }
        else
        {
          this.filterdate.text = start_datepicker + ' - ' + end_datepicker + ' ' + icon_chevron;
        }
      }
      else
      {
        if( val === 'today' )
        {
          datepicker.start = new Date();
          datepicker.end = new Date();

          let start_datepicker = this.$root.formatDate( datepicker.start, 'MMM DD, YYYY' );
          this.filterdate.text = start_datepicker + ' ' + icon_chevron;
        }
        else if( val === 'yesterday' )
        {
          let dt = new Date();
          let yesterday = dt.setDate( dt.getDate() - 1 );
          datepicker.start = new Date( yesterday );
          datepicker.end = new Date( yesterday );

          let start_datepicker = this.$root.formatDate( datepicker.start, 'MMM DD, YYYY' );
          this.filterdate.text = start_datepicker + ' ' + icon_chevron;
        }
        else
        {
          let dt          = new Date(),
              startDate   = new Date(),
              endDate     = new Date();

          if( val === '7day' )
          {
            startDate = dt.setDate( dt.getDate() - 7 );
            dt = new Date();
            endDate = dt.setDate( dt.getDate() - 1 );
          }
          else if( val === '14day' )
          {
            startDate = dt.setDate( dt.getDate() - 14 );
            dt = new Date();
            endDate = dt.setDate( dt.getDate() - 1 );
          }
          else if( val === '28day' )
          {
            startDate = dt.setDate( dt.getDate() - 28 );
            dt = new Date();
            endDate = dt.setDate( dt.getDate() - 1 );
          }

          datepicker.start = new Date( startDate );
          datepicker.end = new Date( endDate );

          let start_datepicker = this.$root.formatDate( datepicker.start, 'MMM DD, YYYY' );
          let end_datepicker = this.$root.formatDate( datepicker.end, 'MMM DD, YYYY' );
          this.filterdate.text = start_datepicker + ' - ' + end_datepicker + ' ' + icon_chevron;
        }
      }
      this.getReportUnit();
      UIkit.dropdown('#dropdown-date').hide();
    },
    onClearFilterDate()
    {
      var datepicker = this.forms.datepicker.selectedDate;
      datepicker.start = new Date();
      datepicker.end = new Date();
      let start_datepicker = this.$root.formatDate( datepicker.start, 'MMM DD, YYYY' );
      this.filterdate.text = start_datepicker + ' <span uk-icon="chevron-down"></span>'
      this.filterdate.value = '';
      UIkit.dropdown('#dropdown-date').hide();
    },
    getReportUnit( p )
    {
      let datepicker = this.forms.datepicker.selectedDate;
      let start_datepicker = this.$root.formatDate( datepicker.start, 'YYYY-MM-DD' );
      let end_datepicker = this.$root.formatDate( datepicker.end, 'YYYY-MM-DD' );
      if( start_datepicker === end_datepicker ) end_datepicker = '';

      var param = 'start_date=' + start_datepicker + '&end_date=' + end_datepicker;
      var url = this.$root.url + '/developer/report/get_unit?page=' + this.getunit.paginate.current_page + '&' + param;
      if( p !== undefined ) url = p + '&' + param;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getunit.results = result.data;
        this.getunit.total = result.total;
        this.getunit.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          prev_page_url: result.prev_page_url,
          next_page_url: result.next_page_url
        };
      });
    },
    onSaveAs( file )
    {
      let datepicker = this.forms.datepicker.selectedDate;
      let start_datepicker = this.$root.formatDate( datepicker.start, 'YYYY-MM-DD' );
      let end_datepicker = this.$root.formatDate( datepicker.end, 'YYYY-MM-DD' );
      if( start_datepicker === end_datepicker ) end_datepicker = '';

      var param = 'start_date=' + start_datepicker + '&end_date=' + end_datepicker;
      var url = this.$root.url + '/developer/report/unit/save/' + file + '?' + param;
      window.open( url, '_blank' );
    }
  },
  mounted() {
    this.getReportUnit();
  }
}
</script>

<style lang="css" scoped>
</style>

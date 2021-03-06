require('./bootstrap');

window.Vue = require('vue');
window.swal = require('sweetalert');
window.moment = require('moment');
window.numeral = require('numeral');

Vue.component('login-component', require('./components/ControlPanel/Login.vue').default);
Vue.component('dashboard-component', require('./components/ControlPanel/Dashboard.vue').default);
Vue.component('profile-component', require('./components/ControlPanel/Profile.vue').default);

Vue.component('wilayah-province-component', require('./components/ControlPanel/Wilayah/Province.vue').default);
Vue.component('wilayah-city-component', require('./components/ControlPanel/Wilayah/City.vue').default);
Vue.component('facility-component', require('./components/ControlPanel/Property/Facility.vue').default);
Vue.component('admin-page-component', require('./components/ControlPanel/Manajemen/Admin.vue').default);
Vue.component('developer-page-component', require('./components/ControlPanel/Developer/Developer.vue').default);
Vue.component('marketing-page-component', require('./components/ControlPanel/Developer/Marketing.vue').default);
Vue.component('meetinglist-page-component', require('./components/ControlPanel/Developer/MeetingList.vue').default);
Vue.component('customer-page-component', require('./components/ControlPanel/Customer/Customer.vue').default);
Vue.component('requesthistory-page-component', require('./components/ControlPanel/Customer/RequestHistory.vue').default);
Vue.component('admin-page-component', require('./components/ControlPanel/Manajemen/Admin.vue').default);
Vue.component('project-page-component', require('./components/ControlPanel/Property/Project.vue').default);
Vue.component('projectunit-page-component', require('./components/ControlPanel/Property/ProjectUnit.vue').default);
Vue.component('page-requestverification-component', require('./components/ControlPanel/Developer/RequestVerification.vue').default);

import VueCurrencyFilter from 'vue-currency-filter';
Vue.use(VueCurrencyFilter);

const app = new Vue({
    el: '#app',
    data: {
      url: labmode.url,
      formatNumeral(str, format) {
        if( format === undefined )
          return numeral(str).format();
        else
          return numeral(str).format(format);
      },
      formatDate(str, format, locale) {
        if( locale === undefined ) locale = 'id';
        var res = moment(str).locale(locale).format(format);
        return res;
      },
      toPercentage( current, total )
      {
        return Math.ceil( (current / total) * 100 );
      },
      getFormatFile(files) {
        var length_str_file = files.length;
        var getIndex = files.lastIndexOf(".");
        var getformatfile = files.substring( length_str_file, getIndex + 1 ).toLowerCase();
        return getformatfile;
      },
      htmlStripTags( str, len )
      {
        var string = str.replace(/(<([^>]+)>)/ig, "");
        string = string.substring(0, len);
        return string;
      }
    }
});

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

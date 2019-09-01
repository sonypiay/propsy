require('./bootstrap');

window.Vue = require('vue');
window.swal = require('sweetalert');
window.moment = require('moment');
window.numeral = require('numeral');

Vue.component('modal-login-component', require('./components/Frontend/LoginComponent.vue').default);
Vue.component('modal-signup-component', require('./components/Frontend/SignUpComponent.vue').default);

// marketing
Vue.component('marketing-dashboard-page', require('./components/Frontend/Marketing/Dashboard.vue').default);
Vue.component('marketing-profile-page', require('./components/Frontend/Marketing/Profile.vue').default);

// developer
Vue.component('developer-dashboard-page', require('./components/Frontend/Developer/Dashboard.vue').default);
Vue.component('developer-profile-page', require('./components/Frontend/Developer/Profile.vue').default);
Vue.component('developer-manage-project', require('./components/Frontend/Developer/Projects.vue').default);
Vue.component('developer-project-gallery', require('./components/Frontend/Developer/ProjectGallery.vue').default);

const app = new Vue({
    el: '#app',
    data: {
      url: labmode.url,
      formatNumeral(str, format) {
        return numeral(str).format(format);
      },
      formatDate(str, format, locale) {
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

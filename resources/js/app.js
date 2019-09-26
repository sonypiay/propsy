require('./bootstrap');

window.Vue = require('vue');
window.swal = require('sweetalert');
window.moment = require('moment');
window.numeral = require('numeral');

//Vue.component('modal-login-component', require('./components/Frontend/LoginComponent.vue').default);
//Vue.component('modal-signup-component', require('./components/Frontend/SignUpComponent.vue').default);

// marketing
Vue.component('marketing-dashboard-page', require('./components/Frontend/Marketing/Dashboard.vue').default);
Vue.component('marketing-profile-page', require('./components/Frontend/Marketing/Profile.vue').default);
Vue.component('marketing-request-info', require('./components/Frontend/Marketing/RequestInfo.vue').default);
Vue.component('marketing-register-page', require('./components/Frontend/Marketing/Daftar.vue').default);
Vue.component('marketing-login-page', require('./components/Frontend/Marketing/Masuk.vue').default);

// developer
Vue.component('developer-dashboard-page', require('./components/Frontend/Developer/Dashboard.vue').default);
Vue.component('developer-profile-page', require('./components/Frontend/Developer/Profile.vue').default);
Vue.component('developer-manage-project', require('./components/Frontend/Developer/Projects.vue').default);
Vue.component('developer-project-gallery', require('./components/Frontend/Developer/ProjectGallery.vue').default);
Vue.component('developer-manage-marketing', require('./components/Frontend/Developer/ManageMarketing.vue').default);
Vue.component('developer-detail-project', require('./components/Frontend/Developer/DetailProject.vue').default);
Vue.component('developer-register-page', require('./components/Frontend/Developer/Daftar.vue').default);
Vue.component('developer-login-page', require('./components/Frontend/Developer/Masuk.vue').default);
Vue.component('developer-add-project', require('./components/Frontend/Developer/AddProject.vue').default);
Vue.component('developer-edit-project', require('./components/Frontend/Developer/EditProject.vue').default);
Vue.component('developer-add-unit', require('./components/Frontend/Developer/AddUnit.vue').default);
Vue.component('developer-edit-unit', require('./components/Frontend/Developer/EditUnit.vue').default);

// customer
Vue.component('customer-register-page', require('./components/Frontend/Customer/Daftar.vue').default);
Vue.component('customer-login-page', require('./components/Frontend/Customer/Masuk.vue').default);
Vue.component('customer-profile-page', require('./components/Frontend/Customer/Profile.vue').default);

// main page
Vue.component('homepage-available-project', require('./components/Frontend/HomepageProject.vue').default);
Vue.component('page-view-project', require('./components/Frontend/ViewProject.vue').default);

const app = new Vue({
    el: '#app',
    data: {
      url: labmode.url,
      formatNumeral(str, format) {
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

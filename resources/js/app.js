require('./bootstrap');

window.Vue = require('vue');
window.swal = require('sweetalert');
window.moment = require('moment');
window.numeral = require('numeral');

//Vue.component('modal-login-component', require('./components/Frontend/LoginComponent.vue').default);
//Vue.component('modal-signup-component', require('./components/Frontend/SignUpComponent.vue').default);

// marketing
//Vue.component('marketing-register-page', require('./components/Frontend/Marketing/Daftar.vue').default);
Vue.component('marketing-login-page', require('./components/Frontend/Marketing/Masuk.vue').default);
Vue.component('marketing-dashboard-page', require('./components/Frontend/Marketing/Dashboard.vue').default);
Vue.component('marketing-profile-page', require('./components/Frontend/Marketing/Profile.vue').default);
Vue.component('marketing-request-unit', require('./components/Frontend/Marketing/RequestUnit.vue').default);
Vue.component('marketing-meeting-list', require('./components/Frontend/Marketing/MeetingList.vue').default);
Vue.component('marketing-create-schedule', require('./components/Frontend/Marketing/CreateMeetingSchedule.vue').default);
Vue.component('marketing-update-schedule', require('./components/Frontend/Marketing/UpdateMeetingSchedule.vue').default);
Vue.component('marketing-view-project', require('./components/Frontend/Marketing/Projects.vue').default);
Vue.component('marketing-detail-project', require('./components/Frontend/Marketing/DetailProject.vue').default);

// developer
Vue.component('developer-register-page', require('./components/Frontend/Developer/Daftar.vue').default);
Vue.component('developer-login-page', require('./components/Frontend/Developer/Masuk.vue').default);
Vue.component('developer-dashboard-page', require('./components/Frontend/Developer/Dashboard.vue').default);
Vue.component('developer-profile-page', require('./components/Frontend/Developer/Profile.vue').default);
Vue.component('developer-manage-project', require('./components/Frontend/Developer/Projects.vue').default);
Vue.component('developer-project-gallery', require('./components/Frontend/Developer/ProjectGallery.vue').default);
Vue.component('developer-manage-marketing', require('./components/Frontend/Developer/ManageMarketing.vue').default);
Vue.component('developer-detail-project', require('./components/Frontend/Developer/DetailProject.vue').default);
Vue.component('developer-add-project', require('./components/Frontend/Developer/AddProject.vue').default);
Vue.component('developer-edit-project', require('./components/Frontend/Developer/EditProject.vue').default);
Vue.component('developer-add-unit', require('./components/Frontend/Developer/AddUnit.vue').default);
Vue.component('developer-edit-unit', require('./components/Frontend/Developer/EditUnit.vue').default);
Vue.component('developer-request-unit', require('./components/Frontend/Developer/RequestUnit.vue').default);
Vue.component('developer-report-unitsold', require('./components/Frontend/Developer/Report/UnitSold.vue').default);
Vue.component('developer-report-unitbooked', require('./components/Frontend/Developer/Report/UnitBooked.vue').default);
Vue.component('developer-report-customer', require('./components/Frontend/Developer/Report/Customer.vue').default);
Vue.component('developer-request-verification', require('./components/Frontend/Developer/RequestVerification.vue').default);
Vue.component('developer-reset-password', require('./components/Frontend/Developer/ForgotPassword.vue').default);

// customer
Vue.component('customer-register-page', require('./components/Frontend/Customer/Daftar.vue').default);
Vue.component('customer-login-page', require('./components/Frontend/Customer/Masuk.vue').default);
Vue.component('customer-reset-password', require('./components/Frontend/Customer/ForgotPassword.vue').default);
Vue.component('customer-profile-page', require('./components/Frontend/Customer/Profile.vue').default);
Vue.component('customer-list-request', require('./components/Frontend/Customer/ListRequestUnit.vue').default);
Vue.component('customer-meeting-invitation', require('./components/Frontend/Customer/MeetingInvitation.vue').default);

// main page
Vue.component('homepage-available-project', require('./components/Frontend/HomepageProject.vue').default);
Vue.component('page-view-project', require('./components/Frontend/ViewProject.vue').default);
Vue.component('page-view-unit', require('./components/Frontend/ViewDetailUnit.vue').default);
Vue.component('page-browse-project', require('./components/Frontend/BrowseProject.vue').default);
Vue.component('page-search-project', require('./components/Frontend/SearchProject.vue').default);
Vue.component('page-view-developer', require('./components/Frontend/DeveloperProfile.vue').default);
Vue.component('reset-password-page', require('./components/Frontend/ResetPassword.vue').default);

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

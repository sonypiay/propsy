require('./bootstrap');

window.Vue = require('vue');
window.swal = require('sweetalert');
window.moment = require('moment');
window.numeral = require('numeral');

Vue.component('example-component', require('./components/ExampleComponent.vue').default);

const app = new Vue({
    el: '#app',
    data: {
      url: labmode.url,
      formatNumeral(str, format) {
        return numeral(str).format(format);
      },
      formatDate(str, format) {
        var res = moment(str).locale('en').format(format);
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

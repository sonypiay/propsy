<template>
  <div>
    <div id="modal-admin" uk-modal>
      <div class="uk-modal-dialog uk-modal-body">
        <a class="uk-modal-close uk-modal-close-default" uk-close></a>
        <div class="uk-modal-title">
          <span v-if="forms.isedit">Edit Admin</span>
          <span v-else>Tambah Admin</span>
        </div>
        <form class="uk-form-stacked" @submit.prevent="forms.isedit === false ? addAdmin() : saveAdmin()">
          <div v-show="message.errorMessage" class="uk-margin uk-alert-danger" uk-alert>{{ message.errorMessage }}</div>
          <div class="uk-margin">
            <label class="uk-form-label">Nama</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.admin_fullname}" class="uk-input uk-width-1-1" v-model="forms.admin_fullname" />
            </div>
            <div v-show="message.errors.admin_fullname" class="uk-text-danger">{{ message.errors.admin_fullname }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label">Email</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.admin_email}" class="uk-input uk-width-1-1" v-model="forms.admin_email" />
            </div>
            <div v-show="message.errors.admin_email" class="uk-text-danger">{{ message.errors.admin_email }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label">Username</label>
            <div class="uk-form-controls">
              <input type="text" :class="{'uk-form-danger': message.errors.admin_username}" class="uk-input uk-width-1-1" v-model="forms.admin_username" />
            </div>
            <div v-show="message.errors.admin_username" class="uk-text-danger">{{ message.errors.admin_username }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label">Password</label>
            <div class="uk-form-controls">
              <input type="password" :class="{'uk-form-danger': message.errors.admin_password}" class="uk-input uk-width-1-1" v-model="forms.admin_password" />
            </div>
            <div v-show="message.errors.admin_password" class="uk-text-danger">{{ message.errors.admin_password }}</div>
          </div>
          <div class="uk-margin">
            <label class="uk-form-label">Gender</label>
            <div class="uk-form-controls">
              <select class="uk-select uk-width-1-1" v-model="forms.admin_gender">
                <option value="L">Laki - Laki</option>
                <option value="P">Perempuan</option>
              </select>
            </div>
          </div>
          <div class="uk-margin">
            <button class="uk-button uk-button-primary" v-html="forms.submit"></button>
          </div>
        </form>
      </div>
    </div>
    <div class="uk-container uk-margin-large-top">
      <ul class="uk-breadcrumb">
        <li><a :href="$root.url + '/cp/'">Dashboard</a></li>
        <li class="uk-disabled"><span>Manajemen Admin</span></li>
        <li><span>User Admin</span></li>
      </ul>
      <div class="uk-card uk-card-body uk-card-default">
        <div class="uk-h3 uk-heading-line">User Admin</div>
        <div class="uk-grid-small uk-child-width-auto" uk-grid>
          <div>
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input" v-model="forms.keywords" placeholder="Search..." @keyup.enter="getAdminOwner()" />
            </div>
          </div>
          <div>
            <a @click="onClickModal()" class="uk-button uk-button-primary">Tambah Admin</a>
          </div>
        </div>

        <div class="uk-margin">
          <div v-if="getadmin.total === 0" class="uk-alert-warning" uk-alert>
            Belum ada admin
          </div>
          <div v-else>
            <label class="uk-label">{{ getadmin.total }} admin</label>
            <table class="uk-table uk-table-middle uk-table-striped uk-table-divider uk-table-hover uk-table-small">
              <thead>
                <tr>
                  <th>Aksi</th>
                  <th>Nama</th>
                  <th>Email</th>
                  <th>Username</th>
                  <th>Gender</th>
                </tr>
              </thead>
              <tbody>
                <tr v-for="adm in getadmin.results">
                  <td>
                    <a @click="onClickModal( adm )" class="uk-icon-link uk-margin-small-right" uk-icon="file-edit"></a>
                    <a @click="deleteAdmin( adm.admin_id )" href="#" class="uk-icon-link uk-margin-small-right" uk-icon="trash"></a>
                  </td>
                  <td>{{ adm.admin_fullname }}</td>
                  <td>{{ adm.admin_email }}</td>
                  <td>{{ adm.admin_username }}</td>
                  <td>
                    <span v-if="adm.admin_gender === 'L'">Laki - Laki</span>
                    <span v-else>Perempuan</span>
                  </td>
                </tr>
              </tbody>
            </table>
            <ul class="uk-pagination uk-flex-center">
              <li>
                <a v-if="getadmin.paginate.prev_page_url" @click="getAdminOwner( getadmin.paginate.prev_page_url )">
                  <span uk-pagination-previous></span>
                </a>
                <a v-else>
                  <span uk-pagination-previous></span>
                </a>
              </li>

              <li>
                <a v-if="getadmin.paginate.next_page_url" @click="getAdminOwner( getadmin.paginate.next_page_url )">
                  <span uk-pagination-next></span>
                </a>
                <a v-else>
                  <span uk-pagination-next></span>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: [],
  data() {
    return {
      forms: {
        keywords: '',
        limit: 10,
        admin_fullname: '',
        admin_username: '',
        admin_email: '',
        admin_password: '',
        admin_gender: 'L',
        admin_id: '',
        isedit: false,
        submit: 'Tambah'
      },
      message: {
        errors: {},
        errorMessage: '',
        iserror: false
      },
      getadmin: {
        total: 0,
        results: [],
        paginate: {
          current_page: 1,
          last_page: 1,
          next_page_url: '',
          prev_page_url: ''
        }
      }
    }
  },
  methods: {
    getAdminOwner( p )
    {
      var params = 'keywords=' + this.forms.keywords + '&limit=' + this.forms.limit;
      var url = this.$root.url + '/cp/manajemen/get_user_admin?page=' + this.getadmin.paginate.current_page + '&' + params;
      if( p !== undefined ) url = p + '&' + params;

      axios({
        method: 'get',
        url: url
      }).then( res => {
        let result = res.data;
        this.getadmin.total = result.total;
        this.getadmin.results = result.data;

        this.getadmin.paginate = {
          current_page: result.current_page,
          last_page: result.last_page,
          next_page_url: result.next_page_url,
          prev_page_url: result.prev_page_url
        };
      }).catch( err => {
        console.log( err.response.statusText );
      });
    },
    onClickModal( data )
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( data === undefined )
      {
        this.forms.admin_fullname = '';
        this.forms.admin_email = '';
        this.forms.admin_username = '';
        this.forms.admin_password = '';
        this.forms.admin_gender = 'L';
        this.forms.admin_id = '';
        this.forms.isedit = false;
        this.forms.submit = 'Tambah';
      }
      else
      {
        this.forms.admin_fullname = data.admin_fullname;
        this.forms.admin_email = data.admin_email;
        this.forms.admin_username = data.admin_username;
        this.forms.admin_password = '';
        this.forms.admin_gender = data.admin_gender;
        this.forms.admin_id = data.admin_id;
        this.forms.isedit = true;
        this.forms.submit = 'Simpan';
      }

      UIkit.modal('#modal-admin').show();
    },
    addAdmin()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.admin_fullname === '' )
      {
        this.message.errors.admin_fullname = 'Nama tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.forms.admin_email === '' )
      {
        this.message.errors.admin_email = 'Email tidak boleh kosong';
        this.message.iserror = true;
      }
      if( this.forms.admin_username === '' )
      {
        this.message.errors.admin_username = 'Username tidak boleh kosong';
        this.message.iserror = true;
      }
      if( this.forms.admin_password === '' )
      {
        this.message.errors.admin_password = 'Password tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'post',
        url: this.$root.url + '/cp/manajemen/user_admin/store',
        params: {
          admin_fullname: this.forms.admin_fullname,
          admin_email: this.forms.admin_email,
          admin_username: this.forms.admin_username,
          admin_password: this.forms.admin_password,
          admin_gender: this.forms.admin_gender
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Admin baru berhasil ditambah',
          icon: 'success'
        });
        setTimeout(() => {
          this.getAdminOwner();
          UIkit.modal('#modal-admin').hide();
        }, 1000);
      }).catch( err => {
        if( err.response.status === 500 )
          this.message.errorMessage = err.response.statusText;
        else
          this.message.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Tambah';
      });
    },
    saveAdmin()
    {
      this.message.errors = {};
      this.message.errorMessage = '';
      this.message.iserror = false;

      if( this.forms.admin_fullname === '' )
      {
        this.message.errors.admin_fullname = 'Nama tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.forms.admin_email === '' )
      {
        this.message.errors.admin_email = 'Email tidak boleh kosong';
        this.message.iserror = true;
      }
      if( this.forms.admin_username === '' )
      {
        this.message.errors.admin_username = 'Username tidak boleh kosong';
        this.message.iserror = true;
      }

      if( this.message.iserror === true ) return false;

      this.forms.submit = '<span uk-spinner></span>';
      axios({
        method: 'put',
        url: this.$root.url + '/cp/manajemen/user_admin/save/' + this.forms.admin_id,
        params: {
          admin_fullname: this.forms.admin_fullname,
          admin_email: this.forms.admin_email,
          admin_username: this.forms.admin_username,
          admin_password: this.forms.admin_password,
          admin_gender: this.forms.admin_gender
        }
      }).then( res => {
        swal({
          title: 'Berhasil',
          text: 'Admin berhasil disimpan',
          icon: 'success'
        });
        setTimeout(() => {
          this.getAdminOwner();
          UIkit.modal('#modal-admin').hide();
        }, 1000);
      }).catch( err => {
        if( err.response.status === 500 )
          this.message.errorMessage = err.response.statusText;
        else
          this.message.errorMessage = err.response.data.statusText;
        this.forms.submit = 'Simpan';
      });
    },
    deleteAdmin( id )
    {
      swal({
        title: 'Konfirmasi',
        text: 'Apakah anda ingin menghapus user ini?',
        icon: 'warning',
        dangerMode: true,
        buttons: {
          cancel: 'Batal',
          confirm: { value: true, text: 'Ya' }
        }
      }).then( val => {
        if( val )
        {
          axios({
            method: 'delete',
            url: this.$root.url + '/cp/manajemen/user_admin/delete/' + id
          }).then( res => {
            swal({
              title: 'Berhasil',
              text: 'Admin berhasil dihapus',
              icon: 'success'
            });
            setTimeout(() => {
              this.getAdminOwner();
            }, 1000);
          }).catch( err => {
            swal({
              title: 'Whoops',
              text: 'Terjadi kesalahan',
              icon: 'error'
            });
          });
        }
      });
    }
  },
  mounted() {
    this.getAdminOwner();
  }
}
</script>

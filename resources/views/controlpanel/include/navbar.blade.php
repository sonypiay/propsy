<header class="uk-box-shadow-small header">
  <div class="uk-container">
    <div class="uk-navbar navbar" uk-navbar>
      <div class="uk-navbar-left">
        <ul class="uk-navbar-nav">
          <li><a href="#">Dashboard</a></li>
          <li>
            <a href="#">Developer <span uk-icon="chevron-down"></span> </a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('cp_developer_page') }}">Developer</a></li>
                <li><a href="{{ route('cp_request_verification_page') }}">Pengajuan Verifikasi</a></li>
                <li><a href="{{ route('cp_marketing_page') }}">Marketing <span class="uk-float-right" uk-icon="chevron-right"></span> </a>
                  <div class="uk-navbar-dropdown" uk-dropdown="pos: right; offset: 25">
                    <ul class="uk-nav uk-navbar-dropdown-nav">
                      <li><a href="{{ route('cp_meeting_page') }}">Jadwal Meeting</a></li>
                    </ul>
                  </div>
                </li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Pelanggan <span uk-icon="chevron-down"></span></a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('cp_customer_page') }}">Pelanggan</a></li>
                <li><a href="{{ route('cp_request_history_page') }}">Riwayat Pengajuan Unit</a></li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Properti <span uk-icon="chevron-down"></span></a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('cp_project_list_page') }}">Proyek</a></li>
                <li><a href="{{ route('cp_project_unit_page') }}">Tipe Unit</a></li>
                <li><a href="{{ route('cp_facility_page') }}">Fasilitas</a></li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Manajemen <span uk-icon="chevron-down"></span></a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('cp_admin_page') }}">User Admin</a></li>
                <li><a href="{{ route('cp_province_page') }}">Provinsi</a></li>
                <li><a href="{{ route('cp_city_page') }}">Kota</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
      <div class="uk-navbar-right">
        <ul class="uk-navbar-nav">
          <li>
            <a href="#">{{ $session_user->admin_fullname }} <span uk-icon="chevron-down"></span></a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('cp_account_profile_page', ['pagenav' => 'profile']) }}">Akun Saya</a></li>
                <li><a href="{{ route('cp_logout') }}">Keluar</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
    </div>

  </div>
</header>

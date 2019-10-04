<header class="header">
  <div class="uk-container">
    <div class="uk-navbar navbar" uk-navbar>
      <div class="uk-navbar-left">
        <ul class="uk-navbar-nav">
          <li><a href="#">Dashboard</a></li>
          <li>
            <a href="#">Developer <span uk-icon="chevron-down"></span> </a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="#">Daftar Developer</a></li>
                <li><a href="#">Pengajuan Verifikasi</a></li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Pelanggan <span uk-icon="chevron-down"></span></a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="#">Daftar Pelanggan</a></li>
                <li><a href="#">Pengajuan Verifikasi</a></li>
                <li><a href="#">Riwayat Pengajuan Unit</a></li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Proyek</a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="#">Daftar Proyek</a></li>
                <li><a href="#">Daftar Proyek Unit</a></li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Wilayah <span uk-icon="chevron-down"></span></a>
            <div class="uk-navbar-dropdown">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="#">Provinsi</a></li>
                <li><a href="#">Kota</a></li>
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
                <li><a href="{{ route('cp_account_profile_page', ['pagenav' => 'email']) }}">Ganti Email</a></li>
                <li><a href="{{ route('cp_account_profile_page', ['pagenav' => 'password']) }}">Ganti Password</a></li>
                <li><a href="{{ route('cp_account_profile_page', ['pagenav' => 'profile']) }}">Ubah Akun</a></li>
                <li><a href="#">Keluar</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
    </div>

  </div>
</header>

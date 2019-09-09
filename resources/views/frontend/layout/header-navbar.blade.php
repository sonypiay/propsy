<header class="uk-box-shadow-small main-header" uk-sticky="top: 100; animation: uk-animation-slide-top; bottom: #sticky-on-scroll-up">
  <div class="uk-container">
    <nav class="uk-navbar main-navbar" uk-navbar>
      <div class="uk-navbar-left">
        <a class="uk-navbar-item uk-logo navbar-logo" href="{{ url('/') }}">
          <img src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="maps">
        </a>
        <ul class="uk-navbar-nav main-nav">
          <li><a href="#">Pengembang</a>
            <div class="uk-navbar-dropdown dropdown-main-navbar">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('developer_register_page') }}">Daftar</a></li>
                <li><a href="{{ route('developer_login_page') }}">Login</a></li>
              </ul>
            </div>
          </li>
          <li><a href="#">Marketing</a>
            <div class="uk-navbar-dropdown dropdown-main-navbar">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('marketing_register_page') }}">Daftar</a></li>
                <li><a href="{{ route('marketing_login_page') }}">Login</a></li>
              </ul>
            </div>
          </li>
        </ul>
      </div>
      <div class="uk-navbar-right">
        <ul class="uk-navbar-nav main-nav">
          @if( session()->has('isMarketing') )
          <li>
            <a href="#">{{ $session_user->mkt_fullname }}</a>
            <div class="uk-navbar-dropdown main-nav-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li><a href="{{ route('marketing_dashboard_page') }}">Dashboard</a></li>
                <li><a href="{{ route('marketing_profile_page') }}">Lihat Akun</a></li>
                <li class="uk-nav-divider"></li>
                <li><a href="{{ route('auth_logout_mkt') }}">Keluar</a></li>
              </ul>
            </div>
          </li>
          @elseif( session()->has('isDeveloper') )
          <li>
            <a href="#">{{ $session_user->dev_ownername }}</a>
            <div class="uk-navbar-dropdown main-nav-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li><a href="{{ route('developer_dashboard_page') }}">Dashboard</a></li>
                <li><a href="{{ route('developer_profile_page') }}">Lihat Akun</a></li>
                <li class="uk-nav-divider"></li>
                <li><a href="{{ route('auth_logout_dev') }}">Keluar</a></li>
              </ul>
            </div>
          </li>
          @else
          <li>
            <a class="navlogin" uk-toggle="target: #modal-login">
              <span>Masuk</span>
            </a>
          </li>
          <li>
            <a class="navjoin" uk-toggle="target: #modal-signup">
              <span>Daftar</span>
            </a>
          </li>
          @endif
        </ul>
      </div>
    </nav>
  </div>
</header>

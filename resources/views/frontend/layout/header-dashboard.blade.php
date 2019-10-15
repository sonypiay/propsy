<header class="uk-box-shadow-small main-header" uk-sticky="top: 100; animation: uk-animation-slide-top; bottom: true">
  <div class="uk-container">
    <nav class="uk-navbar main-navbar" uk-navbar>
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
                @if( $session_user->status_verification === 'N' )
                <li><a href="{{ route('developer_request_verification') }}">Verifikasi Akun</a></li>
                @endif
                <li class="uk-nav-divider"></li>
                <li><a href="{{ route('auth_logout_dev') }}">Keluar</a></li>
              </ul>
            </div>
          </li>
          @else
          <li>
            <a href="{{ route('developer_login_page') }}">
              Masuk / Daftar
            </a>
          </li>
          @endif
        </ul>
      </div>
    </nav>
  </div>
</header>

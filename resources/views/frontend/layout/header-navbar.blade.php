<header class="uk-box-shadow-small main-header">
  <div class="uk-container">
    <nav class="uk-navbar main-navbar" uk-navbar>
      <div class="uk-navbar-left">
        <a class="uk-navbar-item uk-logo navbar-logo" href="{{ url('/') }}">
          <img src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="maps">
        </a>
        @if( ! session()->has('isDeveloper') AND ! session()->has('isMarketing') AND ! session()->has('isCustomer') )
        <ul class="uk-navbar-nav main-nav">
          <li><a href="{{ route('developer_register_page') }}">Menjadi Pengembang</a></li>
          <li><a href="{{ route('marketing_register_page') }}">Menjadi Marketing</a></li>
        </ul>
        @endif
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
          @elseif( session()->has('isCustomer') )
          <li>
            <a href="#">{{ $session_user->customer_name }}</a>
            <div class="uk-navbar-dropdown main-nav-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li><a href="#">Permintaan</a></li>
                <li><a href="#">Survey</a></li>
                <li><a href="{{ route('customer_profile_page') }}">Lihat Akun</a></li>
                <li class="uk-nav-divider"></li>
                <li><a href="{{ route('auth_logout_customer') }}">Keluar</a></li>
              </ul>
            </div>
          </li>
          @else
          <li>
            <a href="#">Masuk</a>
            <div class="uk-navbar-dropdown dropdown-main-navbar">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('developer_login_page') }}">Sebagai Pengembang</a></li>
                <li><a href="{{ route('marketing_login_page') }}">Sebagai Marketing</a></li>
                <li><a href="{{ route('customer_login_page') }}">Sebagai Konsumen</a></li>
              </ul>
            </div>
          </li>
          <li>
            <a href="#">Daftar</a>
            <div class="uk-navbar-dropdown dropdown-main-navbar">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('developer_register_page') }}">Sebagai Pengembang</a></li>
                <li><a href="{{ route('marketing_register_page') }}">Sebagai Marketing</a></li>
                <li><a href="{{ route('customer_register_page') }}">Sebagai Konsumen</a></li>
              </ul>
            </div>
          </li>
          @endif
        </ul>
      </div>
    </nav>
  </div>
</header>

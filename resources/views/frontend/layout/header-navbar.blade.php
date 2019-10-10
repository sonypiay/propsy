<header class="uk-box-shadow-small main-header">
  <div class="uk-container">
    <nav class="uk-navbar main-navbar" uk-navbar>
      <div class="uk-navbar-left">
        <a class="uk-navbar-item uk-logo navbar-logo" href="{{ url('/') }}">
          <img src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="maps">
        </a>
        <div class="uk-navbar-item">
          <form class="uk-form-stacked" action="{{ route('page_search_project') }}" method="get">
            <div class="uk-inline">
              <span class="uk-form-icon" uk-icon="search"></span>
              <input type="search" class="uk-input header-searchbar" value="{{ $request->keywords }}" name="keywords" placeholder="Cari proyek, tipe unit, pengembang..." />
            </div>
          </form>
        </div>
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
            <a href="#">{{ $session_user->customer_name }} @if( $hasrequest > 0 )<span class="uk-float-right notif"></span>@endif </a>
            <div class="uk-navbar-dropdown main-nav-dropdown">
              <ul class="uk-nav uk-dropdown-nav">
                <li><a href="{{ route('customer_request_page') }}">Pemesanan</a></li>
                <li><a href="{{ route('customer_meeting_page') }}">Jadwal Meeting @if( $hasrequest > 0 )<label class="uk-float-right newinvite">{{ $hasrequest }}</label>@endif </a></li>
                <li><a href="{{ route('customer_profile_page') }}">Lihat Akun</a></li>
                <li class="uk-nav-divider"></li>
                <li><a href="{{ route('auth_logout_customer') }}">Keluar</a></li>
              </ul>
            </div>
          </li>
          @else
          @if( ! session()->has('isDeveloper') AND ! session()->has('isCustomer') )
          <li><a href="{{ route('developer_register_page') }}">Menjadi Pengembang</a></li>
          @endif
          <li>
            <a href="#">Masuk / Daftar</a>
            <div class="uk-navbar-dropdown dropdown-main-navbar">
              <ul class="uk-nav uk-navbar-dropdown-nav">
                <li><a href="{{ route('developer_login_page') }}">Pengembang / Marketing</a></li>
                <li><a href="{{ route('customer_login_page') }}">Konsumen</a></li>
              </ul>
            </div>
          </li>
          @endif
        </ul>
      </div>
    </nav>
  </div>
</header>

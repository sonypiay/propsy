<header class="uk-box-shadow-medium main-header" uk-sticky="top: 100; animation: uk-animation-slide-top; bottom: #sticky-on-scroll-up">
  <div class="uk-container">
    <nav class="uk-navbar main-navbar" uk-navbar>
      <div class="uk-navbar-left">
        <a class="uk-navbar-item uk-logo navbar-logo" href="{{ url('/') }}">
          <img src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="maps">
        </a>
        <ul class="uk-navbar-nav main-nav">
          <li><a href="#">Menjadi Pengembang</a></li>
          <li><a href="#">Menjadi Marketing</a></li>
        </ul>
      </div>
      <div class="uk-navbar-right">
        <ul class="uk-navbar-nav main-nav">
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
        </ul>
      </div>
    </nav>
  </div>
</header>

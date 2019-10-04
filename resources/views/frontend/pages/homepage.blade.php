@extends('frontend.master')
@section('tag_title', 'Manajemen Properti Syariah')
@section('main_content')
<div id="app">
  <!--<div id="modal-login" class="uk-modal-full" uk-modal="esc-close: false">
    <div class="uk-modal-dialog uk-modal-body uk-height-viewport modal-login">
      <a class="uk-modal-close-full uk-close-large" uk-close></a>
      <modal-login-component />
    </div>
  </div>
  <div id="modal-signup" class="uk-modal-full" uk-modal="esc-close: false">
    <div class="uk-modal-dialog uk-modal-body uk-height-viewport modal-login modal-signup">
      <a class="uk-modal-close-full uk-close-large" uk-close></a>
      <modal-signup-component />
    </div>
  </div>-->
  <div class="uk-cover-container banner-homepage">
    <canvas width="300" height="400"></canvas>
    <img src="{{ asset('images/banner/homepage3.jpg') }}" alt="" uk-cover>
    <div class="uk-overlay uk-overlay-primary uk-position-cover banner-content">
      <div class="uk-position-center uk-text-center">
        <div>
          <strong>Properti Syariah</strong>
        </div>
        <div>
          untuk <strong>Pengembang</strong> dan <strong>Marketing</strong>
        </div>
        <a href="#" class="uk-button uk-button-primary learnmore">Pelajari Lebih Lanjut</a>
      </div>
    </div>
  </div>
  <div class="uk-card uk-card-body uk-card-large whatis-maps">
    <div class="uk-container">
      <div class="uk-text-center maps-logo">
        <img class="uk-width-1-4" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
      </div>
      <div class="maps-summary">
        <strong>Prosy</strong> adalah aplikasi yang menghubungkan antara <strong>Pengembang</strong> dengan <strong>Marketing</strong> properti syariah untuk mengelola properti yang dipasarkan.
      </div>
    </div>
  </div>
  <homepage-available-project :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

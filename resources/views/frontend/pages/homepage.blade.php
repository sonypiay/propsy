@extends('frontend.master')
@section('tag_title', 'Manajemen Properti')
@section('main_content')
<div class="uk-cover-container banner-homepage">
  <canvas width="300" height="400"></canvas>
  <img src="{{ asset('images/banner/homepage2.jpg') }}" alt="" uk-cover>
  <div class="uk-overlay uk-overlay-primary uk-position-cover banner-content">
    <div class="uk-position-center uk-text-center">
      <div>
        <strong>Manajemen Properti Syariah</strong>
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
      <strong>MaPS</strong> adalah aplikasi yang menghubungkan antara <strong>Pengembang</strong> dengan <strong>Marketing</strong> properti syariah untuk mengelola properti yang dipasarkan.
    </div>
  </div>
</div>
<div class="uk-margin-large-top uk-card uk-card-body uk-card-large hpmg-listproject">
  <div class="uk-container">
    <div class="uk-margin-large-bottom hpmg-listproject-heading">Proyek Pengembang yang Tersedia</div>
    <div uk-slider="center: true">
      <div class="uk-position-relative uk-visible-toggle uk-dark" tabindex="-1">
        <ul class="uk-slider-items uk-child-width-1-3@s uk-grid">
          @for( $i = 0; $i < 10; $i++ )
          <li>
            <div class="uk-card uk-card-default uk-card-small">
              <div class="uk-card-media-top">
                <img src="{{ asset('images/banner/homepage1.jpg') }}" alt="">
              </div>
              <div class="uk-card-body">
                <h3 class="uk-card-title">Headline</h3>
                <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.</p>
              </div>
            </div>
          </li>
          @endfor
        </ul>
        <a class="uk-position-center-left uk-position-small uk-hidden-hover" href="#" uk-slidenav-previous uk-slider-item="previous"></a>
        <a class="uk-position-center-right uk-position-small uk-hidden-hover" href="#" uk-slidenav-next uk-slider-item="next"></a>
      </div>
      <ul class="uk-slider-nav uk-dotnav uk-flex-center uk-margin"></ul>
    </div>
    <div class="uk-text-center">
      <a class="uk-margin-top uk-button uk-button-primary browse_project_btn">Lihat Proyek Lainnya</a>
    </div>
  </div>
</div>
@endsection

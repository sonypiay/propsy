<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
    <meta name="copyright" content="{{ date('Y') }} | Propsy All Right Reserved">
    <meta name="author" property="author" content="Propsy" />
    <meta name="description" property="description" content="@lang('metaheader.description')" />
    <meta name="keywords" property="keywords" content="@lang('metaheader.keywords')" />

    <link href="{{ asset('/vendor/ionicon/css/ionicons.min.css') }}" media="screen" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('vendor/uikit/css/uikit.min.css') }}" media="screen">
    <link rel="stylesheet" href="{{ asset('css/app.css') }}" media="screen">

    <script type="text/javascript" src="{{ asset('vendor/uikit/js/uikit.min.js') }}"></script>
    <script type="text/javascript" src="{{ asset('vendor/uikit/js/uikit-icons.min.js') }}"></script>
    <title>Verify Email</title>
  </head>
<body>
<div class="uk-width-1-3@xl uk-width-1-3@l uk-width-1-3@m uk-width-1-1@s uk-align-center">
  <div class="uk-card uk-card-body card-verify-email">
    @if( empty( $result ) )
      <div class="uk-text-center card-icon-verify">
        <span class="icon ion-ios-close-circle-outline failed"></span>
      </div>
      <div class="uk-text-center card-congrats-verify">
        Token tidak ditemukan
      </div>
    @else
      @if( time() > $result->expire_date )
      <div class="uk-text-center card-icon-verify">
        <span class="icon ion-ios-close-circle-outline failed"></span>
      </div>
      <div class="uk-text-center card-congrats-verify">
        Token sudah kadaluarsa
      </div>
      @else
      <div class="uk-text-center card-icon-verify">
        <span class="icon ion-ios-checkmark-circle-outline success"></span>
      </div>
      <div class="uk-text-center card-congrats-verify">
        @if( $result->status_verify === 'Y' )
          Anda sudah terverifikasi.
        @else
          Berhasil. Akun anda telah terverifikasi.
          <?php
            $result->status_verify = 'Y';
            $customer->status_verification = 'Y';

            $result->save();
            $customer->save();
          ?>
        @endif
      </div>
      @endif
    @endif
    <img class="uk-width-1-3 uk-align-center" src="{{ asset('images/brand/logo_maps_primary.png') }}" />
  </div>
</div>
</body>
</html>

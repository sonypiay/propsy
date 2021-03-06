<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
  @include('frontend.inc.meta_header')
  <title>Meminta Verifikasi Akun</title>
  <style media="screen">
    html, body {
      background: #f2f2f2 !important;
    }
  </style>
</head>
<body>
<div class="uk-margin-large-top uk-margin-large-bottom uk-container">
  <div class="uk-width-1-2@xl uk-width-1-2@l uk-width-2-3@m uk-width-1-1@s uk-align-center">
    <div id="app">
      <developer-request-verification
      :session_user="{{ json_encode( $session_user ) }}"
      :getverification="{{ json_encode( $getverification ) }}"
      />
    </div>
    <script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
  </div>
</div>
</body>
</html>

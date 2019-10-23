@extends('frontend.pages.developer.master')
@section('tag_title', 'Laporan Data Pelanggan')
@section('main_content')
<div id="app">
  <developer-report-customer
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

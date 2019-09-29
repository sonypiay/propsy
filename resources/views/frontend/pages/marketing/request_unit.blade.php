@extends('frontend.pages.developer.master')
@section('tag_title', 'Permintaan Pelanggan')
@section('main_content')
<div id="app">
  <marketing-request-unit
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

@extends('frontend.master')
@section('tag_title', 'Daftar Pemesanan Unit')
@section('main_content')
<div id="app">
  <customer-list-request :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

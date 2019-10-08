@extends('controlpanel.master')
@section('tag_title', 'Halaman Kota')
@section('main_content')
<div id="app">
  <wilayah-city-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

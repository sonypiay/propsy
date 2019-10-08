@extends('controlpanel.master')
@section('tag_title', 'Halaman Provinsi')
@section('main_content')
<div id="app">
  <wilayah-province-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

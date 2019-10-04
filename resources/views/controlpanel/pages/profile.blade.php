@extends('controlpanel.master')
@section('tag_title', 'Informasi Akun')
@section('main_content')
<div id="app">
  <profile-component
  :session_user="{{ json_encode( $session_user ) }}"
  pagecomponent="{{ $pagenav }}"
  />
</div>
@endsection

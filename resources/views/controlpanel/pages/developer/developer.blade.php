@extends('controlpanel.master')
@section('tag_title', 'Daftar Developer')
@section('main_content')
<div id="app">
  <developer-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  />
</div>
@endsection

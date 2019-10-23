@extends('controlpanel.master')
@section('tag_title', 'Daftar Marketing')
@section('main_content')
<div id="app">
  <marketing-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  />
</div>
@endsection

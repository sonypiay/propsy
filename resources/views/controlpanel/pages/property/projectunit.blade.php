@extends('controlpanel.master')
@section('tag_title', 'Unit Proyek')
@section('main_content')
<div id="app">
  <projectunit-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  />
</div>
@endsection

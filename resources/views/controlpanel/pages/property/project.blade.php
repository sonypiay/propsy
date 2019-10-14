@extends('controlpanel.master')
@section('tag_title', 'Proyek Pengembang')
@section('main_content')
<div id="app">
  <project-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  />
</div>
@endsection

@extends('controlpanel.master')
@section('tag_title', 'Daftar Proyek')
@section('main_content')
<div id="app">
  <project-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

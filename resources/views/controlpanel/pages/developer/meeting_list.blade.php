@extends('controlpanel.master')
@section('tag_title', 'Daftar Jadwal Meeting')
@section('main_content')
<div id="app">
  <meetinglist-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

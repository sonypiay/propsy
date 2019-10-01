@extends('frontend.pages.developer.master')
@section('tag_title', 'Edit Jadwal Meeting')
@section('main_content')
<div id="app">
  <marketing-update-schedule
  :session_user="{{ json_encode( $session_user ) }}"
  :getrequest="{{ json_encode( $getrequest ) }}"
  :getmeeting="{{ json_encode( $getmeeting ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

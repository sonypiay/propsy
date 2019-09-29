@extends('frontend.pages.developer.master')
@section('tag_title', 'Buat Jadwal Meeting')
@section('main_content')
<div id="app">
  <marketing-create-schedule
  :session_user="{{ json_encode( $session_user ) }}"
  :getrequest="{{ json_encode( $getrequest ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

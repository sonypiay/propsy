@extends('frontend.pages.developer.master')
@section('tag_title', 'Jadwal Meeting')
@section('main_content')
<div id="app">
  <marketing-meeting-list
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

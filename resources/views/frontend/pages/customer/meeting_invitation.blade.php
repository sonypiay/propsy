@extends('frontend.master')
@section('tag_title', 'Undangan Jadwal Meeting')
@section('main_content')
<div id="app">
  <customer-meeting-invitation
  :session_user="{{ json_encode( $session_user ) }}"
  hasrequest="{{ $hasrequest }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

@extends('frontend.master')
@section('tag_title', 'Customer Profile')
@section('main_content')
<div id="app">
  <customer-profile-page :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

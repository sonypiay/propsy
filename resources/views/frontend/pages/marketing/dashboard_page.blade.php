@extends('frontend.pages.developer.master')
@section('tag_title', 'Marketing Dashboard')
@section('main_content')
<div id="app">
  <marketing-dashboard-page :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

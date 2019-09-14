@extends('frontend.pages.developer.master')
@section('tag_title', 'Developer Dashboard')
@section('main_content')
<div id="app">
  <developer-find-marketing
  :session_user="{{ json_encode( $session_user ) }}"
  :getarea="{{ json_encode( $getarea ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

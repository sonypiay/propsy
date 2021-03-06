@extends('frontend.pages.developer.master')
@section('tag_title', 'Developer | Project Gallery')
@section('main_content')
<div id="app">
  <developer-project-gallery :projects="{{ json_encode( $projects ) }}" :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

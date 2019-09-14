@extends('frontend.pages.developer.master')
@section('tag_title', $projects->project_name)
@section('main_content')
<div id="app">
  <developer-detail-project
  :projects="{{ json_encode( $projects ) }}"
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

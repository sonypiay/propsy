@extends('frontend.pages.developer.master')
@section('tag_title', $getproject->project_name)
@section('main_content')
<div id="app">
  <marketing-detail-project
  :getproject="{{ json_encode( $getproject ) }}"
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

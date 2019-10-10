@extends('frontend.master')
@section('tag_title', $getdeveloper->dev_name)
@section('main_content')
<div id="app">
  <page-view-developer
  :session_user="{{ json_encode( $session_user ) }}"
  :getdeveloper="{{ json_encode( $getdeveloper ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

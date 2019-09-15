@extends('frontend.master')
@section('tag_title', $getproject->project_name . ' | ' . $getproject->dev_name)
@section('main_content')
<div id="app">
  <page-view-project
  :session_user="{{ json_encode( $session_user ) }}"
  :getproject="{{ json_encode( $getproject ) }}"
  :getgallery="{{ json_encode( $getgallery ) }}"
  :projectcity="{{ json_encode( $project_city ) }}"
  :devcity="{{ json_encode( $dev_city ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

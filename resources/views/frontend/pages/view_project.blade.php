@extends('frontend.master')
@section('tag_title', $getproject->project_name . ' | ' . $getproject->dev_name)
@section('main_content')
<div id="app">
  <page-view-project
  :session_user="{{ json_encode( $session_user ) }}"
  :getproject="{{ json_encode( $getproject ) }}"
  :getgallery="{{ json_encode( $getgallery ) }}"
  :getunit_price="{{ json_encode( $getunit_price ) }}"
  session_active="{{ $session_active }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

@extends('frontend.master')
@section('tag_title', $getunit->unit_name)
@section('main_content')
<div id="app">
  <page-view-unit
  :session_user="{{ json_encode( $session_user ) }}"
  :getunit="{{ json_encode( $getunit ) }}"
  :getgallery="{{ json_encode( $getgallery ) }}"
  session_active="{{ $session_active }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

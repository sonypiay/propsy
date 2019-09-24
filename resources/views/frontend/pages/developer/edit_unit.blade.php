@extends('frontend.pages.developer.master')
@section('tag_title', $getunit->unit_name)
@section('main_content')
<div id="app">
  <developer-edit-unit
  :session_user="{{ json_encode( $session_user ) }}"
  :getunit="{{ json_encode( $getunit ) }}"
  :getproject="{{ json_encode( $getproject ) }}"
  :getfacility="{{ json_encode( $getfacility ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

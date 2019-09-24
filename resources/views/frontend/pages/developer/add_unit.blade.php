@extends('frontend.pages.developer.master')
@section('tag_title', 'Tambah Unit Baru')
@section('main_content')
<div id="app">
  <developer-add-unit
  :session_user="{{ json_encode( $session_user ) }}"
  :getproject="{{ json_encode( $getproject ) }}"
  :getfacility="{{ json_encode( $getfacility ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

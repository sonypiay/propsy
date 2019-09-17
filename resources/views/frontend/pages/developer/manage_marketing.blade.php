@extends('frontend.pages.developer.master')
@section('tag_title', 'Kelola Marketing')
@section('main_content')
<div id="app">
  <developer-manage-marketing
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  :getproject="{{ json_encode( $getproject ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

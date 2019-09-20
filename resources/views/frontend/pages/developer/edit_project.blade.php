@extends('frontend.pages.developer.master')
@section('tag_title', 'Edit Proyek')
@section('main_content')
<div id="app">
  <developer-edit-project
  :session_user="{{ json_encode( $session_user ) }}"
  :getproject="{{ json_encode( $getproject ) }}"
  />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

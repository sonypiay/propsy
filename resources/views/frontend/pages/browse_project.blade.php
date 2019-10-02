@extends('frontend.master')
@section('tag_title', 'Cari properti lainnya')
@section('main_content')
<div id="app">
  <page-browse-project
  :session_user="{{ json_encode( $session_user ) }}"
  session_active="{{ $session_active }}"
  :getcity="{{ json_encode( $getcity ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

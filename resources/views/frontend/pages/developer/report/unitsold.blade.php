@extends('frontend.pages.developer.master')
@section('tag_title', 'Laporan Unit Terjual')
@section('main_content')
<div id="app">
  <developer-report-unitsold
  :session_user="{{ json_encode( $session_user ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

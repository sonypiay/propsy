@extends('frontend.master')
@section('tag_title', 'Cari properti | ' . $request->keywords)
@section('main_content')
<div id="app">
  <page-search-project
  keywords="{{ $request->keywords }}"
  session_active="{{ $session_active }}"
  :session_user="{{ json_encode( $session_user ) }}"
  :getcity="{{ json_encode( $getcity ) }}"
  :getfacility="{{ json_encode( $getfacility ) }}"
   />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

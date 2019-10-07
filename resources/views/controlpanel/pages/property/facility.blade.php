@extends('controlpanel.master')
@section('tag_title', 'Fasilitas Unit')
@section('main_content')
<div id="app">
  <facility-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

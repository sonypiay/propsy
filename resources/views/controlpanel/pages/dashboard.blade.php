@extends('controlpanel.master')
@section('tag_title', 'Dashboard Admin')
@section('main_content')
<div id="app">
  <dashboard-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

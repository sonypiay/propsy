@extends('controlpanel.master')
@section('tag_title', 'Manajemen Admin')
@section('main_content')
<div id="app">
  <admin-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

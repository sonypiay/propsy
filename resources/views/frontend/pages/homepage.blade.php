@extends('frontend.master')
@section('tag_title', 'Properti Syariah')
@section('main_content')
<div id="app">
  <homepage-available-project :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

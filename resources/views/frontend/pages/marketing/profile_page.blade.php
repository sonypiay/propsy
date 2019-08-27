@extends('frontend.pages.marketing.master')
@section('tag_title', 'Marketing Profile')
@section('main_content')
<div id="app">
  <marketing-profile-page :session="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

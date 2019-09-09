@extends('frontend.master')
@section('tag_title', 'Masuk')
@section('main_content')
<div id="app">
  <customer-login-page />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

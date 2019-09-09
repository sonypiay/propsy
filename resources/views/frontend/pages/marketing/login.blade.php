@extends('frontend.master')
@section('tag_title', 'Masuk Sebagai Marketing')
@section('main_content')
<div id="app">
  <marketing-login-page />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

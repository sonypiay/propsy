@extends('frontend.master')
@section('tag_title', 'Masuk Sebagai Developer')
@section('main_content')
<div id="app">
  <developer-login-page />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

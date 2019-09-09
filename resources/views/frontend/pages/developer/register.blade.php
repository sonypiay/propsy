@extends('frontend.master')
@section('tag_title', 'Daftar Sebagai Developer')
@section('main_content')
<div id="app">
  <developer-register-page />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

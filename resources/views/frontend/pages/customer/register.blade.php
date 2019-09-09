@extends('frontend.master')
@section('tag_title', 'Daftar')
@section('main_content')
<div id="app">
  <customer-register-page />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

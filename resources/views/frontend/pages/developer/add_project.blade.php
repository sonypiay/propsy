@extends('frontend.pages.developer.master')
@section('tag_title', 'Tambah Proyek Baru')
@section('main_content')
<div id="app">
  <developer-add-project :session_user="{{ json_encode( $session_user ) }}" />
</div>
<script type="text/javascript" src="{{ asset('js/app.js') }}"></script>
@endsection

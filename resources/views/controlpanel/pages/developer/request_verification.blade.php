@extends('controlpanel.master')
@section('tag_title', 'Pengajuan Verifikasi Akun')
@section('main_content')
<div id="app">
  <page-requestverification-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

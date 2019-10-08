@extends('controlpanel.master')
@section('tag_title', 'Daftar Riwayat Pengajuan Pesanan')
@section('main_content')
<div id="app">
  <requesthistory-page-component
  :session_user="{{ json_encode( $session_user ) }}"
  />
</div>
@endsection

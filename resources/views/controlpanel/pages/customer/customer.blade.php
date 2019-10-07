@extends('controlpanel.master')
@section('tag_title', 'Daftar Pelanggan')
@section('main_content')
<div id="app">
  <customer-page-component
  :getcity="{{ json_encode( $getcity ) }}"
  />
</div>
@endsection

@extends('frontend.pages.export.master')
@section('tag_title', $filename)
@section('main_content')
<div class="uk-width-1-1">
  <div class="uk-text-center">
    <img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
  </div>
  <article class="uk-article uk-margin-top">
    <div class="uk-h2 uk-text-center">Laporan Data Pelanggan</div>
    <div class="uk-article-meta uk-text-center">Tanggal cetak {{ date('d/m/Y') }}</div>
    <table class="uk-table uk-table-small uk-table-striped uk-table-middle uk-table-divider uk-table-expand uk-margin-small-top uk-text-small">
      <thead>
        <tr>
          <th>No.</th>
          <th>Nama Pelanggan</th>
          <th>Email</th>
          <th>No. Telepon</th>
          <th>Kota</th>
        </tr>
      </thead>
      <tbody>
        @php $i = 1 @endphp
        @foreach( $result as $res )
        <tr>
          <td>
            {{ $i++ }}
          </td>
          <td>{{ $res->customer_name }}</td>
          <td>{{ $res->customer_email }}</td>
          <td>{{ $res->customer_phone_number }}</td>
          <td>{{ $res->city_name }}</td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

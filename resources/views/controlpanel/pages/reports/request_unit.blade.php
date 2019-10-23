@extends('controlpanel.pages.reports.master')
@section('tag_title', 'Laporan Data Pengajuan Pesanan - ' . date('d/m/Y'))
@section('main_content')
<div class="uk-width-1-1">
  <div class="uk-margin-bottom uk-text-center">
    <img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
  </div>
  <article class="uk-article uk-margin-top">
    <h2 class="uk-h2 uk-text-center uk-margin-remove-bottom">
      Laporan Data Pengajuan Pesanan
    </h2>
    <div class="uk-article-meta uk-text-center uk-margin-remove-top">Tanggal cetak {{ date('d/m/Y') }}</div>
    <table class="uk-table uk-table-striped uk-table-divider uk-table-expand uk-margin-top uk-text-small">
      <thead>
        <tr>
          <th>ID</th>
          <th>Nama Pelanggan</th>
          <th>Tipe Unit</th>
          <th>Tanggal Pesan</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        @foreach( $result as $res )
        <tr>
          <td>{{ $res->request_id }}</td>
          <td>{{ $res->customer_name }}</td>
          <td>{{ $res->unit_name }}</td>
          <td>{{ $res->created_at->format('d/m/Y') }}</td>
          <td>
            @if( $res->status_request === 'waiting_response' )
              <label class="uk-label">Menunggu Tanggapan</label>
            @elseif( $res->status_request === 'reject' )
              <label class="uk-label uk-label-danger">Ditolak</label>
            @elseif( $res->status_request === 'cancel' )
              <label class="uk-label uk-label-danger">Dibatalkan</label>
            @elseif( $res->status_request === 'meeting' )
              <label class="uk-label uk-label-warning">Dijadwalkan Meeting</label>
            @else
              <label class="uk-label uk-label-success">Diterima</label>
            @endif
          </td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

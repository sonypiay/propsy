@extends('controlpanel.pages.reports.master')
@section('tag_title', 'Laporan Data Meeting - ' . date('d/m/Y'))
@section('main_content')
<div class="uk-width-1-1">
  <div class="uk-margin-bottom uk-text-center">
    <img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
  </div>
  <article class="uk-article uk-margin-top">
    <h2 class="uk-h2 uk-text-center uk-margin-remove-bottom">Laporan Data Meeting</h2>
    <div class="uk-article-meta uk-text-center uk-margin-remove-top">Tanggal cetak {{ date('d/m/Y') }}</div>
    <table class="uk-table uk-table-striped uk-table-divider uk-table-expand uk-margin-top uk-text-small">
      <thead>
        <tr>
          <th>ID</th>
          <th>No. Pesanan</th>
          <th>Jadwal</th>
          <th>Pelanggan</th>
          <th>Marketing</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        @foreach( $result as $res )
        <tr>
          <td>{{ $res->meeting_id }}</td>
          <td>{{ $res->request_id }}</td>
          <td>
            @php $meeting_time = new DateTime( $res->meeting_time ) @endphp
            {{ $meeting_time->format('d/m/Y H:i') }}
          </td>
          <td>{{ $res->customer_name }}</td>
          <td>{{ $res->created_by }}</td>
          <td>
            @if( $res->meeting_status === 'waiting_confirmation' ) <label class="uk-label">Menunggu Konfirmasi</label>
            @elseif( $res->meeting_status === 'reject' ) <label class="uk-label uk-label-danger">Ditolak</label>
            @elseif( $res->meeting_status === 'cancel' ) <label class="uk-label uk-label-danger">Dibatalkan</label>
            @elseif( $res->meeting_status === 'revision' ) <label class="uk-label uk-label-warning">Revisi</label>
            @elseif( $res->meeting_status === 'accept' ) <label class="uk-label uk-label-success">Diterima</label>
            @else <label class="uk-label uk-label-success">Selesai</label>
            @endif
          </td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

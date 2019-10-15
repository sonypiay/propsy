@extends('controlpanel.pages.reports.master')
@section('tag_title', 'Laporan Data Pengajuan Verifkasi Akun - ' . date('d/m/Y'))
@section('main_content')
<div class="uk-width-1-1">
  <div class="uk-margin-bottom uk-text-center">
    <!--<img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">-->
  </div>
  <article class="uk-article uk-margin-top">
    <h2 class="uk-h2 uk-text-center uk-margin-remove-bottom">
      Laporan Data Pengajuan Verifikasi Akun
    </h2>
    <div class="uk-article-meta uk-text-center uk-margin-remove-top">Tanggal cetak {{ date('d/m/Y') }}</div>
    <table class="uk-table uk-table-striped uk-table-divider uk-table-expand uk-margin-top">
      <thead>
        <tr>
          <th>Nama Pengembang</th>
          <th>NPWP</th>
          <th>Sertifikat</th>
          <th>Tanggal Pengajuan</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        @foreach( $result as $res )
        <tr>
          <td>{{ $res->dev_name }}</td>
          <td>Berupa Gambar</td>
          <td>Berupa Gambar</td>
          <td>{{ $res->created_at->format('d/m/Y') }}</td>
          <td>
            @if( $res->status_verification === 'N' )
              <label class="uk-label">Menunggu Verifikasi</label>
            @elseif( $res->status_verification === 'R' )
              <label class="uk-label uk-label-danger">Verifikasi Ditolak</label>
            @else
              <label class="uk-label uk-label-success">Verifikasi Diterima</label>
            @endif
          </td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

@extends('controlpanel.pages.reports.master')
@section('tag_title', 'Laporan Data Proyek - ' . date('d/m/Y'))
@section('main_content')
<div class="uk-width-1-1">
  <div class="uk-margin-bottom uk-text-center">
    <img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
  </div>
  <article class="uk-article uk-margin-top">
    <h2 class="uk-h2 uk-text-center uk-margin-remove-bottom">
      Laporan Data Proyek
      @if( ! empty( $getcity ) )
       - Kota {{ $getcity->city_name }}
      @endif
    </h2>
    <div class="uk-article-meta uk-text-center uk-margin-remove-top">Tanggal cetak {{ date('d/m/Y') }}</div>
    <table class="uk-table uk-table-striped uk-table-divider uk-table-expand uk-margin-top uk-text-small">
      <thead>
        <tr>
          <th>ID</th>
          <th>Nama Proyek</th>
          <th>Pengembang</th>
          <th>Kota</th>
          <th>Jumlah Unit</th>
          <th>Tanggal Posting</th>
          <th>Status</th>
        </tr>
      </thead>
      <tbody>
        @foreach( $result as $res )
        <tr>
          <td>{{ $res->project_id }}</td>
          <td>{{ $res->project_name }}</td>
          <td>{{ $res->dev_name }}</td>
          <td>{{ $res->city_name }}</td>
          <td>{{ $res->total_unit }} unit</td>
          <td>{{ $res->created_at->format('d/m/Y') }}</td>
          <td>
            @if( $res->project_status === 'sold' )
              Terjual
            @elseif( $res->project_status === 'soon' )
              Segera Hadir {{ $res->project_estimate_launch }}
            @else
              Tersedia
            @endif
          </td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

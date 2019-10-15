@extends('controlpanel.pages.reports.master')
@section('tag_title', 'Laporan Data Wilayah - ' . date('d/m/Y'))
@section('main_content')
<div class="uk-width-1-1">
  <div class="uk-margin-bottom uk-text-center">
    <!--<img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">-->
  </div>
  <article class="uk-article uk-margin-top">
    <h2 class="uk-h2 uk-text-center uk-margin-remove-bottom">
      Laporan Data
      @if( $table === 'customer' ) Pelanggan
      @elseif( $table === 'developer' ) Pengembang
      @else Proyek
      @endif
      per Wilayah
    </h2>
    <div class="uk-article-meta uk-text-center uk-margin-remove-top">Tanggal cetak {{ date('d/m/Y') }}</div>
    <table class="uk-table uk-table-striped uk-table-divider uk-table-expand uk-margin-top">
      <thead>
        <tr>
          <th>ID</th>
          <th>Kota</th>
          <th>Jumlah</th>
        </tr>
      </thead>
      <tbody>
        @foreach( $result as $res )
        <tr>
          <td>{{ $res->city_id }}</td>
          <td>{{ $res->city_name }}</td>
          <td>{{ $res->total_data }}</td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

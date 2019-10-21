@extends('frontend.pages.export.master')
@section('tag_title', $filename)
@section('main_content')
<?php
  $start_date = new DateTime( $start_date );
  $end_date = ! empty( $end_date ) ? new DateTime( $end_date ) : '';
?>
<div class="uk-width-1-1">
  <div class="uk-text-center">
    <img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
  </div>
  <article class="uk-article uk-margin-top">
    <div class="uk-h2 uk-text-center">Laporan Unit
      @if( $status === 'sold' ) Terjual
      @else Dipesan
      @endif
    </div>
    <div class="uk-article-meta uk-text-center">
      Tanggal cetak {{ date('d/m/Y') }} | Laporan tanggal {{ $start_date->format('d/m/Y') }}
      @if( $end_date !== '' )
      - {{ $end_date->format('d/m/Y') }}
      @endif
    </div>
    <table class="uk-table uk-table-small uk-table-striped uk-table-middle uk-table-divider uk-table-expand uk-margin-small-top uk-text-small">
      <thead>
        <tr>
          <th>ID</th>
          <th>Tipe Unit</th>
          <th>Nama Pelanggan</th>
          <th>Tanggal</th>
        </tr>
      </thead>
      <tbody>
        @foreach( $result as $res )
        <tr>
          <td>{{ $res->request_id }}</td>
          <td>{{ $res->unit_name }}</td>
          <td>{{ $res->customer_name }}</td>
          <td>{{ $res->created_at->format('d/m/Y') }}</td>
        </tr>
        @endforeach
      </tbody>
    </table>
  </article>
</div>
@endsection

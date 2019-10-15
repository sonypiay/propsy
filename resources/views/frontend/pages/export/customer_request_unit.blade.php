@extends('frontend.pages.export.master')
@section('tag_title', $filename)
@section('main_content')
<style>
.page-break {
    page-break-after: always;
}
</style>
<div class="uk-width-1-1">
  <div class="uk-margin-bottom">
    <img style="width: 130px;" src="{{ asset('images/brand/logo_maps_primary.png') }}" alt="">
  </div>
  <table class="uk-table uk-table-divider uk-table-small">
    <tr>
      <td class="uk-text-bold uk-width-small">Request ID</td>
      <td>: {{ $result->request_id }}</td>
    </tr>
    <tr>
      <td class="uk-text-bold uk-width-small">Tanggal</td>
      <td>: {{ $result->created_at->format('d/m/Y') }}</td>
    </tr>
    <tr>
      <td class="uk-text-bold">Status</td>
      <td>:
        @if( $result->status_request === 'waiting_response' )
        <label class="uk-label">Menunggu Tanggapan</label>
        @elseif( $result->status_request === 'accept' )
        <label class="uk-label uk-label-success">Pengajuan Diterima</label>
        @elseif( $result->status_request === 'reject' )
        <label class="uk-label uk-label-danger">Pengajuan Ditolak</label>
        @elseif( $result->status_request === 'cancel' )
        <label class="uk-label uk-label-danger">Dibatalkan</label>
        @elseif( $result->status_request === 'revision' )
        <label class="uk-label uk-label-warning">Revisi</label>
        @elseif( $result->status_request === 'meeting' )
          @if( $result->meeting_status === 'waiting_confirmation' )
          <label class="uk-label uk-label-warning">Dijadwalkan Meeting</label>
          @else
          <label class="uk-label">Belum direview</label>
          @endif
        @else
        <label class="uk-label uk-label-success">Selesai</label>
        @endif
      </td>
    </tr>
  </table>

  <table class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
    <tbody>
      <tr>
        <th>Nama Pelanggan</th>
        <td>{{ $result->customer_name }}</td>
      </tr>
      <tr>
        <th>Nomor Telepon</th>
        <td>{{ $result->customer_phone_number }}</td>
      </tr>
      <tr>
        <th>Alamat Email</th>
        <td>{{ $result->customer_email }}</td>
      </tr>
      <tr>
        <th>Pengembang</th>
        <td>{{ $result->dev_name }}</td>
      </tr>
      <tr>
        <th>Proyek</th>
        <td>{{ $result->project_name }}</td>
      </tr>
      <tr>
        <th>Unit Dipesan</th>
        <td>
          {{ $result->unit_name }}
        </td>
      </tr>
    </tbody>
  </table>

  <table class="uk-table uk-table-hover uk-table-striped uk-table-divider uk-table-small uk-table-middle">
    <thead>
      <tr>
        <th>DP</th>
        <th>Angsuran</th>
        <th>Tenor</th>
        <th>Total Angsuran</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Rp. {{ number_format( $result->dp_price, 0, '', '.') }}</td>
        <td>Rp. {{ number_format( $result->installment_price, 0, '', '.') }}</td>
        <td>{{ $result->installment_tenor }} bulan
          @if( $result->installment_tenor > 12 )
            @php $tenor = $result->installment_tenor / 12 @endphp
            @if( is_float( $tenor ) )
              {{ number_format( $tenor, 1, ',', '.' ) }}
            @else
              {{ $tenor }}
            @endif
            tahun
          @endif
        </td>
        <td>Rp. @php $total_tenor = $result->installment_tenor * $result->installment_price @endphp
          {{ number_format( $total_tenor, 0, ',', '.' ) }}
        </td>
      </tr>
    </tbody>
  </table>
</div>
@endsection

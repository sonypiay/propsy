@extends('frontend.pages.export.master')
@section('tag_title', $filename)
@section('main_content')
<style>
.page-break {
    page-break-after: always;
}
</style>
<div class="uk-width-1-1">
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
        <th>Alamat</th>
        <td>
          {{ $result->customer_address }} <br>
          {{ $result->city_name }}, {{ $result->province_name }}
        </td>
      </tr>
      <tr>
        <th>Unit Dipesan</th>
        <td>
          {{ $result->unit_name }}
        </td>
      </tr>
      <tr>
        <th>Pesan</th>
        <td>{{ $result->request_message }}</td>
      </tr>
    </tbody>
  </table>

  @if( ! empty( $result->meeting_time ) )
  @php $meeting_time = new DateTime( $result->meeting_time ) @endphp
  <table class="uk-table uk-table-divider uk-table-hover uk-table-middle uk-table-striped uk-table-small">
    <thead>
      <tr>
        <th>Tanggal Meeting</th>
        <th>Jam</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td class="uk-width-medium">{{ $meeting_time->format('d/m/Y') }}</td>
        <td class="uk-width-medium">{{ $meeting_time->format('H:i') }}</td>
        <td>
          @if( $result->meeting_status === 'waiting_confirmation' )
          <label class="uk-label">Menunggu Konfirmasi</label>
          @elseif( $result->meeting_status === 'accept' )
          <label class="uk-label uk-label-success">Diterima</label>
          @elseif( $result->meeting_status === 'reject' )
          <label class="uk-label uk-label-danger">Ditolak</label>
          @elseif( $result->meeting_status === 'cancel' )
          <label class="uk-label uk-label-danger">Dibatalkan</label>
          @elseif( $result->meeting_status === 'revision' )
          <label class="uk-label uk-label-warning">Revisi</label>
          @else
          <label class="uk-label uk-label-success">Selesai</label>
          @endif
        </td>
      </tr>
      <tr>
        <th>Hasil Meeting</th>
        <td colspan="2">
          {{ $result->meeting_result }}
        </td>
      </tr>
    </tbody>
  </table>
  <div class="page-break"></div>
  @endif

  <div class="uk-margin">
    <h3 class="uk-h3">Track Pemesanan Unit</h3>
    <ul class="uk-margin uk-list uk-list-divider">
      @foreach( $log_request as $log )
      <li>
        <div class="uk-text-small uk-text-bold">
          @php $log_date = new DateTime( $log->log_date ) @endphp
          {{ $log_date->format('d/m/Y H:i') }}
        </div>
        {{ $log->log_message }}
      </li>
      @endforeach
    </ul>
  </div>
</div>
@endsection

@php
  $link_nav = [
    'dashboard' => '#',
    'project' => '#',
    'marketing' => '#',
    'pelanggan' => '#',
    'laporan' => '#'
  ]
@endphp

@if( session()->has('isMarketing') )
  @php
    $link_nav = [
      'dashboard' => route('marketing_dashboard_page'),
      'project' => '#',
      'marketing' => '#',
      'pelanggan' => '#',
      'laporan' => '#'
    ]
  @endphp
@else
  @php
    $link_nav = [
      'dashboard' => '#',
      'project' => route('developer_manage_project'),
      'marketing' => '#',
      'pelanggan' => '#',
      'laporan' => '#'
    ]
  @endphp
@endif

<div class="uk-card uk-card-body uk-height-viewport side-navbar">
  <div class="uk-margin">
    <div class="uk-text-center">
      <a href="{{ route('homepage') }}"><img class="uk-width-1-2" src="{{ asset('images/brand/logo_maps_secondary.png') }}" alt=""></a>
    </div>
  </div>
  <ul class="uk-nav-default side-nav" uk-nav>
    @if( session()->has('isMarketing') )
    <li><a href="{{ $link_nav['dashboard'] }}">Dashboard</a></li>
    <li><a href="{{ $link_nav['project'] }}">Proyek</a></li>
    <li class="uk-parent"><a href="#">Pelanggan <span class="uk-float-right" uk-icon="icon: chevron-down; ratio: 1"></span></a>
      <ul class="uk-nav-sub side-nav-sub">
        <li><a href="{{ route('marketing_request_info') }}">Permintaan</a></li>
        <li><a href="#">Survey</a></li>
      </ul>
    </li>
    <li><a href="{{ $link_nav['laporan'] }}">Laporan</a></li>
    @else
    <li><a href="{{ $link_nav['dashboard'] }}">Dashboard</a></li>
    <li><a href="{{ $link_nav['project'] }}">Proyek</a></li>
    <li><a href="{{ $link_nav['pelanggan'] }}">Pelanggan</a></li>
    <li><a href="{{ $link_nav['marketing'] }}">Marketing</a></li>
    <li><a href="{{ $link_nav['laporan'] }}">Laporan</a></li>
    @endif
  </ul>
</div>

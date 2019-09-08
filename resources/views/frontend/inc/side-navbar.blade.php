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

<div class="uk-width-1-5 uk-card uk-card-body uk-height-viewport uk-position-absolute side-navbar">
  <div class="uk-margin">
    <div class="uk-text-center">
      <a href="{{ route('homepage') }}"><img class="uk-width-1-2" src="{{ asset('images/brand/logo_maps_secondary.png') }}" alt=""></a>
    </div>
  </div>
  <ul class="uk-nav-default uk-nav-parent-icon side-nav" uk-nav>
    @if( session()->has('isMarketing') )
    <li><a href="{{ $link_nav['dashboard'] }}">Dashboard</a></li>
    <li><a href="{{ $link_nav['project'] }}">Proyek</a></li>
    <li class="uk-parent"><a href="#">Pelanggan</a>
      <ul class="uk-nav-sub">
        <li><a href="#">Permintaan</a></li>
        <li><a href="#">Survey</a></li>
      </ul>
    </li>
    @else
    <li><a href="{{ $link_nav['dashboard'] }}">Dashboard</a></li>
    <li><a href="{{ $link_nav['project'] }}">Proyek</a></li>
    <li><a href="{{ $link_nav['pelanggan'] }}">Pelanggan</a></li>
    <li><a href="{{ $link_nav['marketing'] }}">Marketing</a></li>
    <li><a href="{{ $link_nav['laporan'] }}">Laporan</a></li>
    @endif
  </ul>
</div>

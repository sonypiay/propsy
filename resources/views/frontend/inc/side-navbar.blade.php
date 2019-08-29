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
      'project' => '#',
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
    <li><a href="#">Dashboard</a></li>
    <li><a href="#">Proyek</a></li>
    <li><a href="#">Marketing</a></li>
    <li><a href="#">Pelanggan</a></li>
    <li><a href="#">Laporan</a></li>
    @else
    <li><a href="#">Dashboard</a></li>
    <li><a href="#">Proyek</a></li>
    <li><a href="#">Survey</a></li>
    <li><a href="#">Pelanggan</a></li>
    <li><a href="#">Laporan</a></li>
    @endif
  </ul>
</div>

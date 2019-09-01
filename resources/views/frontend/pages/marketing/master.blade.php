<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
  @include('frontend.inc.meta_header')
  <title>@yield('tag_title')</title>
</head>
<body>
<div class="uk-grid-collapse" uk-grid>
  <div class="uk-width-1-5@xl uk-width-1-5@l uk-width-1-4@m uk-width-1-1@s">
    @include('frontend.layout.side-navbar')
  </div>
  <div class="uk-width-expand">
    @include('frontend.layout.header-dashboard')
    <div class="uk-position-relative">
      @yield('main_content')
    </div>
  </div>
</div>
</body>
</html>

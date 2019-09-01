<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
  @include('frontend.inc.meta_header')
  <title>@yield('tag_title')</title>
</head>
<body>
@include('frontend.layout.header-navbar')
@yield('main_content')
@include('frontend.layout.footer')
</body>
</html>

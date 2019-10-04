<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
<head>
  @include('frontend.inc.meta-header-export')
  <title>@yield('tag_title')</title>
</head>
<body>
@yield('main_content')
</body>
</html>

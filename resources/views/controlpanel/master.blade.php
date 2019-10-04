<!DOCTYPE html>
<html lang="en">
<head>
  @include('controlpanel.include.meta-header')
  <title>@yield('tag_title')</title>
</head>
<body>
@if( $request->route()->getName() === 'cp_login_page' )
  @yield('main_content')
@else
@include('controlpanel.include.navbar')
@yield('main_content')
@endif
<script src="{{ asset('admin/app.js') }}" type="text/javascript"></script>
</body>
</html>

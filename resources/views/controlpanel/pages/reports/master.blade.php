<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
  <meta name="copyright" content="&copy;  {{ date('Y') }} | Propsy All Right Reserved">
  <meta name="author" property="author" content="mastershifu" />
  <link rel="stylesheet" type="text/css" href="{{ asset('vendor/ionicon/css/ionicons.min.css') }}" media="screen" />
  <link rel="stylesheet" type="text/css" href="{{ asset('vendor/uikit/css/uikit.min.css') }}" media="screen" />
  <script type="text/javascript" src="{{ asset('vendor/uikit/js/uikit.min.js') }}"></script>
  <script type="text/javascript" src="{{ asset('vendor/uikit/js/uikit-icons.min.js') }}"></script>
  <title>@yield('tag_title')</title>
</head>
<body>
@yield('main_content')
</body>
</html>

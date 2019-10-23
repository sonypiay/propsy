<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="csrf-token" content="{{ csrf_token() }}">
  <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no">
  <meta name="copyright" content="{{ date('Y') }} | Properti Syariah All Right Reserved">
  <meta name="author" property="author" content="Propsy" />
  <title>Verify Your Email</title>
  <style type="text/css" media="screen">
    @import url('https://fonts.googleapis.com/css?family=Lato:300,400,700,900&display=swap');
    html,body {
      background: #f9f9f9;
      padding: 6px;
    }
    .container-mail {
      margin: auto;
      background: #ffffff;
      box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.02);
      border-radius: 2px;
      margin-top: 7em;
    }
    .subcontainer-mail { padding: 30px; }
    @media only screen and (min-width: 320px) {
      .container-mail { width: 100%; }
      .bt-verify { width: 100%; }
      .logo img { width: 20%; }
    }
    @media only screen and (min-width: 768px) {
      .container-mail { width: 65% !important; }
      .bt-verify { width: 65% !important; }
      .logo img { width: 25%; }
    }
    @media only screen and (min-width: 1024px) {
      .container-mail { width: 50% !important; }
      .bt-verify { width: 50% !important; }
      .logo img { width: 15%; }
    }
    .mail-icon {
      font-size: 72px;
      color: #1fccbd;
    }
    .heading-mail {
      font-size: 24px;
      font-weight: 600;
      font-family: 'Lato', sans-serif;
      letter-spacing: 0.4px;
      font-stretch: normal;
      font-style: normal;
      color: #1fccbd;
      margin-top: 20px;
      margin-bottom: 20px;
    }
    .content-mail {
      font-size: 14px;
      font-weight: 400;
      font-family: 'Lato', sans-serif;
      letter-spacing: 0.4px;
      font-stretch: normal;
      font-style: normal;
      color: #333333;
      margin-top: 20px;
      margin-bottom: 10px;
    }
    .bt-verify {
      color: #1fccbd;
      font-weight: 600;
      font-family: 'Lato', sans-serif;
      letter-spacing: 0.4px;
      font-stretch: normal;
      font-style: normal;
      font-size: 14px;
      margin: auto;
      text-decoration: none;
      text-transform: capitalize;
    }
  </style>
</head>
<body>
<div class="container-mail">
  <div class="subcontainer-mail">
    <div class="heading-mail">Verifikasi Email</div>
    <div class="content-mail">
      Halo {{ $email }}, <br />
      Harap beritahu kami bahwa Anda bukanlah robot. <a href="{{ route('validate_email_customer', ['hash_id' => $hash_id]) }}" class="bt-verify">Click Here</a>

      <br /><br />
      Salam,<br />
      Propsy
    </div>
  </div>
</div>

</body>
</html>

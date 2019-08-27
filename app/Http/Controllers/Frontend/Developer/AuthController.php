<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Database\DeveloperUser;
use App\Http\Controllers\Controller;

class AuthController extends Controller
{
  public function do_login( Request $request, DeveloperUser $developer )
  {
    $username = $request->username;
    $password = $request->password;
    $check_username = $developer->where('dev_username', $username);
    $check_email = $developer->where('dev_email', $username);
    $valid = false;
    if( $check_username->count() === 1 )
    {
      $result = $check_username->first();
      $valid = true;
    }
    else if( $check_email->count() === 1 )
    {
      $result = $check_email->first();
      $valid = true;
    }
    else { $valid = false; }

    if( $valid )
    {
      if( $result->dev_password === md5( $password ) )
      {
        $res = [
          'status' => 200,
          'statusText' => 'login success'
        ];
      }
      else
      {
        $res = [
          'status' => 401,
          'statusText' => 'Password tidak sesuai.'
        ];
      }
    }
    else
    {
      $res = [
        'status' => 401,
        'statusText' => 'Username atau Email tidak terdaftar.'
      ];
    }

    return response()->json( $res, $res['status'] );
  }
}

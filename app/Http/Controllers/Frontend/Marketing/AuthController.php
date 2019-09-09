<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use App\Database\MarketingUser;
use App\Http\Controllers\Controller;

class AuthController extends Controller
{
  public function do_login( Request $request, MarketingUser $marketinguser )
  {
    $username = $request->username;
    $password = $request->password;
    $check_username = $marketinguser->where('mkt_username', $username);
    $check_email = $marketinguser->where('mkt_email', $username);
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
      if( $result->mkt_password === md5( $password ) )
      {
        $res = [
          'status' => 200,
          'statusText' => 'login success'
        ];

        session()->put('isMarketing', true);
        session()->put('mkt_user_id', $result->mkt_user_id);
        session()->put('mkt_email', $result->mkt_email);
        session()->put('mkt_login_date', date('Y-m-d H:i:s'));
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

  public function do_register( Request $request, MarketingUser $marketinguser )
  {
    $fullname = $request->mkt_fullname;
    $email = $request->mkt_email;
    $username = $request->mkt_username;
    $password = $request->mkt_password;
    $hash_password = md5( $password );
    $check_username = $marketinguser->where('mkt_username', $username);
    $check_email = $marketinguser->where('mkt_email', $email);

    if( $check_username->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $username . ' sudah digunakan'
      ];
    }
    else if( $check_email->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $email . ' sudah digunakan'
      ];
    }
    else
    {
      $insert = new $marketinguser;
      $insert->mkt_fullname = $fullname;
      $insert->mkt_email = $email;
      $insert->mkt_username = $username;
      $insert->mkt_password = $hash_password;
      $insert->save();

      $getuser = $marketinguser->where([
        ['mkt_username', $username],
        ['mkt_password', $hash_password]
      ])->first();

      session()->put('isMarketing', true);
      session()->put('mkt_user_id', $getuser->mkt_user_id);
      session()->put('mkt_email', $getuser->mkt_email);
      session()->put('mkt_login_date', date('Y-m-d H:i:s'));

      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function do_logout()
  {
    if( session()->has('isMarketing') )
    {
      session()->forget('isMarketing');
      session()->forget('mkt_user_id');
      session()->forget('mkt_email');
      session()->forget('mkt_login_date');
      session()->flush();
    }

    return redirect()->route('homepage');
  }
}

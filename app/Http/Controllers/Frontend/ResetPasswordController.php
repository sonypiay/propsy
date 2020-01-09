<?php

namespace App\Http\Controllers\Frontend;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Database\ResetPassword;
use App\Database\Customer;
use App\Database\MarketingUser;
use App\Database\DeveloperUser;
use App\Http\Controllers\Controller;

class ResetPasswordController extends Controller
{
  public function email_page()
  {
    return response()->view('frontend.mailing.link_reset_password', [
      'email' => 'sonypiay@mail.com',
      'token' => '12345678'
    ]);
  }

  public function change_password_page( Request $request, ResetPassword $resetpassword )
  {
    $token = $request->token;
    $checktoken = $resetpassword->where('token', $token);
    $data = [];
    $data['token'] = '';
    $data['expired'] = false;
    $data['current_time'] = date('H:i', time());

    if( $checktoken->count() === 1 )
    {
      $data['token'] = $token;
      $result = $checktoken->first();
      if( time() > $result->expired_token )
      {
        $data['expired'] = true;
      }
      $data['expired_token'] = date('H:i', $result->expired_token);
    }

    return response()->view('frontend.mailing.reset_password', $data);
  }

  public function change_password( Request $request, Customer $customer, MarketingUser $marketing, DeveloperUser $developer, ResetPassword $resetpassword )
  {
    $token = $request->token;
    $password = $request->password;
    $hash_password = Hash::make( $password,  ['rounds' => 12]);
    $gettoken = $resetpassword->where('token', $token);

    if( $gettoken->count() === 0 )
    {
      $res = [
        'status' => 404,
        'statusText' => 'Token tidak ditemukan'
      ];
    }
    else
    {
      $result = $gettoken->first();
      if( time() > $result->expired_token )
      {
        $res = [
          'status' => 401,
          'statusText' => 'Token kadaluarsa'
        ];
      }
      else
      {
        if( $result->usertype === 'customer' )
        {
          $update = $customer->where('customer_email', $result->useremail)->first();
          $update->customer_password = $hash_password;
        }
        else if( $result->usertype === 'developer' )
        {
          $update = $developer->where('dev_email', $result->useremail)->first();
          $update->dev_password = $hash_password;
        }
        else
        {
          $update = $marketing->where('mkt_email', $result->useremail)->first();
          $update->mkt_password = $hash_password;
        }

        $update->save();
        $resetpassword->where('useremail', $result->useremail)->delete();

        $res = [
          'status' => 200,
          'statusText' => 'success'
        ];
      }
    }

    return response()->json( $res, $res['status'] );
  }
}

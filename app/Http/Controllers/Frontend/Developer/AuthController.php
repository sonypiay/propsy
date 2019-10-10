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
      if( Hash::check( $password, $result->dev_password ) )
      {
        session()->put('isDeveloper', true);
        session()->put('dev_user_id', $result->dev_user_id);
        session()->put('dev_email', $result->dev_email);
        session()->put('dev_login_date', date('Y-m-d H:i:s'));

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

  public function do_register( Request $request, DeveloperUser $developeruser )
  {
    $username = $request->dev_username;
    $password = $request->dev_password;
    $email = $request->dev_email;
    $ownername = $request->dev_ownername;
    $biography = $request->dev_biography;
    $name = $request->dev_name;
    $hash_password = Hash::make( $password, ['rounds' => 12]);
    $check_username = $developeruser->where('dev_username', $username);
    $check_email = $developeruser->where('dev_email', $email);

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
      $insert = new $developeruser;
      $insert->dev_user_id = $developeruser->generateId();
      $insert->dev_name = $name;
      $insert->dev_slug = str_slug( $name );
      $insert->dev_ownername = $ownername;
      $insert->dev_username = $username;
      $insert->dev_password = $hash_password;
      $insert->dev_email = $email;
      $insert->dev_biography = $biography;
      $insert->save();

      $res = [ 'status' => 200, 'statusText' => 'success' ];
      $getuser = $developeruser->where([
        ['dev_username', $username],
        ['dev_password', $hash_password]
      ])->first();

      session()->put('isDeveloper', true);
      session()->put('dev_user_id', $getuser->dev_user_id);
      session()->put('dev_email', $getuser->dev_email);
      session()->put('dev_login_date', date('Y-m-d H:i:s'));
    }

    return response()->json( $res, $res['status'] );
  }

  public function do_logout()
  {
    if( session()->has('isDeveloper') )
    {
      session()->forget('isDeveloper');
      session()->forget('dev_user_id');
      session()->forget('dev_email');
      session()->forget('dev_login_date');
      session()->flush();
    }

    return redirect()->route('homepage');
  }
}

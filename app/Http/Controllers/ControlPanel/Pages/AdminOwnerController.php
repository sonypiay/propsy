<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;

class AdminOwnerController extends Controller
{
  public function index( Request $request, AdminOwner $owner, $pagenav = null )
  {
    if( session()->has('isControlPanel') )
    {
      if( $pagenav === null ) $pagenav = 'profile';
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo(),
        'pagenav' => $pagenav
      ];
      return response()->view('controlpanel.pages.profile', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function change_password( Request $request, AdminOwner $owner )
  {
    $password = $request->password;
    $hash_password = md5( $password );
    $owner = $owner->getinfo();
    $owner->admin_password = $hash_password;
    $owner->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function change_email( Request $request, AdminOwner $owner )
  {
    $email = $request->email;
    $getowner = $owner->getinfo();
    if( $email !== $getowner->admin_email )
    {
      $check_email = $owner->where('admin_email', $email);
      if( $check_email->count() === 0 )
      {
        $getowner->admin_email = $email;
        $getowner->save();

        $res = [
          'status' => 200,
          'statusText' => 'success'
        ];
      }
      else
      {
        $res = [
          'status' => 409,
          'statusText' => $email . ' sudah digunakan.'
        ];
      }
    }
    else
    {
      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }

    return response()->json( $res, $res['status'] );
  }

  public function change_profile( Request $request, AdminOwner $owner )
  {
    $fullname = $request->fullname;
    $username = $request->username;
    $getowner = $owner->getinfo();
    $getowner->admin_fullname = $fullname;
    if( $getowner->admin_username !== $username )
    {
      $check_username = $owner->where('admin_username', $username);
      if( $check_username->count() === 0 )
      {
        $getowner->admin_username = $username;
        $res = [
          'status' => 200,
          'statusText' => 'success'
        ];
      }
      else
      {
        $res = [
          'status' => 409,
          'statusText' => $username . ' sudah digunakan.'
        ];
      }
    }
    else
    {
      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }
    $getowner->save();

    return response()->json( $res, $res['status'] );
  }
}

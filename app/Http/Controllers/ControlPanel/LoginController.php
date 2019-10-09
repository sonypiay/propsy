<?php

namespace App\Http\Controllers\ControlPanel;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;

class LoginController extends Controller
{
  public function index( Request $request )
  {
    if( session()->has('isControlPanel') )
    {
      return redirect()->route('cp_dashboard_page');
    }
    else
    {
      $data = [ 'request' => $request ];
      return response()->view('controlpanel.pages.login', $data);
    }
  }

  public function do_login( Request $request, AdminOwner $owner )
  {
    $username = $request->username;
    $password = $request->password;
    $check_username = $owner->where('admin_username', $username);
    if( $check_username->count() === 0 )
    {
      $res = [
        'status' => 401,
        'statusText' => 'Username tidak ada'
      ];
    }
    else
    {
      $getresult = $check_username->first();
      if( Hash::check( $password, $getresult->admin_password ) )
      {
        session()->put('isControlPanel', true);
        session()->put('cp_admin_id', $getresult->admin_id);
        $res = [
          'status' => 200,
          'statusText' => 'success'
        ];
      }
      else
      {
        $res = [
          'status' => 401,
          'statusText' => 'Password salah.'
        ];
      }
    }

    return response()->json( $res, $res['status'] );
  }

  public function do_logout()
  {
    if( session()->has('isControlPanel') )
    {
      session()->forget('isControlPanel');
      session()->forget('cp_admin_id');
      session()->flush();
    }

    return redirect()->route('cp_login_page');
  }
}

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

  public function admin_page( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];
      return response()->view('controlpanel.pages.manajemen.admin', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_admin_owner( Request $request, AdminOwner $owner )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $getowner = $owner
    ->orderBy('admin_id', 'desc');

    if( ! empty( $keywords ) )
    {
      $getowner = $getowner->where('admin_username', 'like', '%' . $keywords . '%')
      ->orWhere('admin_fullname', 'like', '%' . $keywords . '%')
      ->orWhere('admin_email', 'like', '%' . $keywords . '%');
    }

    $result = $getowner->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function store( Request $request, AdminOwner $owner )
  {
    $admin_fullname = $request->admin_fullname;
    $admin_email = $request->admin_email;
    $admin_username = $request->admin_username;
    $admin_password = $request->admin_password;
    $admin_gender = $request->admin_gender;
    $hash_password = md5( $admin_password );

    $check_email = $owner->where('admin_email', $admin_email);
    $check_username = $owner->where('admin_username', $admin_username);
    $getowner = $owner->getinfo();
    if( $check_email->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $admin_email . ' sudah digunakan'
      ];
    }
    else if( $check_username->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $admin_username . ' sudah digunakan'
      ];
    }
    else
    {
      $owner->admin_fullname = $admin_fullname;
      $owner->admin_username = $admin_username;
      $owner->admin_email = $admin_email;
      $owner->admin_password = $hash_password;
      $owner->admin_gender = $admin_gender;
      $owner->created_by = $getowner->admin_fullname;
      $owner->save();

      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }
    return response()->json( $res, $res['status'] );
  }

  public function save( Request $request, AdminOwner $owner, $id )
  {
    $admin_fullname = $request->admin_fullname;
    $admin_email = $request->admin_email;
    $admin_username = $request->admin_username;
    $admin_password = $request->admin_password;
    $admin_gender = $request->admin_gender;
    $hash_password = md5( $admin_password );

    $check_email = $owner->where('admin_email', $admin_email);
    $check_username = $owner->where('admin_username', $admin_username);
    $getowner = $owner->where('admin_id', $id)->first();

    $getowner->admin_fullname = $admin_fullname;
    if( ! empty( $admin_password ) ) $getowner->admin_password = $hash_password;
    $getowner->admin_gender = $admin_gender;

    if( $getowner->admin_email !== $admin_email )
    {
      if( $check_email->count() > 0 )
      {
        $res = [
          'status' => 409,
          'statusText' => $admin_email . ' sudah digunakan'
        ];
      }
      else
      {
        $getowner->admin_email = $admin_email;
        $getowner->save();
        $res = [
          'status' => 200,
          'statusText' => 'success'
        ];
      }
    }
    else if( $getowner->admin_username !== $admin_username )
    {
      if( $check_username->count() > 0 )
      {
        $res = [
          'status' => 409,
          'statusText' => $admin_username . ' sudah digunakan'
        ];
      }
      else
      {
        $getowner->admin_username = $admin_username;
        $getowner->save();
        $res = [
          'status' => 200,
          'statusText' => 'success'
        ];
      }
    }
    else
    {
      $getowner->save();
      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }
    return response()->json( $res, $res['status'] );
  }

  public function destroy( AdminOwner $owner, $id )
  {
    $getowner = $owner->where('admin_id', $id);
    $getowner->delete();
    $res = [
      'status' => 200,
      'statusText' => 'success'
    ];
    return response()->json( $res, $res['status'] );
  }
}

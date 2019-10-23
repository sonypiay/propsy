<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Database\ProvinceDB;
use App\Database\CityDB;
use App\Database\ResetPassword;
use App\Mail\LinkResetPassword;
use App\Http\Controllers\Controller;
use Mail;

class DeveloperController extends Controller
{
  public function index( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasrequest' => $developeruser->hasrequest()
      ];

      return response()->view('frontend.pages.developer.dashboard_page', $data);
    }
    else
    {
      return redirect()->route('developer_login_page');
    }
  }

  public function login_page( Request $request )
  {
    if( ! session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
      ];

      return response()->view('frontend.pages.developer.login', $data);
    }
    else
    {
      return redirect()->route('developer_profile_page');
    }
  }

  public function register_page( Request $request )
  {
    if( ! session()->has('isDeveloper') )
    {
      $data = [ 'request' => $request ];

      return response()->view('frontend.pages.developer.register', $data);
    }
    else
    {
      return redirect()->route('developer_profile_page');
    }
  }

  public function profile_page( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasrequest' => $developeruser->hasrequest()
      ];

      return response()->view('frontend.pages.developer.profile_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function change_account_information( Request $request, DeveloperUser $developeruser )
  {
    $name = $request->name;
    $slug_name = str_slug( $name );
    $ownername = $request->ownername;
    $phone_office = $request->phone_office;
    $mobile_phone = $request->mobile_phone;
    $city = $request->city;
    $biography = $request->biography;
    $address = $request->address;
    $username = $request->username;
    $getinfo = $developeruser->getinfo();

    $getinfo->dev_name = $name;
    $getinfo->dev_slug = $slug_name;
    $getinfo->dev_ownername = $ownername;
    $getinfo->dev_phone_office = $phone_office;
    $getinfo->dev_mobile_phone = $mobile_phone;
    $getinfo->city_id = $city;
    $getinfo->dev_biography = $biography;
    $getinfo->dev_address = $address;

    if( $getinfo->dev_username === $username )
    {
      $getinfo->save();

      $res = [ 'status' => 200, 'statusText' => 'success' ];
    }
    else
    {
      $check_username = $developeruser->where('dev_username', $username)->count();
      if( $check_username > 0 )
      {
        $res = [ 'status' => 409, 'statusText' => $username . ' sudah digunakan' ];
      }
      else
      {
        $getinfo->dev_username = $username;
        $getinfo->save();
        $res = [ 'status' => 200, 'statusText' => 'success' ];
      }
    }
    return response()->json( $res, $res['status'] );
  }

  public function change_password( Request $request, DeveloperUser $developeruser )
  {
    $password = $request->password;
    $hash_password = Hash::make( $password, ['rounds' => 12]);
    $getinfo = $developeruser->getinfo();
    $getinfo->dev_password = $hash_password;
    $getinfo->save();

    return response()->json([ 'status' => 200, 'statusText' => 'success' ], 200);
  }

  public function change_email( Request $request, DeveloperUser $developeruser )
  {
    $email = $request->email;
    $getinfo = $developeruser->getinfo();
    $check_email = $developeruser->where('dev_email', $email);

    if( $getinfo->dev_email !== $email )
    {
      if( $check_email->count() > 0 )
      {
        $res = [ 'status' => 409, 'statusText' => $email . ' sudah digunakan.' ];
      }
      else
      {
        $getinfo->dev_email = $email;
        $getinfo->save();
        $res = [ 'status' => 200, 'statusText' => 'success' ];
      }
    }
    else
    {
      $res = [ 'status' => 200, 'statusText' => 'success' ];
    }
    return response()->json( $res, $res['status'] );
  }

  public function upload_logo( Request $request, DeveloperUser $developeruser )
  {
    $logo_brand = $request->logo_brand;
    $filename = $logo_brand->hashName();
    $storage = Storage::disk('assets');
    $getinfo = $developeruser->getinfo();
    $path_img = 'images/devlogo';
    if( ! empty( $getinfo->dev_logo ) )
    {
      if( $storage->exists( $path_img . '/' . $getinfo->dev_logo ) )
      {
        $storage->delete( $path_img . '/' . $getinfo->dev_logo );
      }
    }
    $getinfo->dev_logo = $filename;
    $getinfo->save();
    $storage->putFileAs($path_img, $logo_brand, $filename );
    $res = ['status' => 200, 'statusText' => 'upload success'];
    return response()->json( $res, $res['status'] );
  }

  public function reset_password_page( Request $request )
  {
    $data = [ 'request' => $request ];
    return response()->view('frontend.pages.developer.reset_password', $data);
  }

  public function send_password_token( Request $request, ResetPassword $resetpassword, DeveloperUser $developeruser, MarketingUser $marketinguser, $usertype )
  {
    $email = $request->email;
    $expired_date = time() + 60 * 30;
    $token = sha1( Hash::make( $email ) );
    if( $usertype === 'developer' )
    {
      $check_email = $developeruser->where('dev_email', $email)->count();
    }
    else
    {
      $check_email = $marketinguser->where('mkt_email', $email)->count();
    }

    if( $check_email === 1 )
    {
      $data_reset_password = [
        'token' => $token,
        'expired' => $expired_date,
        'email' => $email,
        'usertype' => $usertype
      ];

      $resetpassword->insertResetPassword( $data_reset_password );
      Mail::send( new LinkResetPassword( $token, $email ) );
    }

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

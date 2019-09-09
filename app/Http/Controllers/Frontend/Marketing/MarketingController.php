<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\MarketingUser;
use App\Http\Controllers\Controller;

class MarketingController extends Controller
{
  public function index( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];

      return response()->view('frontend.pages.marketing.dashboard_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function login_page( Request $request )
  {
    if( ! session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
      ];

      return response()->view('frontend.pages.marketing.login', $data);
    }
    else
    {
      return redirect()->route('marketing_profile_page');
    }
  }

  public function register_page( Request $request )
  {
    if( ! session()->has('isDeveloper') )
    {
      $data = [ 'request' => $request ];

      return response()->view('frontend.pages.marketing.register', $data);
    }
    else
    {
      return redirect()->route('marketing_profile_page');
    }
  }

  public function profile_page( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];

      return response()->view('frontend.pages.marketing.profile_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function change_password( Request $request, MarketingUser $marketinguser )
  {
    $password = $request->password;
    $hash_password = md5( $password );
    $getinfo = $marketinguser->getinfo();
    $getinfo->mkt_password = $hash_password;
    $getinfo->save();

    return response()->json([ 'status' => 200, 'statusText' => 'success' ], 200);
  }

  public function change_email( Request $request, MarketingUser $marketinguser )
  {
    $email = $request->email;
    $getinfo = $marketinguser->getinfo();
    $check_email = $marketinguser->where('mkt_email', $email);

    if( $getinfo->mkt_email !== $email )
    {
      if( $check_email->count() > 0 )
      {
        $res = [ 'status' => 409, 'statusText' => $email . ' sudah digunakan.' ];
      }
      else
      {
        $getinfo->mkt_email = $email;
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

  public function change_account_information( Request $request, MarketingUser $marketinguser )
  {
    $fullname = $request->fullname;
    $phone_number = $request->phone_number;
    $mobile_phone = $request->mobile_phone;
    $city = $request->city;
    $region = $request->region;
    $biography = $request->biography;
    $username = $request->username;
    $address = $request->address;
    $getinfo = $marketinguser->getinfo();

    $getinfo->mkt_fullname = $fullname;
    $getinfo->mkt_phone_number = $phone_number;
    $getinfo->mkt_mobile_phone = $mobile_phone;
    $getinfo->mkt_city = $city;
    $getinfo->mkt_region = $region;
    $getinfo->mkt_biography = $biography;
    $getinfo->mkt_address = $address;

    if( $getinfo->mkt_username == $username )
    {
      $getinfo->save();
      $res = ['status' => 200, 'statusText' => 'success'];
    }
    else
    {
      $checkusername = $marketinguser->where('mkt_username', $username)->count();
      if( $checkusername > 0 )
      {
        $res = ['status' => 409, 'statusText' => $username . ' sudah digunakan.'];
      }
      else
      {
        $getinfo->mkt_username = $username;
        $getinfo->save();
        $res = ['status' => 200, 'statusText' => 'success'];
      }
    }

    return response()->json( $res, $res['status'] );
  }

  public function upload_photo_profile( Request $request, MarketingUser $marketinguser )
  {
    $photo_profile = $request->photo_profie;
    $filename = $photo_profile->hashName();
    $storage = Storage::disk('assets');
    $getinfo = $marketinguser->getinfo();
    $path_img = 'images/avatar';
    if( ! empty( $getinfo->mkt_profile_photo ) )
    {
      if( $storage->exists( $path_img . '/' . $getinfo->mkt_profile_photo ) )
      {
        $storage->delete( $path_img . '/' . $getinfo->mkt_profile_photo );
      }
    }
    $getinfo->mkt_profile_photo = $filename;
    $getinfo->save();
    $storage->putFileAs($path_img, $photo_profile, $filename );
    $res = ['status' => 200, 'statusText' => 'upload success'];
    return response()->json( $res, $res['status'] );
  }
}

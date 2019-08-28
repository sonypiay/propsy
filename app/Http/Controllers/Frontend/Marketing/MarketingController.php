<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
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

  public function settings_page( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];

      return response()->view('frontend.pages.marketing.settings_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
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
    $getinfo = $marketinguser->getinfo();

    if( $getinfo->mkt_username == $username )
    {
      $getinfo->mkt_fullname = $fullname;
      $getinfo->mkt_phone_number = $phone_number;
      $getinfo->mkt_mobile_phone = $mobile_phone;
      $getinfo->mkt_city = $city;
      $getinfo->mkt_region = $region;
      $getinfo->mkt_biography = $biography;
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
        $getinfo->mkt_fullname = $fullname;
        $getinfo->mkt_phone_number = $phone_number;
        $getinfo->mkt_mobile_phone = $mobile_phone;
        $getinfo->mkt_city = $city;
        $getinfo->mkt_region = $region;
        $getinfo->mkt_biography = $biography;
        $getinfo->save();
        $res = ['status' => 200, 'statusText' => 'success'];
      }
    }

    return response()->json( $res, $res['status'] );
  }
}

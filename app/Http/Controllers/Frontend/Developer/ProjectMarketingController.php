<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Database\CityDB;
use App\Http\Controllers\Controller;

class ProjectMarketingController extends Controller
{
  public function index( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $city = new CityDB;
      $getcity = $city->orderBy('city_name', 'asc')->get();

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'getcity' => $getcity
      ];
      return response()->view('frontend.pages.developer.manage_marketing', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function listOfMarketing( Request $request, MarketingUser $marketinguser )
  {
    $keywords = $request->keywords;
    $sorting = $request->sorting;
    $limit = 10;
    $column = $request->column;
    $city = $request->city;

    $marketing = $marketinguser->select(
      'marketing_user.mkt_user_id',
      'marketing_user.mkt_fullname',
      'marketing_user.mkt_email',
      'marketing_user.mkt_phone_number',
      'marketing_user.mkt_mobile_phone',
      'marketing_user.mkt_city',
      'marketing_user.mkt_username',
      'marketing_user.mkt_password',
      'city.city_id',
      'city.city_name',
      'province.province_id',
      'province.province_name'
    )
    ->join('city', 'marketing_user.mkt_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id');

    if( empty( $keywords ) )
    {
      $getmarketing = $marketing->where('dev_user_id', session()->get('dev_user_id'))
      ->orderBy('marketing_user.mkt_fullname', $sorting);
      if( $city !== 'all' )
      {
        $getmarketing = $marketing->where([
          ['marketing_user.mkt_city', $city],
          ['marketing_user.dev_user_id', session()->get('dev_user_id')]
        ])
        ->orderBy('marketing_user.mkt_fullname', $sorting);
      }
    }
    else
    {
      $getmarketing = $marketing->where([
        ['marketing_user.' . $column, 'like', '%' . $keywords. '%'],
        ['marketing_user.dev_user_id', session()->get('dev_user_id')]
      ])
      ->orderBy('marketing_user.mkt_fullname', $sorting);

      if( $city !== 'all' )
      {
        $getmarketing = $marketing->where([
          ['marketing_user.' . $column, 'like', '%' . $keywords. '%'],
          ['marketing_user.mkt_city', $city],
          ['marketing_user.dev_user_id', session()->get('dev_user_id')]
        ])
        ->orderBy('marketing_user.mkt_fullname', $sorting);
      }
    }

    $result = $getmarketing->paginate( $limit );
    $res = [ 'results' => $result ];
    return response()->json( $res, 200 );
  }

  public function add_marketing( Request $request, MarketingUser $marketinguser )
  {
    $fullname = $request->mkt_fullname;
    $email = $request->mkt_email;
    $username = $request->mkt_username;
    $password = $request->mkt_password;
    $hash_password = md5( $password );
    $city = $request->mkt_city;
    $phone_number = $request->mkt_phone_number === '' ? null : $request->mkt_phone_number;
    $mobile_phone = $request->mkt_mobile_phone;
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
      $insert->mkt_city = $city;
      $insert->mkt_phone_number = $phone_number;
      $insert->mkt_mobile_phone = $mobile_phone;
      $insert->dev_user_id = session()->get('dev_user_id');
      $insert->save();
      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function save_marketing( Request $request, MarketingUser $marketinguser, $userid )
  {
    $fullname = $request->mkt_fullname;
    $email = $request->mkt_email;
    $username = $request->mkt_username;
    $password = $request->mkt_password;
    $hash_password = md5( $password );
    $city = $request->mkt_city;
    $phone_number = $request->mkt_phone_number === '' ? null : $request->mkt_phone_number;
    $mobile_phone = $request->mkt_mobile_phone;
    $getmarketing = $marketinguser->where('mkt_user_id', $userid)->first();
    $iserror = false;

    $getmarketing->mkt_fullname = $fullname;
    if( ! empty( $password ) ) $getmarketing->mkt_password = $hash_password;
    $getmarketing->mkt_city = $city;
    $getmarketing->mkt_phone_number = $phone_number;
    $getmarketing->mkt_mobile_phone = $mobile_phone;

    if( $getmarketing->mkt_email != $email )
    {
      $check_email = $marketinguser->where('mkt_email', $email);
      if( $check_email->count() > 0 )
      {
        $iserror = true;
        $res = [
          'status' => 409,
          'statusText' => $email . ' sudah digunakan'
        ];
      }
      else
      {
        $iserror = false;
        $getmarketing->mkt_email = $email;
      }
    }
    else if( $getmarketing->mkt_username != $username )
    {
      $check_username = $marketinguser->where('mkt_username', $username);
      if( $check_username->count() > 0 )
      {
        $iserror = true;
        $res = [
          'status' => 409,
          'statusText' => $username . ' sudah digunakan'
        ];
      }
      else
      {
        $iserror = false;
        $getmarketing->mkt_username = $username;
      }
    }
    else
    {
      $iserror = false;
    }

    if( $iserror === false )
    {
      $getmarketing->save();
      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function delete_marketing( MarketingUser $marketinguser, $userid )
  {
    $getmarketing = $marketinguser->where('mkt_user_id', $userid);
    if( $getmarketing->count() === 1 )
    {
      $getmarketing->delete();
    }
    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

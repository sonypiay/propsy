<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;
use PDF;

class DeveloperController extends Controller
{
  public function get_developer( Request $request, DeveloperUser $developeruser )
  {
    $keywords = $request->keywords;
    $city = $request->city;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getdeveloper = $developeruser->select(
      'developer_user.dev_user_id',
      'developer_user.dev_name',
      'developer_user.dev_ownername',
      'developer_user.dev_address',
      'developer_user.dev_username',
      'developer_user.dev_password',
      'developer_user.dev_email',
      'developer_user.dev_biography',
      'developer_user.dev_phone_office',
      'developer_user.dev_mobile_phone',
      'developer_user.dev_ownership',
      'developer_user.dev_logo',
      'developer_user.status_verification',
      'developer_user.created_at',
      'developer_user.updated_at',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'developer_user.dev_city', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('developer_user.created_at', 'desc');

    if( $city !== 'all' )
    {
      $getdeveloper = $getdeveloper->where('developer_user.dev_city', $city);
    }
    if( ! empty( $keywords ) )
    {
      $getdeveloper = $getdeveloper->where('developer_user.dev_name', 'like', '%' . $keywords . '%')
      ->orWhere('developer_user.dev_ownername', 'like', '%' . $keywords . '%');
    }

    $result = $getdeveloper->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, DeveloperUser $developeruser )
  {
    $keywords = $request->keywords;
    $city = $request->city;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getdeveloper = $developeruser->select(
      'developer_user.dev_user_id',
      'developer_user.dev_name',
      'developer_user.dev_ownername',
      'developer_user.dev_address',
      'developer_user.dev_username',
      'developer_user.dev_password',
      'developer_user.dev_email',
      'developer_user.dev_biography',
      'developer_user.dev_phone_office',
      'developer_user.dev_mobile_phone',
      'developer_user.dev_ownership',
      'developer_user.dev_logo',
      'developer_user.status_verification',
      'developer_user.created_at',
      'developer_user.updated_at',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'developer_user.dev_city', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('developer_user.created_at', 'desc');

    if( $city !== 'all' )
    {
      $getdeveloper = $getdeveloper->where('developer_user.dev_city', $city);
    }
    if( ! empty( $keywords ) )
    {
      $getdeveloper = $getdeveloper->where('developer_user.dev_name', 'like', '%' . $keywords . '%')
      ->orWhere('developer_user.dev_ownername', 'like', '%' . $keywords . '%');
    }

    $result = $getdeveloper->paginate( $limit );
    return response()->json( $result, 200 );
  }
}

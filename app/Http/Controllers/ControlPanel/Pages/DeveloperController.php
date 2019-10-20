<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\AdminOwner;
use App\Database\CityDB;
use App\Http\Controllers\Controller;
use PDF;

class DeveloperController extends Controller
{
  public function index( Request $request, AdminOwner $owner, CityDB $city )
  {
    if( session()->has('isControlPanel') )
    {
      $getcity = $city->orderBy('city_name', 'asc')->get();
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo(),
        'getcity' => $getcity
      ];
      return response()->view('controlpanel.pages.developer.developer', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_developer( Request $request, DeveloperUser $developeruser )
  {
    $keywords = $request->keywords;
    $city = $request->city;
    $status = $request->status;
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
      'developer_user.dev_logo',
      'developer_user.status_verification',
      'developer_user.created_at',
      'developer_user.updated_at',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'developer_user.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('developer_user.created_at', 'desc');

    if( $city !== 'all' )
    {
      $getdeveloper = $getdeveloper->where('developer_user.city_id', $city);
    }

    if( $status !== 'all' )
    {
      $getdeveloper = $developeruser->where('developer_user.status_verification', $status);
    }

    if( ! empty( $keywords ) )
    {
      $getdeveloper = $getdeveloper->where(function( $query ) use ( $keywords ) {
        $query->where('developer_user.dev_name', 'like', '%' . $keywords . '%')
        ->orWhere('developer_user.dev_ownername', 'like', '%' . $keywords . '%');
      });
    }

    $result = $getdeveloper->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, DeveloperUser $developeruser, CityDB $citydb )
  {
    $city = $request->city;
    $status = $request->status;

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
      'developer_user.dev_logo',
      'developer_user.status_verification',
      'developer_user.created_at',
      'developer_user.updated_at',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'developer_user.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('developer_user.created_at', 'asc');
    $getcity = '';

    if( $city !== 'all' )
    {
      $getdeveloper = $getdeveloper->where('developer_user.city_id', $city);
      $getcity = $citydb->where('city_id', $city)->first();
    }

    if( $status !== 'all' )
    {
      $getdeveloper = $developeruser->where('developer_user.status_verification', $status);
    }

    $filename = 'DeveloperUser-' . date('dmY') . '.pdf';
    $res = [
      'filename' => $filename,
      'result' => $getdeveloper->get(),
      'getcity' => $getcity
    ];
    return PDF::loadView('controlpanel.pages.reports.developer', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }
}

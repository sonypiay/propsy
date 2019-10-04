<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\CityDB;
use App\Database\ProvinceDB;
use App\Http\Controllers\Controller;

class CityController extends Controller
{
  public function index( Request $request, AdminOwner $owner, ProvinceDB $province )
  {
    if( session()->has('isControlPanel') )
    {
      $getprovince = $province->orderBy('province_name', 'asc')->get();
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo(),
        'getprovince' => $getprovince
      ];

      return respose()->view('controlpanel.pages.city', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_city( Request $request, CityDB $city )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $whereClause = [];

    $getcity = $province->select(
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->join('province', 'city.province_id', '=' ,'province.province_id')
    ->where('city_name', 'like', '%' . $keywords . '%')
    ->orWhere('province_name', 'like', '%' . $keywords . '%')
    ->orderBy('city.city_id', 'desc')
    ->paginate( $limit );

    return response()->json( $getcity, 200 );
  }

  public function store( Request $request, CityDB $city )
  {
    $city_name = $request->province_name;
    $slug_name = str_slug( $city_name );
    $province = $request->province;

    $city->city_name = $city_name;
    $city->city_slug = $slug_name;
    $city->province_id = $province;
    $city->save();

    $res = ['status' => 200, 'statusText' => 'success'];

    return response()->json( $res, 200 );
  }

  public function save( Request $request, ProvinceDB $province, $id )
  {
    $province_name = $request->province_name;

    $getprovince = $province->where('province_id', $id)->first();
    $getprovince->province_name = $province_name;
    $getprovince->province_slug = $slug_name;
    $getprovince->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }

  public function destroy( Request $request, ProvinceDB $province, $id )
  {
    $getprovince = $province->where('province_id', $id);
    $getprovince->delete();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }
}

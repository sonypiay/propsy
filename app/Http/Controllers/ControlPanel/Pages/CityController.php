<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\AdminOwner;
use App\Database\CityDB;
use App\Database\ProvinceDB;
use App\Http\Controllers\Controller;

class CityController extends Controller
{
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];

      return response()->view('controlpanel.pages.wilayah.kota', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_city( Request $request, CityDB $city )
  {
    $keywords = $request->keywords;
    $limit = 10;
    $whereClause = [];

    $getcity = $city->select(
      'city.city_id',
      'city.city_name',
      'province.province_id',
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
    $city_name = $request->city_name;
    $slug_name = str_slug( $city_name );
    $province = $request->province;

    $city->city_name = $city_name;
    $city->city_slug = $slug_name;
    $city->province_id = $province;
    $city->save();

    $res = ['status' => 200, 'statusText' => 'success'];

    return response()->json( $res, 200 );
  }

  public function save( Request $request, CityDB $city, $id )
  {
    $city_name = $request->city_name;
    $slug_name = str_slug( $city_name );
    $province = $request->province;
    $getcity = $city->where('city_id', $id)->first();

    $getcity->city_name = $city_name;
    $getcity->city_slug = $slug_name;
    $getcity->province_id = $province;
    $getcity->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }

  public function destroy( Request $request, CityDB $city, $id )
  {
    $getcity = $city->where('city_id', $id);
    $getcity->delete();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }
}

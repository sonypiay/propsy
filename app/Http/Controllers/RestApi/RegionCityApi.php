<?php

namespace App\Http\Controllers\RestApi;

use Illuminate\Http\Request;
use App\Database\ProvinceDB;
use App\Database\CityDB;
use App\Http\Controllers\Controller;
use DB;

class RegionCityApi extends Controller
{
  public function provinsi_all( ProvinceDB $province )
  {
    $getprovinsi = $province->orderBy('province_name', 'asc')
    ->get();

    return response()->json([
      'results' => [
        'data' => $getprovinsi,
        'row' => $getprovinsi->count()
      ]
    ]);
  }

  public function provinsi_single( ProvinceDB $province, $id )
  {
    $getprovinsi = $province->where('province_id', $id)
    ->orderBy('province_name', 'asc')
    ->get();

    return response()->json([
      'results' => [
        'data' => $getprovinsi->get()
      ]
    ]);
  }

  public function kota_all( CityDB $city, $provinsi )
  {
    $getcity = $city->select(
      'city.city_id',
      'city.city_name',
      'city.city_slug',
      'province.province_name',
      'province.province_slug'
    )
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->where('city.province_id', $provinsi)
    ->orderBy('city.city_name', 'asc')
    ->get();

    return response()->json([
      'results' => [
        'data' => $getcity,
        'total' => $getcity->count()
      ]
    ]);
  }

  public function kota_single( CityDB $city, $provinsi, $id )
  {
    $getcity = $city->select(
      'city.city_id',
      'city.city_name',
      'city.city_slug',
      'province.province_name',
      'province.province_slug'
    )
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->where([
      ['city.province_id', $provinsi],
      ['city.city_id', $id]
    ])
    ->orderBy('city.city_name', 'asc')
    ->get();

    return response()->json([
      'results' => [
        'data' => $getcity,
        'total' => $getcity->count()
      ]
    ]);
  }
}

<?php

namespace App\Http\Controllers\RestApi;

use Illuminate\Http\Request;
use App\Database\AreaDB;
use App\Http\Controllers\Controller;
use DB;

class RegionCityApi extends Controller
{
  public function provinsi_all( AreaDB $area )
  {
    $getarea = $area->select(
      'area.area_id',
      'area.area_name',
      'area_level.area_level_name'
    )
    ->join('area_level', 'area.area_level_id', '=', 'area_level.area_level_id')
    ->whereNull('area.parent_id');

    return response()->json([
      'results' => [
        'data' => $getarea->get(),
        'row' => $getarea->count()
      ]
    ]);
  }

  public function provinsi_single( AreaDB $area, $id )
  {
    $getarea = $area->select(
      'area.area_id',
      'area.area_name',
      'area_level.area_level_name'
    )
    ->join('area_level', 'area.area_level_id', '=', 'area_level.area_level_id')
    ->where('area.area_id', $id)
    ->whereNull('area.parent_id');

    return response()->json([
      'results' => [
        'data' => $getarea->get()
      ]
    ]);
  }

  public function kabupaten_all( AreaDB $area, $provinsi )
  {
    $getarea = $area->select(
      'area.area_id',
      'area.area_name',
      'area_level.area_level_name'
    )
    ->join('area_level', 'area.area_level_id', '=', 'area_level.area_level_id')
    ->where('area.parent_id', $provinsi);
    $getprovinsi = $area->where('area_id', $provinsi)->first();

    return response()->json([
      'results' => [
        'data' => [
          'provinsi' => $getprovinsi,
          'kabupaten' => $getarea->get()
        ],
        'row' => $getarea->count()
      ]
    ]);
  }

  public function kabupaten_single( AreaDB $area, $provinsi, $id )
  {
    $getarea = $area->select(
      'area.area_id',
      'area.area_name',
      'area_level.area_level_name'
    )
    ->join('area_level', 'area.area_level_id', '=', 'area_level.area_level_id')
    ->where([
      ['area.area_id', $id],
      ['area.parent_id', $provinsi]
    ]);
    $getprovinsi = $area->where('area_id', $provinsi)->first();

    return response()->json([
      'results' => [
        'data' => [
          'provinsi' => $getprovinsi,
          'kabupaten' => $getarea->get()
        ],
        'row' => $getarea->count()
      ]
    ]);
  }

  public function kecamatan_all( AreaDB $area, $kabupaten )
  {
    $getarea = $area->select(
      'area.area_id',
      'area.area_name',
      'area_level.area_level_name'
    )
    ->join('area_level', 'area.area_level_id', '=', 'area_level.area_level_id')
    ->where('area.parent_id', $kabupaten);
    $getkecamatan = $area->where('area_id', $kabupaten)->first();

    return response()->json([
      'results' => [
        'data' => [
          'kabupaten' => $getkecamatan,
          'kecamatan' => $getarea->get()
        ],
        'row' => $getarea->count()
      ]
    ]);
  }

  public function kecamatan_single( AreaDB $area, $kabupaten, $id )
  {
    $getarea = $area->select(
      'area.area_id',
      'area.area_name',
      'area_level.area_level_name'
    )
    ->join('area_level', 'area.area_level_id', '=', 'area_level.area_level_id')
    ->where([
      ['area.parent_id', $kabupaten],
      ['area.area_id', $id]
    ]);
    $getkecamatan = $area->where('area_id', $kabupaten)->first();

    return response()->json([
      'results' => [
        'data' => [
          'kabupaten' => $getkecamatan,
          'kecamatan' => $getarea->get()
        ],
        'row' => $getarea->count()
      ]
    ]);
  }
}

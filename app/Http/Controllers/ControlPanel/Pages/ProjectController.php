<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\ProjectGallery;
use App\Database\ProjectUnitGallery;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;
use DB;
use PDF;

class ProjectController extends Controller
{
  public function get_project( Request $request, ProjectList $project_list )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;
    $city = $request->city;

    $getproject = $project_list->select(
      'project_list.project_id',
      'project_list.project_unique_id',
      'project_list.project_name',
      'project_list.project_thumbnail',
      'project_list.project_address',
      'project_list.project_city',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'project_list.dev_user_id',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_name',
      'city.city_name',
      'province.province_name',
      DB::raw('count(project_unit_type.unit_type_id) as total_unit')
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.project_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_unique_id', '=', 'project_unit_type.project_unique_id')
    ->orderBy('project_list.created_at', 'desc')
    ->groupBy('project_list.project_unique_id');

    if( $city !== 'all' )
    {
      $getproject = $getproject->where('project_list.project_city', '=', $city);
    }
    if( ! empty( $keywords ) )
    {
      $getproject = $getproject->where('project_list.project_name', 'like', '%' . $keywords . '%')
      ->orWhere('project_list.project_unique_id', 'like', '%' . $keywords . '%');
    }

    $result = $getproject->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, ProjectList $project_list )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;
    $city = $request->city;

    $getproject = $project_list->select(
      'project_list.project_id',
      'project_list.project_unique_id',
      'project_list.project_name',
      'project_list.project_thumbnail',
      'project_list.project_address',
      'project_list.project_city',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'project_list.dev_user_id',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_name',
      'city.city_name',
      'province.province_name',
      DB::raw('count(project_unit_type.unit_type_id) as total_unit')
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.project_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_unique_id', '=', 'project_unit_type.project_unique_id')
    ->orderBy('project_list.created_at', 'desc')
    ->groupBy('project_list.project_unique_id');

    if( $city !== 'all' )
    {
      $getproject = $getproject->where('project_list.project_city', '=', $city);
    }
    if( ! empty( $keywords ) )
    {
      $getproject = $getproject->where('project_list.project_name', 'like', '%' . $keywords . '%')
      ->orWhere('project_list.project_unique_id', 'like', '%' . $keywords . '%');
    }

    $result = $getproject->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function get_unit_type( ProjectUnitType $unit_type, $project_id )
  {
    $getunit = $unit_type
    ->where('project_unique_id', $project_id)
    ->get();

    $result = [
      'data' => $getunit,
      'total' => $getunit->count()
    ];

    return response()->json( $result, 200 );
  }
}

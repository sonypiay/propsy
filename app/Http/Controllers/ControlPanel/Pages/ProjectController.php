<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\ProjectGallery;
use App\Database\ProjectUnitGallery;
use App\Database\AdminOwner;
use App\Database\CityDB;
use App\Http\Controllers\Controller;
use DB;
use PDF;

class ProjectController extends Controller
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
      return response()->view('controlpanel.pages.property.project', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_project( Request $request, ProjectList $project_list )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;
    $city = $request->city;

    $getproject = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_thumbnail',
      'project_list.project_address',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'project_list.dev_user_id',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_name',
      'city.city_id',
      'city.city_name',
      'province.province_name',
      DB::raw('count(project_unit_type.unit_type_id) as total_unit')
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_id', '=', 'project_unit_type.project_id')
    ->orderBy('project_list.created_at', 'desc')
    ->groupBy('project_list.project_id');

    if( $city !== 'all' )
    {
      $getproject = $getproject->where('project_list.city_id', '=', $city);
    }
    if( ! empty( $keywords ) )
    {
      $getproject = $getproject->where('project_list.project_name', 'like', '%' . $keywords . '%')
      ->orWhere('project_list.project_id', 'like', '%' . $keywords . '%');
    }

    $result = $getproject->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report_project( Request $request, ProjectList $project_list )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;
    $city = $request->city;

    $getproject = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_thumbnail',
      'project_list.project_address',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'project_list.dev_user_id',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_name',
      'city.city_id',
      'city.city_name',
      'province.province_name',
      DB::raw('count(project_unit_type.unit_type_id) as total_unit')
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_id', '=', 'project_unit_type.project_id')
    ->orderBy('project_list.created_at', 'desc')
    ->groupBy('project_list.project_id');
    $getcity = '';

    if( $city !== 'all' )
    {
      $getproject = $getproject->where('project_list.city_id', '=', $city);
      $getcity = CityDB::where('city_id', $city)->first();
    }
    if( ! empty( $keywords ) )
    {
      $getproject = $getproject->where('project_list.project_name', 'like', '%' . $keywords . '%')
      ->orWhere('project_list.project_id', 'like', '%' . $keywords . '%');
    }

    $filename = 'DataProyek-' . date('d/m/Y');
    $res = [
      'filename' => $filename,
      'result' => $getproject->get(),
      'getcity' => $getcity
    ];
    return PDF::loadView('controlpanel.pages.reports.project', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }

  public function index_unit( Request $request, AdminOwner $owner, CityDB $city )
  {
    if( session()->has('isControlPanel') )
    {
      $getcity = $city->orderBy('city_name', 'asc')->get();
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo(),
        'getcity' => $getcity
      ];
      return response()->view('controlpanel.pages.property.projectunit', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_unit_type( Request $request, ProjectUnitType $unit_type )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;
    $city = $request->city;

    $getunit  = $unit_type->select(
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_slug',
      'project_unit_type.unit_price',
      'project_unit_type.unit_floor',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_unit_type.unit_lb',
      'project_unit_type.unit_lt',
      'project_unit_type.unit_price',
      'project_unit_type.unit_watt',
      'project_unit_type.unit_status',
      'project_unit_type.unit_thumbnail',
      'project_unit_type.unit_facility',
      'project_unit_type.unit_description',
      'project_unit_type.created_at',
      'project_list.project_name',
      'project_list.project_type',
      'developer_user.dev_name',
      'city.city_name',
      'province.province_name'
    )
    ->join('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('project_unit_type.created_at', 'desc');

    $getcity = '';
    if( $city !== 'all' )
    {
      $getunit = $getunit->where('project_list.city_id', '=', $city);
      $getcity = CityDB::where('city_id', $city)->first();
    }
    if( $status !== 'all' )
    {
      $getunit = $getunit->where('project_unit_type.unit_status', '=', $status);
    }
    if( ! empty( $keywords ) )
    {
      $getunit = $getunit->where(function($query) use ($keywords) {
        $query->where('project_list.unit_name', 'like', '%' . $keywords . '%')
        ->orWhere('project_list.unit_type_id', 'like', '%' . $keywords . '%')
        ->orWhere('project_list.project_name', 'like', '%' . $keywords . '%')
      });
    }

    $result = $getunit->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report_unit( Request $request, ProjectUnitType $unit_type )
  {
    $keywords = $request->keywords;
    $city = $request->city;
    $status = $request->status;

    $getunit  = $unit_type->select(
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_status',
      'project_unit_type.created_at',
      'project_list.project_name',
      'developer_user.dev_name',
      'city.city_name'
    )
    ->join('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->orderBy('project_unit_type.created_at', 'desc');

    $getcity = '';
    if( $city !== 'all' )
    {
      $getunit = $getunit->where('project_list.city_id', '=', $city);
      $getcity = CityDB::where('city_id', $city)->first();
    }
    if( $status !== 'all' )
    {
      $getunit = $getunit->where('project_unit_type.unit_status', '=', $status);
    }
    if( ! empty( $keywords ) )
    {
      $getunit = $getunit->where(function($query) use ($keywords) {
        $query->where('project_list.unit_name', 'like', '%' . $keywords . '%')
        ->orWhere('project_list.unit_type_id', 'like', '%' . $keywords . '%')
        ->orWhere('project_list.project_name', 'like', '%' . $keywords . '%')
      });
    }

    $filename = 'DataTipeUnit-' . date('d/m/Y');
    $res = [
      'filename' => $filename,
      'result' => $getunit->get(),
      'getcity' => $getcity
    ];
    return response()->view('controlpanel.pages.reports.projectunit', $res);
    //return PDF::loadView('controlpanel.pages.reports.projectunit', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }
}

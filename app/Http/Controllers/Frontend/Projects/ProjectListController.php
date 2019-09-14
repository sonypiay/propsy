<?php

namespace App\Http\Controllers\Frontend\Projects;

use Illuminate\Http\Request;
use App\Database\ProjectList;
use App\Database\ProjectGallery;
use App\Database\ProjectUnit;
use App\Database\ProjectUnitType;
use App\Database\ProjectUnitInstallment;
use App\Database\Customer;
use App\Database\MarketingUser;
use App\Database\DeveloperUser;
use App\Database\AreaDB;
use App\Http\Controllers\Controller;

class ProjectListController extends Controller
{
  public function homepage_available_project( Request $request, ProjectList $project_list )
  {
    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_description',
      'project_list.project_status',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_name',
      'developer_user.dev_slug'
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->where('project_list.project_status', 'available')
    ->orderBy('project_list.created_at', 'desc')
    ->get();
    return response()->json([ 'results' => [ 'total' => $getproject->count(), 'data' => $getproject ] ], 200 );
  }

  public function view_project( Request $request, ProjectList $project_list, ProjectGallery $project_gallery, ProjectUnit $project_unit, AreaDB $area, $slug )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    if( session()->has('isCustomer') )
    {
      $customer = new Customer;
      $data['session_user'] = $customer->getinfo();
    }
    else if( session()->has('isDeveloper') )
    {
      $developer = new DeveloperUser;
      $data['session_user'] = $developer->getinfo();
    }
    else
    {
      $marketing = new MarketingUser;
      $data['session_user'] = $marketing->getinfo();
    }

    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_description',
      'project_list.project_status',
      'project_list.project_address',
      'project_list.project_gmaps',
      'project_list.project_region',
      'project_list.project_city',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'developer_user.dev_logo',
      'developer_user.dev_region',
      'developer_user.dev_city',
      'developer_user.dev_biography'
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->where('project_slug', $slug)
    ->first();

    if( ! $getproject ) abort(404);

    $project_region = $area->where('area_id', $getproject->project_region)->first();
    $project_city = $area->where('area_id', $getproject->project_city)->first();
    $dev_region = $area->where('area_id', $getproject->dev_region)->first();
    $dev_city = $area->where('area_id', $getproject->dev_city)->first();

    $getgallery = $project_gallery->where('project_id', $getproject->project_id)
    ->orderBy('created_at', 'desc')
    ->get();

    $getunitname = $project_unit->select('project_unit_name as unit_name')
    ->where('project_id', $getproject->project_id)
    ->distinct()
    ->get();
    $getunitnumber = $project_unit->select('project_unit_number as unit_number')
    ->where('project_id', $getproject->project_id)
    ->distinct()
    ->get();

    $data['getproject'] = $getproject;
    $data['getgallery'] = $getgallery;
    $data['projectregion'] = [
      'kota' => $project_city,
      'provinsi' => $project_region
    ];
    $data['devregion'] = [
      'kota' => $dev_city,
      'provinsi' => $dev_region
    ];
    $data['getunit'] = [
      'unit_name' => $getunitname,
      'unit_number' => $getunitnumber
    ];

    return response()->view('frontend.pages.view_project', $data);
  }

  public function view_project_unit( Request $request, ProjectUnitType $project_unit, $project_id )
  {
    $offset = $request->offset;
    $unit_name = $request->unit_name;
    $unit_number = $request->unit_number;

    $unit = $project_unit->select(
      'project_unit_type.project_unit_type_id',
      'project_unit_type.unit_floor',
      'project_unit_type.unit_price',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_unit_type.unit_lt',
      'project_unit_type.unit_lb',
      'project_unit.project_unit_id',
      'project_unit.project_unit_name',
      'project_unit.project_unit_number',
      'project_unit.project_unit_status'
    )
    ->join('project_unit', 'project_unit_type.project_unit_id', '=', 'project_unit.project_unit_id');
    if( empty( $unit_name ) and empty( $unit_number ) )
    {
      $unit = $unit->where('project_unit.project_id', $project_id);
    }
    else
    {
      $unit = $unit->where([
        ['project_unit.project_id', $project_id],
        ['project_unit.project_unit_name', $unit_name],
        ['project_unit.project_unit_number', $unit_number]
      ]);
    }
    $getunit = $unit->orderBy('project_unit_type.created_at', 'desc')
    ->limit( 5 )
    ->offset( $offset )
    ->get();

    $res = [
      'results' => [
        'total' => $getunit->count(),
        'data' => $getunit
      ],
      'project_id' => $project_id
    ];
    return response()->json( $res, 200 );
  }
}

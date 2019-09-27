<?php

namespace App\Http\Controllers\Frontend\Projects;

use Illuminate\Http\Request;
use App\Database\ProjectList;
use App\Database\ProjectGallery;
use App\Database\ProjectUnitType;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Database\Customer;
use App\Database\MarketingUser;
use App\Database\DeveloperUser;
use App\Database\AreaDB;
use App\Database\CityDB;
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

  public function view_project( Request $request, ProjectList $project_list, ProjectGallery $project_gallery, ProjectUnitType $unit_type, $slug )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    $data['session_active'] = null;

    if( session()->has('isCustomer') )
    {
      $customer = new Customer;
      $data['session_active'] = 'customer';
      $data['session_user'] = $customer->getinfo();
    }
    else
    {
      $developer = new DeveloperUser;
      $data['session_user'] = $developer->getinfo();
    }

    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_unique_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_description',
      'project_list.project_status',
      'project_list.project_address',
      'project_list.project_link_map',
      'project_list.project_map_embed',
      'project_list.project_city',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'project_list.created_at',
      'project_list.updated_at',
      'developer_user.dev_user_id',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'developer_user.dev_logo',
      'developer_user.dev_city',
      'developer_user.dev_biography'
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->where('project_list.project_slug', $slug)
    ->first();

    if( ! $getproject ) abort(404);

    $city = new CityDB;
    $project_city = $city->join( 'province', 'city.province_id', '=', 'province.province_id' )
    ->where('city.city_id', $getproject->project_city)->first();

    $dev_city = $city->join( 'province', 'city.province_id', '=', 'province.province_id' )
    ->where('city.city_id', $getproject->dev_city)->first();

    $getgallery = $project_gallery->where('project_unique_id', $getproject->project_unique_id)
    ->orderBy('created_at', 'desc')
    ->get();

    $getunit_price = $unit_type->where('project_unique_id', $getproject->project_unique_id)
    ->orderBy('unit_price', 'desc')
    ->first();

    $data['getproject'] = $getproject;
    $data['getgallery'] = $getgallery;
    $data['project_city'] = $project_city;
    $data['dev_city'] = $dev_city;
    $data['getunit_price'] = $getunit_price;

    return response()->view('frontend.pages.view_project', $data);
  }

  public function list_project_unit( Request $request, ProjectUnitType $project_unit, $project_id )
  {
    $filterUnit = $request->filterUnit;
    $getunit = $project_unit->where([
      ['project_unit_type.project_unique_id', $project_id],
      ['project_unit_type.unit_status', $filterUnit]
    ])
    ->orderBy('project_unit_type.created_at', 'desc')
    ->paginate( 10 );

    $res = [
      'results' => $getunit,
      'project_id' => $project_id
    ];
    return response()->json( $res, 200 );
  }

  public function request_unit( Request $request, ProjectRequest $project_request, ProjectUnitType $unit_type, LogProjectRequest $log_request, $unit_id )
  {
    $message = $request->message;
    $dev_user = $request->dev_user;
    $customer_name = $request->customer_name;
    $customer_id = session()->get('customer_id');
    $insert_request = new $project_request;
    $request_id = $insert_request->increment('request_id') + 1;
    $date = date('Ymd');
    $generate_request_id = 'REQ' . str_pad( $request_id, 5, '0', STR_PAD_LEFT ) . '-' . $date;
    $getunit = $unit_type->select('unit_name')->where('unit_type_id', $unit_id)->first();
    $data_log = [
      'message' => $customer_name . ' mengajukan pemesanan unit ' . $getunit->unit_name,
      'request_id' => $generate_request_id
    ];

    $insert_request->request_unique_id = $generate_request_id;
    $insert_request->dev_user_id = $dev_user;
    $insert_request->customer_id = $customer_id;
    $insert_request->unit_type_id = $unit_id;
    $insert_request->request_message = $message;
    $insert_request->save();
    $log_request->insert_log($data_log);

    $res = [
      'status' => 200,
      'statusText' => 'success'
    ];

    return response()->json( $res, $res['status'] );
  }
}

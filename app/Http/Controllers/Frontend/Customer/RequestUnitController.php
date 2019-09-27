<?php

namespace App\Http\Controllers\Frontend\Customer;

use Illuminate\Http\Request;
use App\Database\Customer;
use App\Database\ProjectRequest;
use App\Http\Controllers\Controller;

class RequestUnitController extends Controller
{
  public function get_request_list( ProjectRequest $project_request, $status_request )
  {
    $session_user = session()->get('customer_id');
    $getrequest = $project_request->select(
      'project_request.request_unique_id',
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_thumbnail',
      'project_unit_type.unit_price',
      'project_unit_type.unit_lb',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_list.project_unique_id',
      'project_list.project_name',
      'project_list.project_address',
      'city.city_name',
      'province.province_name'
    )
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->join('project_list', 'project_unit_type.project_unique_id', '=', 'project_unit_type.project_unique_id')
    ->join('city', 'project_list.project_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->where([
      ['project_request.status_request', '=', $status_request],
      ['project_request.customer_id', '=', $session_user]
    ])
    ->orderBy('project_request.created_at', 'desc')
    ->groupBy('project_request.request_unique_id')
    ->paginate( 10 );

    $res = [
      'results' => $getrequest,
      'status' => 200,
      'statusText' => 'success'
    ];

    return response()->json( $res, 200 );
  }
}

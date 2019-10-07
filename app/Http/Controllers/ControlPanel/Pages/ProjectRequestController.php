<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\AdminOwner;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Http\Controllers\Controller;
use PDF;

class ProjectRequestController extends Controller
{
  public function get_request( Request $request, ProjectRequest $project_request )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getrequest = $project_request->select(
      'project_request.request_unique_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.isReviewed',
      'project_request.created_at',
      'project_request.updated_at',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'developer_user.dev_name',
      'project_unit_type.unit_name'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('developer_user', 'project_request.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->orderBy('project_request.created_at', 'desc');

    if( ! empty( $keywords ) )
    {
      $getrequest = $getrequest->where('project_request.request_unique_id', 'like', '%' . $keywords . '%');
    }

    $result = $getrequest->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, ProjectRequest $project_request )
  {
    $keywords = $request->keywords;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getrequest = $project_request->select(
      'project_request.request_unique_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.isReviewed',
      'project_request.created_at',
      'project_request.updated_at',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'developer_user.dev_name',
      'project_unit_type.unit_name'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('developer_user', 'project_request.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->orderBy('project_request.created_at', 'desc');

    if( ! empty( $keywords ) )
    {
      $getrequest = $getrequest->where('project_request.request_unique_id', 'like', '%' . $keywords . '%');
    }

    $result = $getrequest->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function get_detail_request( ProjectRequest $project_request, LogProjectRequest $log_request, $request_id )
  {
    $getrequest = $project_request->select(
      'project_request.request_unique_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.isReviewed',
      'project_request.created_at',
      'project_request.updated_at',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'developer_user.dev_name',
      'project_unit_type.unit_name'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('developer_user', 'project_request.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->orderBy('project_request.created_at', 'desc')
    ->where('project_request.request_unique_id', '=', $request_id)
    ->first();

    $getlog = $log_request->where('request_unique_id', $request_id)
    ->orderBy('created_at', 'desc')
    ->get();

    $result = [
      'data' => $getrequest,
      'log' => $getlog
    ];

    return response()->json( $result, 200 );
  }
}

<?php

namespace App\Http\Controllers\RestApi;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Database\DeveloperUser;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Http\Controllers\Controller;

class ProjectApi extends Controller
{
  public function overview_project( ProjectList $project_list, ProjectUnitType $project_type, DeveloperUser $developeruser )
  {
    $developer = $developeruser->getinfo();
    $getproject = $project_list->select(
      DB::raw('count(*) as total_project'),
      DB::raw('count(if(project_status="available",1,NULL)) as available'),
      DB::raw('count(if(project_status="soon",1,NULL)) as soon'),
      DB::raw('count(if(project_status="sold",1,NULL)) as sold')
    )
    ->where('dev_user_id', $developer->dev_user_id)
    ->first();

    $getunit = $project_type->select(
      DB::raw('count(*) as total_unit'),
      DB::raw('count(if(project_unit_type.unit_status="available",1,NULL)) as available'),
      DB::raw('count(if(project_unit_type.unit_status="booked",1,NULL)) as booked'),
      DB::raw('count(if(project_unit_type.unit_status="sold",1,NULL)) as sold')
    )
    ->leftJoin('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->where('project_list.dev_user_id', $developer->dev_user_id)
    ->first();

    $res = [
      'status' => 200,
      'statusText' => 'data loaded...',
      'data' => [
        'project' => [
          'total' => $getproject->total_project,
          'available' => $getproject->available,
          'soon' => $getproject->soon,
          'sold' => $getproject->sold
        ],
        'unit' => [
          'total' => $getunit->total_unit,
          'available' => $getunit->available,
          'sold' => $getunit->sold,
          'booked' => $getunit->booked
        ]
      ]
    ];
    return response()->json( $res, $res['status'] );
  }

  public function overview_project_request( ProjectRequest $project_request, DeveloperUser $developeruser )
  {
    $developer = $developeruser->getinfo();

    $getrequest = $project_request->select(
      DB::raw('count(project_request.request_id) as total_request'),
      DB::raw('count(if(status_request="accept",1,NULL)) as accept'),
      DB::raw('count(if(status_request="waiting_response",1,NULL)) as waiting_response'),
      DB::raw('count(if(status_request="cancel",1,NULL)) as cancel'),
      DB::raw('count(if(status_request="reject",1,NULL)) as reject'),
      DB::raw('count(if(status_request="meeting",1,NULL)) as meeting')
    )
    ->where('dev_user_id', $developer->dev_user_id)
    ->first();

    $res = [
      'status' => 200,
      'statusText' => 'data loaded...',
      'data' => [
        'total' => $getrequest->total_request,
        'accept' => $getrequest->accept,
        'waiting_response' => $getrequest->waiting_response,
        'cancel' => $getrequest->cancel,
        'reject' => $getrequest->reject,
        'meeting' => $getrequest->meeting
      ]
    ];
    return response()->json( $res, $res['status'] );
  }

  public function overview_latest_project( ProjectList $project_list, ProjectUnitType $project_unit, DeveloperUser $developeruser )
  {
    $developer = $developeruser->getinfo();
    $getproject = $project_list->select(
      'project_id',
      'project_slug',
      'project_name',
      'project_thumbnail',
      'project_status',
      'created_at',
      'updated_at'
    )
    ->where('dev_user_id', $developer->dev_user_id)
    ->orderBy('created_at', 'desc')
    ->take(5)
    ->get();

    $getunit = $project_unit->select(
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_slug',
      'project_unit_type.unit_thumbnail',
      'project_unit_type.unit_status',
      'project_unit_type.unit_price',
      'project_unit_type.project_id'
    )
    ->join('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->where('project_list.dev_user_id', $developer->dev_user_id)
    ->orderBy('project_unit_type.created_at', 'desc')
    ->take(5)
    ->get();

    $res = [
      'status' => 200,
      'statusText' => 'data loaded...',
      'data' => [
        'latest_project' => $getproject,
        'latest_unit' => $getunit
      ]
    ];

    return response()->json( $res, $res['status'] );
  }

  public function latest_log_request( LogProjectRequest $log_request, DeveloperUser $developeruser )
  {
    $developer = $developeruser->getinfo();

    $latest_log = $log_request->select(
      'log_project_request.request_id',
      'log_project_request.log_message',
      'log_project_request.log_date'
    )
    ->join('project_request', 'log_project_request.request_id', '=', 'project_request.request_id')
    ->where('project_request.dev_user_id', $developer->dev_user_id)
    ->orderBy('log_project_request.log_date', 'desc')
    ->take(10)
    ->get();

    $res = [
      'status' => 200,
      'statusText' => 'data loaded...',
      'data' => $latest_log
    ];

    return response()->json( $res, $res['status'] );
  }
}

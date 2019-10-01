<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Database\ProjectUnitType;
use App\Database\Customer;
use App\Http\Controllers\Controller;

class RequestUnitController extends Controller
{
  public function customer_request_unit( Request $request, DeveloperUser $developeruser, ProjectRequest $project_request )
  {
    if( session()->has('isDeveloper') )
    {
      $has_request = $project_request->hasNewRequest();

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasRequest' => $has_request
      ];
      return response()->view('frontend.pages.developer.request_unit', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function get_request_unit( Request $request, ProjectRequest $project_request, DeveloperUser $developeruser )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $status_request = $request->status_request;
    $devuser = $developeruser->getinfo();

    $query = $project_request->select(
      'project_request.request_unique_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.request_note',
      'project_request.isReviewed',
      'project_request.created_at',
      'project_request.updated_at',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_price',
      'city.city_name',
      'province.province_name',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.customer_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->leftJoin('meeting_appointment', 'project_request.request_unique_id', '=', 'meeting_appointment.request_unique_id');

    if( empty( $keywords ) )
    {
      $result = $query->where([
        ['project_request.dev_user_id', $devuser->dev_user_id],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orderBy('project_request.created_at', 'desc');

      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.dev_user_id', $devuser->dev_user_id],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }
    else
    {
      $result = $query->where([
        ['project_request.dev_user_id', $devuser->dev_user_id],
        ['project_request.request_unique_id', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orWhere([
        ['project_request.dev_user_id', $devuser->dev_user_id],
        ['customer.customer_name', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orWhere([
        ['project_request.dev_user_id', $devuser->dev_user_id],
        ['customer.customer_phone_number', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orderBy('project_request.created_at', 'desc');

      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.dev_user_id', $devuser->dev_user_id],
          ['customer.customer_name', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orWhere([
          ['project_request.dev_user_id', $devuser->dev_user_id],
          ['customer.customer_email', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }

    $getresult = $result->paginate( $limit );

    $res = [
      'results' => $getresult
    ];
    return response()->json( $res, 200 );
  }

  public function detail_request( ProjectRequest $project_request, LogProjectRequest $log_request, $request_id )
  {
    $getrequest = $project_request->select(
      'project_request.request_unique_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.request_note',
      'project_request.created_at',
      'project_request.updated_at',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'city.city_name',
      'province.province_name',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'meeting_appointment.meeting_result',
      'meeting_appointment.document_file',
      'meeting_appointment.last_updated_by',
      'meeting_appointment.created_at',
      'meeting_appointment.updated_at'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.customer_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->leftJoin('meeting_appointment', 'project_request.request_unique_id', '=', 'meeting_appointment.request_unique_id')
    ->where('project_request.request_unique_id', '=', $request_id)
    ->first();

    $getlog = $log_request->where('request_unique_id', '=', $request_id)
    ->orderBy('created_at', 'desc')
    ->get();

    $res = [
      'results' => [
        'log' => $getlog,
        'data' => $getrequest
      ]
    ];

    return response()->json( $res, 200 );
  }

  public function review_request_unit( ProjectRequest $project_request, LogProjectRequest $log_request, ProjectUnitType $unit_type, $request_id, $status_review )
  {
    $getrequest = $project_request->where('request_unique_id', $request_id)
    ->first();

    if( $getrequest->isReviewed === 'N' )
    {
      $getunit = $unit_type->where('unit_type_id', '=', $getrequest->unit_type_id)->first();
      $getunit->unit_status = $status_review === 'reject' ? 'available' : 'sold';

      $getunit->save();

      $getrequest->status_request = $status_review;
      $getrequest->isReviewed = 'Y';
      $getrequest->save();

      $log_request->insert_log([
        'request_id' => $request_id,
        'message' => 'Developer telah me-review pengajuan pemesanan unit.'
      ]);
    }

    $res = [
      'status' => 200,
      'statusText' => 'success',
      'status_review' => $status_review
    ];

    return response()->json( $res, 200 );
  }
}

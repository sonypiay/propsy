<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Database\Customer;
use App\Http\Controllers\Controller;

class RequestUnitController extends Controller
{
  public function customer_request_unit( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];
      return response()->view('frontend.pages.marketing.request_unit', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function get_request_unit( Request $request, ProjectRequest $project_request, MarketingUser $marketinguser )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $status_request = $request->status_request;
    $mktuser = $marketinguser->getinfo();

    $query = $project_request->select(
      'project_request.request_id',
      'project_request.request_message',
      'project_request.status_request',
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
      'city.city_id',
      'city.city_name',
      'province.province_name',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'price_installment.dp_price',
      'price_installment.installment_price',
      'price_installment.installment_tenor'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->join('price_installment', 'project_request.installment', '=', 'price_installment.id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->leftJoin('meeting_appointment', 'project_request.request_id', '=', 'meeting_appointment.request_id');

    if( empty( $keywords ) )
    {
      $result = $query->where([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orderBy('project_request.created_at', 'desc');

      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }
    else
    {
      $result = $query->where([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['project_request.request_id', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orWhere([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['customer.customer_name', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orWhere([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['customer.customer_phone_number', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orderBy('project_request.created_at', 'desc');
      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['customer.customer_name', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orWhere([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
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
      'project_request.request_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.created_at',
      'project_request.updated_at',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'meeting_appointment.meeting_result',
      'meeting_appointment.document_file',
      'meeting_appointment.created_by',
      'meeting_appointment.updated_by',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'city.city_name',
      'province.province_name',
      'price_installment.dp_price',
      'price_installment.installment_price',
      'price_installment.installment_tenor'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->join('price_installment', 'project_request.installment', '=', 'price_installment.id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->leftJoin('meeting_appointment', 'project_request.request_id', '=', 'meeting_appointment.request_id')
    ->where('project_request.request_id', '=', $request_id)
    ->first();

    $getlog = $log_request->where('request_id', '=', $request_id)
    ->orderBy('log_date', 'desc')
    ->get();

    $res = [
      'results' => [
        'log' => $getlog,
        'data' => $getrequest
      ]
    ];

    return response()->json( $res, 200 );
  }
}

<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Database\Customer;
use App\Database\AreaDB;
use App\Http\Controllers\Controller;

class RequestUnitController extends Controller
{
  public function customer_request_unit( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $has_request = $project_request->hasNewRequest( $getmarketing->dev_user_id );

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasRequest' => $has_request
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
    $offset = $request->offset;
    $mktuser = $marketinguser->getinfo();

    $query = $project_request->select(
      'project_request.created_at',
      'project_request.updated_at',
      'project_request.request_note',
      'project_request.status_request',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'customer.customer_city',
      'customer.customer_region',
      'customer.customer_address',
      'project_unit.project_unit_id',
      'project_unit.project_unit_name',
      'project_unit.project_unit_number'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('project_unit_type', 'project_request.project_unit_type_id', '=', 'project_unit_type.project_unit_type_id')
    ->join('project_unit', 'project_unit_type.project_unit_id', '=', 'project_unit.project_unit_id');

    if( empty( $keywords ) )
    {
      $result = $query->where('project_request.mkt_user_id', $mktuser->mkt_user_id);
      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.mkt_user_id', $mktuser->mkt_user_id],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }
    else
    {
      $result = $query->where([
        ['project_request.mkt_user_id', $mktuser->mkt_user_id],
        ['customer.customer_name', 'like', '%' . $keywords . '%']
      ])
      ->orWhere([
        ['project_request.mkt_user_id', $mktuser->mkt_user_id],
        ['customer.customer_email', 'like', '%' . $keywords . '%']
      ])
      ->orderBy('project_request.created_at', 'desc');
      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.mkt_user_id', $mktuser->mkt_user_id],
          ['customer.customer_name', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orWhere([
          ['project_request.mkt_user_id', $mktuser->mkt_user_id],
          ['customer.customer_email', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }

    $result = $result->offset( $offset )
    ->limit( $limit )
    ->get();
    $res = [
      'data' => [
        'total' => $result->count(),
        'result' => $result
      ]
    ];
    return response()->json( $res, 200 );
  }

  public function get_detail_request( ProjectRequest $project_request, MarketingUser $marketinguser, AreaDB $area, $reqid )
  {
    $mktuser = $marketinguser->getinfo();

    $getrequest = $project_request->select(
      'project_request.created_at',
      'project_request.updated_at',
      'project_request.request_note',
      'project_request.status_request',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'customer.customer_city',
      'customer.customer_region',
      'customer.customer_address',
      'project_unit_type.project_unit_type_id',
      'project_unit_type.unit_floor',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_unit_type.unit_lt',
      'project_unit_type.unit_lb',
      'project_unit.project_unit_id',
      'project_unit.project_unit_name',
      'project_unit.project_unit_number',
      'project_unit.project_unit_status',
      'project_list.project_name',
      'project_list.project_address',
      'project_list.project_city',
      'project_list.project_region',
      'project_list.project_gmaps'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('project_unit_type', 'project_request.project_unit_type_id', '=', 'project_unit_type.project_unit_type_id')
    ->join('project_unit', 'project_unit_type.project_unit_id', '=', 'project_unit.project_unit_id')
    ->join('project_list', 'project_unit.project_id', '=', 'project_list.project_id')
    ->where([
      ['project_request.mkt_user_id', $mktuser->mkt_user_id],
      ['project_request.request_id', $reqid]
    ])
    ->first();

    $project_region = $area->where('area_id', $getrequest->project_region)->first();
    $project_city = $area->where('area_id', $getrequest->project_city)->first();
    $customer_region = $area->where('area_id', $getrequest->customer_region)->first();
    $customer_city = $area->where('area_id', $getrequest->customer_city)->first();

    $res = [
      'status' => 200,
      'statusText' => 'data loaded success...',
      'results' => [
        'data' => [
          'request' => $getrequest,
          'project_region' => $project_region,
          'project_city' => $project_city,
          'customer_region' => $customer_region,
          'customer_city' => $customer_city
        ]
      ]
    ];

    return response()->json( $res, $res['status'] );
  }
}

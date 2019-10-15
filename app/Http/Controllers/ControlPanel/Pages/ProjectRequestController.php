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
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];
      return response()->view('controlpanel.pages.customer.requesthistory', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_request( Request $request, ProjectRequest $project_request )
  {
    $keywords = $request->keywords;
    $status = $request->status;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getrequest = $project_request->select(
      'project_request.request_id',
      'project_request.status_request',
      'project_request.isReviewed',
      'project_request.created_at',
      'customer.customer_name',
      'project_unit_type.unit_name'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->orderBy('project_request.created_at', 'desc');

    if( $status !== 'all' )
    {
      $getrequest = $getrequest->where('project_request.status_request', $status);
    }

    if( ! empty( $keywords ) )
    {
      $getrequest = $getrequest->where('project_request.request_id', 'like', '%' . $keywords . '%');
    }

    $result = $getrequest->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, ProjectRequest $project_request )
  {
    $keywords = $request->keywords;
    $status = $request->status;

    $getrequest = $project_request->select(
      'project_request.request_id',
      'project_request.status_request',
      'project_request.isReviewed',
      'project_request.created_at',
      'customer.customer_name',
      'project_unit_type.unit_name'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->orderBy('project_request.created_at', 'desc');

    if( $status !== 'all' )
    {
      $getrequest = $getrequest->where('project_request.status_request', $status);
    }

    if( ! empty( $keywords ) )
    {
      $getrequest = $getrequest->where('project_request.request_id', 'like', '%' . $keywords . '%');
    }

    $filename = 'DataRiwayatPesanan-' . date('dmY') . '.pdf';
    $res = [
      'filename' => $filename,
      'result' => $getrequest->get()
    ];
    return PDF::loadView('controlpanel.pages.reports.request_unit', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }

  public function get_detail_request( ProjectRequest $project_request, LogProjectRequest $log_request, $request_id )
  {
    $getrequest = $project_request->select(
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
      'meeting_appointment.document_file',
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

    $getlog = $log_request->where('request_id', $request_id)
    ->orderBy('log_date', 'desc')
    ->get();

    $result = [
      'results' => [
        'data' => $getrequest,
        'log' => $getlog
      ]
    ];

    return response()->json( $result, 200 );
  }
}

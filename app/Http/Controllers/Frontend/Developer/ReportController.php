<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\ProjectRequest;
use App\Database\ProjectUnitType;
use App\Database\LogProjectRequest;
use App\Http\Controllers\Controller;
use DB;
use PDF;

class ReportController extends Controller
{
  public function page_report_unit( Request $request, DeveloperUser $developeruser, $status )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasrequest' => $developeruser->hasrequest()
      ];

      if( $status === 'sold' )
      {
        return response()->view('frontend.pages.developer.report.unitsold', $data);
      }
      else if( $status === 'booked' )
      {
        return response()->view('frontend.pages.developer.report.unitbooked', $data);
      }
      else
      {
        abort(404);
      }
    }
    else
    {
      return redirect()->route('developer_login_page');
    }
  }

  public function get_unit_report( Request $request, DeveloperUser $developeruser, ProjectRequest $project_request, $status )
  {
    $start_date = $request->start_date;
    $end_date = $request->end_date;
    $developer = $developeruser->getinfo();
    $arr_date = [
      'start_date' => $start_date,
      'end_date' => $end_date
    ];

    $whereClauses = [];
    array_push( $whereClauses, ['project_unit_type.unit_status', $status]);
    array_push( $whereClauses, ['project_request.dev_user_id', $developer->dev_user_id]);

    $getrequest = $project_request->select(
      'project_request.request_id',
      'project_request.created_at',
      'project_request.updated_at',
      'project_unit_type.unit_name',
      'project_unit_type.unit_status',
      'customer.customer_name'
    )
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->where($whereClauses);

    if( ! empty( $start_date ) && ! empty( $end_date ) )
    {
      $getrequest = $getrequest->where(function($query) use ($arr_date){
        $query->whereBetween(DB::raw('date_format(project_request.created_at, "%Y-%m-%d")'), [$arr_date['start_date'], $arr_date['end_date']]);
      });
    }

    $result = $getrequest->orderBy('project_request.created_at', 'desc')
    ->paginate( 10 );

    return response()->json( $result, 200 );
  }

  public function report_save_unit( Request $request, ProjectRequest $project_request, DeveloperUser $developeruser, $status )
  {
    $start_date = $request->start_date;
    $end_date = $request->end_date;
    $developer = $developeruser->getinfo();
    $arr_date = [
      'start_date' => $start_date,
      'end_date' => $end_date
    ];

    $whereClauses = [];
    array_push( $whereClauses, ['project_unit_type.unit_status', '=', $status]);
    array_push( $whereClauses, ['project_request.dev_user_id', '=', $developer->dev_user_id]);

    $getrequest = $project_request->select(
      'project_request.request_id',
      'project_request.created_at',
      'project_request.updated_at',
      'project_unit_type.unit_name',
      'customer.customer_name'
    )
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->where($whereClauses);

    if( ! empty( $start_date ) && ! empty( $end_date ) )
    {
      $getrequest = $getrequest->where(function($query) use ($arr_date){
        $query->whereBetween(DB::raw('date_format(project_request.created_at, "%Y-%m-%d")'), [$arr_date['start_date'], $arr_date['end_date']]);
      });
    }

    $result = $getrequest->orderBy('project_request.created_at', 'desc')->get();
    $filename = 'Unit' . $status . '-' . date('Ymd') . '.pdf';

    $data = [
      'result' => $result,
      'filename' => $filename,
      'start_date' => $start_date,
      'end_date' => $end_date,
      'status' => $status
    ];

    return PDF::loadView('frontend.pages.export.unit', $data)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }

  public function report_save_project_request( ProjectRequest $project_request, LogProjectRequest $log_request, $request_id )
  {
    $getrequest = $project_request->select(
      'project_request.request_id',
      'project_request.request_message',
      'project_request.status_request',
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
      'meeting_appointment.created_by',
      'meeting_appointment.updated_by'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->leftJoin('meeting_appointment', 'project_request.request_id', '=', 'meeting_appointment.request_id')
    ->where('project_request.request_id', $request_id)
    ->first();

    $filename = 'RequestUnit-' . $request_id . '.pdf';

    $res = [
      'filename' => $filename,
      'result' => $getrequest
    ];

    return PDF::loadView('frontend.pages.export.request_unit', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }
}

<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\ProjectRequest;
use App\Database\ProjectUnitType;
use App\Http\Controllers\Controller;
use DB;

class ReportController extends Controller
{
  public function page_report_unit( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo()
      ];

      return response()->view('frontend.pages.developer.report.unit', $data);
    }
    else
    {
      return redirect()->route('developer_login_page');
    }
  }

  public function get_unit_sold( Request $request, DeveloperUser $developeruser, ProjectRequest $project_request )
  {
    $start_date = $request->start_date;
    $end_date = $request->end_date;
    $developer = $developeruser->getinfo();

    $whereClauses = [];
    array_push( $whereClauses, ['project_unit_type.unit_status', '=', 'sold']);
    array_push( $whereClauses, ['project_request.dev_user_id', '=', $developer->dev_user_id]);

    $getrequest = $project_request->select(
      'project_request.request_unique_id',
      'project_request.created_at',
      'project_request.updated_at',
      'project_unit_type.unit_name',
      'project_unit_type.unit_status',
      'customer.customer_name'
    )
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->where($whereClauses);

    if( ! empty( $start_date ) && empty( $end_date ) )
    {
      $getrequest = $getrequest->where(DB::raw('date_format(project_request.created_at, "%Y-%m-%d")'), '=', $start_date);
    }
    else
    {
      $getrequest = $getrequest->whereBetween(DB::raw('date_format(project_request.created_at, "%Y-%m-%d")'), [$start_date, $end_date]);
    }

    $result = $getrequest->orderBy('project_request.created_at', 'desc')
    ->paginate( 10 );

    return response()->json( $result, 200 );
  }
}

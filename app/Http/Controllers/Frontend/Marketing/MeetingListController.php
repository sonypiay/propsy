<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use App\Database\MeetingAppointment;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Http\Controllers\Controller;

class MeetingListController extends Controller
{
  public function create_schedule_page( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request, $request_id = null )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $has_request = $project_request->hasNewRequest( $getmarketing->dev_user_id );

      $getrequest = null;
      if( $request_id !== null || ! empty( $request_id ) )
      {
        $getrequest = $project_request->select(
          'project_request.request_unique_id',
          'customer.customer_name',
          'customer.customer_phone_number',
          'project_unit_type.unit_name'
        )
        ->where('project_request.request_unique_id', $request_id)
        ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
        ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
        ->first();
      }

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasRequest' => $has_request,
        'getrequest' => $getrequest
      ];
      return response()->view('frontend.pages.marketing.create_schedule', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }
}

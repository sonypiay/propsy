<?php

namespace App\Http\Controllers\Frontend\Customer;

use Illuminate\Http\Request;
use App\Database\Customer;
use App\Database\MeetingAppointment;
use App\Http\Controllers\Controller;

class MeetingInvitationController extends Controller
{
  public function index( Request $request, Customer $customer, MeetingAppointment $meeting_appointment )
  {
    if( session()->has('isCustomer') )
    {
      $data = [
        'request' => $request,
        'session_user' => $customer->getinfo(),
        'hasrequest' => $customer->hasrequest()
      ];
      return response()->view('frontend.pages.customer.meeting_invitation', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function get_meeting_invitation( Request $request, Customer $customer, MeetingAppointment $meeting_appointment )
  {
    $status_meeting = $request->status_meeting;
    $getcustomer = $customer->getinfo();

    $getmeeting = $meeting_appointment->select(
      'meeting_appointment.meeting_id',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'meeting_appointment.created_by',
      'meeting_appointment.created_at',
      'project_request.request_id',
      'project_unit_type.unit_name'
    )
    ->join('project_request', 'meeting_appointment.request_id', '=', 'project_request.request_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->orderBy('meeting_appointment.created_at', 'desc')
    ->where('project_request.customer_id', $getcustomer->customer_id);

    if( $status_meeting !== 'all' )
    {
      $getmeeting = $getmeeting->where('meeting_appointment.meeting_status', $status_meeting);
    }

    $result = $getmeeting->paginate( 10 );
    $data = [
      'results' => $result
    ];
    return response()->json( $data, 200 );
  }
}

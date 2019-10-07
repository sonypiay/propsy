<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\MeetingAppointment;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;

class MeetingListController extends Controller
{
  public function get_meeting_list( Request $request, MeetingAppointment $meeting )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;

    $getmeeting = $meeting->select(
      'meeting_appointment.meeting_id',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'meeting_appointment.meeting_result',
      'meeting_appointment.document_file',
      'meeting_appointment.created_at',
      'meeting_appointment.updated_at',
      'project_request.request_unique_id',
      'customer.customer_name',
      'developer_user.dev_name'
    )
    ->join('project_request', 'meeting_appointment.request_unique_id', '=', 'project_request.request_unique_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('developer_user', 'project_request.dev_user_id', '=', 'developer_user.dev_user_id')
    ->orderBy('meeting_appointment.created_at', 'desc');
    if( ! empty( $keywords ) )
    {
      //$getmeeting = $getmeeting->where('meeting_appointment.request_unique_id', 'like', '%' . );
    }
  }
}

<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\MeetingAppointment;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;
use PDF;

class MeetingListController extends Controller
{
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];
      return response()->view('controlpanel.pages.developer.meeting_list', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_meeting_list( Request $request, MeetingAppointment $meeting )
  {
    $status = $request->status;
    $keywords = $request->keywords;
    $limit = $request->limit;

    $getmeeting = $meeting->select(
      'meeting_appointment.meeting_id',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'meeting_appointment.meeting_result',
      'meeting_appointment.document_file',
      'meeting_appointment.created_by',
      'meeting_appointment.updated_by',
      'meeting_appointment.created_at',
      'meeting_appointment.updated_at',
      'project_request.request_id',
      'customer.customer_name',
      'developer_user.dev_name'
    )
    ->join('project_request', 'meeting_appointment.request_id', '=', 'project_request.request_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('developer_user', 'project_request.dev_user_id', '=', 'developer_user.dev_user_id')
    ->orderBy('meeting_appointment.created_at', 'desc');

    if( $status !== 'all' )
    {
      $getmeeting = $getmeeting->where('meeting_appointment.meeting_status', $status);
    }

    if( ! empty( $keywords ) )
    {
      $getmeeting = $getmeeting->where(function($query) use ($keywords) {
        $query->where('meeting_appointment.meeting_id', 'like', '%' . $keywords . '%')
        ->orWhere('project_request.request_id', 'like', '%' . $keywords . '%');
      });
    }

    $result = $getmeeting->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, MeetingAppointment $meeting )
  {
    $status = $request->status;

    $getmeeting = $meeting->select(
      'meeting_appointment.meeting_id',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.meeting_note',
      'meeting_appointment.meeting_result',
      'meeting_appointment.document_file',
      'meeting_appointment.created_by',
      'meeting_appointment.updated_by',
      'meeting_appointment.created_at',
      'meeting_appointment.updated_at',
      'project_request.request_id',
      'customer.customer_name',
      'developer_user.dev_name'
    )
    ->join('project_request', 'meeting_appointment.request_id', '=', 'project_request.request_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('developer_user', 'project_request.dev_user_id', '=', 'developer_user.dev_user_id')
    ->orderBy('meeting_appointment.created_at', 'desc');

    if( $status !== 'all' )
    {
      $getmeeting = $getmeeting->where('meeting_appointment.meeting_status', $status);
    }

    $filename = 'MarketingUser-' . date('dmY') . '.pdf';
    $res = [
      'filename' => $filename,
      'result' => $getmeeting->get()
    ];
    return PDF::loadView('controlpanel.pages.reports.meeting_list', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }
}

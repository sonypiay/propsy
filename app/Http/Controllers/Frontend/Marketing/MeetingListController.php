<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use App\Database\MeetingAppointment;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Http\Controllers\Controller;
use DB;

class MeetingListController extends Controller
{
  public function index( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request )
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

      return response()->view('frontend.pages.marketing.meeting_list', $data);
    }
  }

  public function create_schedule_page( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request, $request_id = null )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $has_request = $project_request->hasNewRequest( $getmarketing->dev_user_id );

      $getrequest = [
        'request_unique_id' => '',
        'unit_name' => 'Properti Anda'
      ];

      if( $request_id !== null || ! empty( $request_id ) )
      {
        $getrequest = $project_request->select(
          'project_request.request_unique_id',
          'project_unit_type.unit_name'
        )
        ->where('project_request.request_unique_id', $request_id)
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

  public function create_schedule( Request $request, MarketingUser $marketinguser, MeetingAppointment $meeting_appointment, LogProjectRequest $log_request, ProjectRequest $project_request, $request_id )
  {
    $tanggal_meeting = $request->tanggal_meeting;
    $jam_meeting = $request->jam_meeting;
    $note = $request->note;
    $meeting_time = $tanggal_meeting . ' ' . $jam_meeting;
    $mktuser = $marketinguser->getinfo();
    $getrequest = $project_request->where('request_unique_id', $request_id)->first();
    $check_meeting = $meeting_appointment->where('request_unique_id', $request_id)->count();

    if( $check_meeting === 1 )
    {
      $res = [
        'status' => 409,
        'statusText' => 'ID ' . $request_id . ' sudah dijadwalkan meeting.'
      ];
    }
    else
    {
      $message_log = '';
      $data_log = [
        'request_id' => $request_id,
        'message' => $mktuser->mkt_fullname . ' mengundang Anda untuk meeting.'
      ];

      $insert = new $meeting_appointment;
      $insert->request_unique_id = $request_id;
      $insert->meeting_time = $meeting_time;
      $insert->meeting_note = $note;
      $insert->last_updated_by = $mktuser->mkt_fullname;
      $insert->save();

      $getrequest->status_request = 'meeting';
      $getrequest->save();

      $log_request->insert_log( $data_log );
      $res = [ 'status' => 200, 'statusText' => 'success' ];
    }

    return response()->json( $res, $res['status'] );
  }

  public function edit_schedule_page( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request, MeetingAppointment $meeting_appointment, $request_id )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $has_request = $project_request->hasNewRequest( $getmarketing->dev_user_id );

      $getmeeting = $meeting_appointment->where('request_unique_id', $request_id)
      ->first();
      if( ! $getmeeting ) abort(404);

      $getrequest = $project_request->select(
        'project_request.request_unique_id',
        'project_unit_type.unit_name'
      )
      ->where('project_request.request_unique_id', $request_id)
      ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
      ->first();

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasRequest' => $has_request,
        'getrequest' => $getrequest,
        'getmeeting' => $getmeeting
      ];
      return response()->view('frontend.pages.marketing.edit_schedule', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function update_schedule( Request $request, MarketingUser $marketinguser, MeetingAppointment $meeting_appointment, LogProjectRequest $log_request, $request_id )
  {
    $tanggal_meeting = $request->tanggal_meeting;
    $jam_meeting = $request->jam_meeting;
    $note = $request->note;
    $meeting_time = $tanggal_meeting . ' ' . $jam_meeting;
    $mktuser = $marketinguser->getinfo();
    $status_meeting = $request->status_meeting;

    $message_log = '';
    $data_log = [
      'request_id' => $request_id,
      'message' => $mktuser->mkt_fullname . ' me-revisi jadwal meeting dengan Anda.'
    ];

    $update = $meeting_appointment->where('request_unique_id', $request_id)->first();
    $update->meeting_time = $meeting_time;
    $update->meeting_note = $note;
    $update->meeting_status = $status_meeting;
    $update->last_updated_by = $mktuser->mkt_fullname;
    $update->save();

    $log_request->insert_log( $data_log );
    $res = [ 'status' => 200, 'statusText' => 'success' ];

    return response()->json( $res, $res['status'] );
  }

  public function get_meeting_list( Request $request, MarketingUser $marketinguser, MeetingAppointment $meeting_appointment )
  {
    $filterdate = $request->filterdate;
    $status_meeting = $request->status_meeting;
    $keywords = $request->keywords;
    $limit = $request->limitrow;
    $mktuser = $marketinguser->getinfo();

    $getmeeting = $meeting_appointment->select(
      'meeting_appointment.meeting_id',
      'meeting_appointment.meeting_time',
      'meeting_appointment.meeting_status',
      'meeting_appointment.request_unique_id',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_phone_number'
    )
    ->join('project_request', 'meeting_appointment.request_unique_id', '=', 'project_request.request_unique_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id');

    if( empty( $keywords ) )
    {
      if( empty( $filterdate ) AND $status_meeting === 'all' )
      {
        $query = $getmeeting->where('project_request.dev_user_id', $mktuser->dev_user_id);
      }
      else if( ! empty( $filterdate ) AND $status_meeting === 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          [DB::raw('date_format(meeting_appointment.meeting_time, "%Y-%m-%d")'), '=', $filterdate]
        ]);
      }
      else if( empty( $filterdate ) AND $status_meeting !== 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.meeting_status', '=', $status_meeting]
        ]);
      }
      else
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.meeting_status', '=', $status_meeting],
          [DB::raw('date_format(meeting_appointment.meeting_time, "%Y-%m-%d")'), '=', $filterdate]
        ]);
      }
    }
    else
    {
      if( empty( $filterdate ) AND $status_meeting === 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.request_unique_id', 'like', '%' . $keywords . '%']
        ]);
      }
      else if( ! empty( $filterdate ) AND $status_meeting === 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.request_unique_id', 'like', '%' . $keywords . '%'],
          [DB::raw('date_format(meeting_appointment.meeting_time, "%Y-%m-%d")'), '=', $filterdate]
        ]);
      }
      else if( empty( $filterdate ) AND $status_meeting !== 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.meeting_status', '=', $status_meeting],
          ['meeting_appointment.request_unique_id', 'like', '%' . $keywords . '%']
        ]);
      }
      else
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.meeting_status', '=', $status_meeting],
          ['meeting_appointment.request_unique_id', 'like', '%' . $keywords . '%'],
          [DB::raw('date_format(meeting_appointment.meeting_time, "%Y-%m-%d")'), '=', $filterdate]
        ]);
      }
    }

    $result = $query->orderBy('meeting_appointment.created_at', 'desc')
    ->paginate( $limit );

    $res = [
      'status' => 200,
      'statusText' => 'data loaded...',
      'results' => $result
    ];

    return response()->json( $res, 200 );
  }
}

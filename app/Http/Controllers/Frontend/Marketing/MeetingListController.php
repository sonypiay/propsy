<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use App\Database\MeetingAppointment;
use App\Database\MarketingUser;
use App\Database\Customer;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Http\Controllers\Controller;
use DB;
use Storage;

class MeetingListController extends Controller
{
  public function index( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasrequest' => $marketinguser->hasrequest()
      ];

      return response()->view('frontend.pages.marketing.meeting_list', $data);
    }
  }

  public function create_schedule_page( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request, $request_id = null )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $getrequest = [
        'request_id' => '',
        'unit_name' => 'Properti Anda'
      ];

      if( $request_id !== null || ! empty( $request_id ) )
      {
        $getrequest = $project_request->select(
          'project_request.request_id',
          'project_unit_type.unit_name'
        )
        ->where('project_request.request_id', $request_id)
        ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
        ->first();
      }

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasrequest' => $marketinguser->hasrequest(),
        'getrequest' => $getrequest
      ];
      return response()->view('frontend.pages.marketing.create_schedule', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function create_schedule( Request $request, MarketingUser $marketinguser, MeetingAppointment $meeting_appointment, LogProjectRequest $log_request, ProjectRequest $project_request, Customer $customer, $request_id )
  {
    $tanggal_meeting = $request->tanggal_meeting;
    $jam_meeting = $request->jam_meeting;
    $note = $request->note;
    $meeting_time = $tanggal_meeting . ' ' . $jam_meeting;
    $mktuser = $marketinguser->getinfo();
    $getrequest = $project_request->where('request_id', $request_id)->first();
    $getcustomer = $customer->where('customer_id', $getrequest->customer_id)->first();
    $check_meeting = $meeting_appointment->where('request_id', $request_id)->count();

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
        'message' => $mktuser->mkt_fullname . ' mengundang ' . $getcustomer->customer_name . ' untuk meeting & survey lokasi bersama.'
      ];

      $insert = new $meeting_appointment;
      $insert->meeting_id = $meeting_appointment->generateId();
      $insert->request_id = $request_id;
      $insert->meeting_time = $meeting_time;
      $insert->meeting_note = $note;
      $insert->created_by = $mktuser->mkt_fullname;
      $insert->updated_by = $mktuser->mkt_fullname;
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
      $getmeeting = $meeting_appointment->where('request_id', $request_id)
      ->first();
      if( ! $getmeeting ) abort(404);

      $getrequest = $project_request->select(
        'project_request.request_id',
        'project_unit_type.unit_name'
      )
      ->where('project_request.request_id', $request_id)
      ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
      ->first();

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasrequest' => $marketinguser->hasrequest(),
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

  public function update_schedule( Request $request, MarketingUser $marketinguser, MeetingAppointment $meeting_appointment, LogProjectRequest $log_request, ProjectRequest $project_request, Customer $customer, $request_id )
  {
    $mktuser = $marketinguser->getinfo();
    $status_meeting = $request->status_meeting;
    $getrequest = $project_request->select('customer_id', 'request_id')->where('request_id', $request_id)->first();
    $getcustomer = $customer->where('customer_id', $getrequest->customer_id)->first();
    $update = $meeting_appointment->where('request_id', $request_id)->first();

    if( $status_meeting === 'revision' )
    {
      $tanggal_meeting = $request->tanggal_meeting;
      $jam_meeting = $request->jam_meeting;
      $note = $request->note;
      $meeting_time = $tanggal_meeting . ' ' . $jam_meeting;
      $data_log = [
        'request_id' => $request_id,
        'message' => $mktuser->mkt_fullname . ' me-revisi jadwal meeting.'
      ];

      $update->meeting_time = $meeting_time;
      $update->meeting_note = $note;
      $update->meeting_status = $status_meeting;
    }
    else
    {
      $storage = Storage::disk('assets');
      $meeting_result = $request->meeting_result;
      $document_file = $request->document_file;
      $document_path = 'document/meeting';
      $filename = empty( $document_file ) ? '' : 'result_' . $document_file->hashName();
      $data_log = [];
      if( $update->meeting_status != 'done' )
      {
        $data_log = [
          'request_id' => $request_id,
          'message' => 'Meeting telah selesai dilakukan. Dokumen telah diupload.'
        ];
      }

      $update->meeting_result = $meeting_result;
      $update->meeting_status = 'done';

      if( empty( $update->document_file ) && ! empty( $document_file ) )
      {
        $storage->putFileAs( $document_path, $document_file, $filename );
        $update->document_file = $filename;
      }
      else
      {
        if( ! empty( $document_file ) )
        {
          if( $storage->exists( $document_path . '/' . $update->document_file ) )
          {
            $storage->delete( $document_path . '/' . $update->document_file );
          }
          $storage->putFileAs( $document_path, $document_file, $filename );
          $update->document_file = $filename;
        }
      }
    }

    $update->updated_by = $mktuser->mkt_fullname;
    $update->save();

    if( count( $data_log ) != 0 ) $log_request->insert_log( $data_log );

    $res = [ 'status' => 200, 'statusText' => 'success', 'request' => $request->all() ];

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
      'meeting_appointment.request_id',
      'meeting_appointment.updated_at',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_phone_number'
    )
    ->join('project_request', 'meeting_appointment.request_id', '=', 'project_request.request_id')
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
          ['meeting_appointment.request_id', 'like', '%' . $keywords . '%']
        ]);
      }
      else if( ! empty( $filterdate ) AND $status_meeting === 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.request_id', 'like', '%' . $keywords . '%'],
          [DB::raw('date_format(meeting_appointment.meeting_time, "%Y-%m-%d")'), '=', $filterdate]
        ]);
      }
      else if( empty( $filterdate ) AND $status_meeting !== 'all' )
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.meeting_status', '=', $status_meeting],
          ['meeting_appointment.request_id', 'like', '%' . $keywords . '%']
        ]);
      }
      else
      {
        $query = $getmeeting->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['meeting_appointment.meeting_status', '=', $status_meeting],
          ['meeting_appointment.request_id', 'like', '%' . $keywords . '%'],
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

  public function get_detail_schedule( Request $request, MeetingAppointment $meeting_appointment, LogProjectRequest $log_request, $request_id )
  {
    $getresult = $meeting_appointment->select(
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
      'project_request.request_message',
      'project_request.status_request',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'city.city_name',
      'province.province_name'
    )
    ->join('project_request', 'meeting_appointment.request_id', '=', 'project_request.request_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id')
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->where('project_request.request_id', '=', $request_id)
    ->first();

    $getlog = $log_request->where('request_id', '=', $request_id)
    ->orderBy('log_date', 'desc')
    ->get();

    $result = [
      'results' => [
        'log' => $getlog,
        'data' => $getresult
      ]
    ];

    return response()->json( $result, 200 );
  }

  public function cancel_request( MeetingAppointment $meeting_appointment, MarketingUser $marketinguser, LogProjectRequest $log_request, $request_id )
  {
    $getmeeting = $meeting_appointment->where('request_id', $request_id)->first();
    $mktuser = $marketinguser->getinfo();

    if( $getmeeting->meeting_status !== 'cancel' )
    {
      $getmeeting->meeting_status = 'cancel';
      $getmeeting->save();

      $log_request->insert_log([
        'request_id' => $request_id,
        'message' => $mktuser->mkt_fullname . ' telah membatalkan jadwal meeting.'
      ]);
    }

    $res = [
      'status' => 200,
      'statusText' => 'success'
    ];
    return response()->json( $res, 200 );
  }
}

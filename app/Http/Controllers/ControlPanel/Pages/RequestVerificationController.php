<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\VerificationDeveloper;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;
use PDF;

class RequestVerificationController extends Controller
{
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];
      return response()->view('controlpanel.pages.developer.request_verification', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_request_verification( Request $request, VerificationDeveloper $verification )
  {
    $keywords = $request->keywords;
    $status = $request->status;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getrequest = $verification->select(
      'verification_developer.hash_id',
      'verification_developer.npwp_image',
      'verification_developer.official_certificate',
      'verification_developer.additional_document',
      'verification_developer.status_verification',
      'verification_developer.created_at',
      'verification_developer.updated_at',
      'developer_user.dev_name',
      'developer_user.dev_email'
    )
    ->join('developer_user', 'verification_developer.dev_user_id', '=', 'developer_user.dev_user_id')
    ->orderBy('verification_developer.created_at', 'desc');

    if( $status !== 'all' )
    {
      $getrequest = $getrequest->where('verification_developer.status_verification', $status);
    }
    if( ! empty( $keywords ) )
    {
      $getrequest = $getrequest->where(function($query) use ($keywords) {
        $query->where('developer_user.dev_name', 'like', '%' . $keywords . '%')
        ->orWhere('developer_user.dev_email', 'like', '%' . $keywords . '%');
      });
    }

    $result = $getrequest->paginate( $limit );
    return response()->json( $result, 200 );
  }

  public function approval_request( DeveloperUser $developer, VerificationDeveloper $verification, $id, $approval )
  {
    $getverification = $verification->where('hash_id', $id)->first();
    $getdeveloper = $developer->where('dev_user_id', $getverification->dev_user_id)->first();

    if( $approval === 'accept' )
    {
      $getverification->status_verification = 'Y';
      $getverification->save();

      $getdeveloper->status_verification = 'Y';
      $getdeveloper->save();

      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }
    else if( $approval === 'reject' )
    {
      $getverification->status_verification = 'R';
      $getverification->save();

      $getdeveloper->status_verification = 'N';
      $getdeveloper->save();

      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }
    else
    {
      $res = [
        'status' => 500,
        'statusText' => 'success'
      ];
    }

    return response()->json( $res, $res['status'] );
  }

  public function save_report( Request $request, VerificationDeveloper $verification )
  {
    $status = $request->status;

    $getrequest = $verification->select(
      'verification_developer.hash_id',
      'verification_developer.npwp_image',
      'verification_developer.official_certificate',
      'verification_developer.additional_document',
      'verification_developer.status_verification',
      'verification_developer.created_at',
      'verification_developer.updated_at',
      'developer_user.dev_name',
      'developer_user.dev_email'
    )
    ->join('developer_user', 'verification_developer.dev_user_id', '=', 'developer_user.dev_user_id')
    ->orderBy('verification_developer.created_at', 'desc');

    if( $status !== 'all' )
    {
      $getrequest = $getrequest->where('verification_developer.status_verification', $status);
    }

    $filename = 'PengajuanVerifikasi_Developer-' . date('dmY') .'.pdf';
    $data = [
      'filename' => $filename,
      'result' => $getrequest->get()
    ];
    return PDF::loadView('controlpanel.pages.reports.request_verification', $data)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }
}

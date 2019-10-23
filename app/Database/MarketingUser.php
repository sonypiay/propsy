<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;
use App\Database\ProjectRequest;
use App\Database\MarketingUser;
use App\Database\MeetingAppointment;

class MarketingUser extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'marketing_user';
  protected $primaryKey = 'mkt_user_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function getinfo()
  {
    $marketinguser = $this::where('marketing_user.mkt_user_id', session()->get('mkt_user_id'))
    ->select(
      'marketing_user.mkt_user_id',
      'marketing_user.mkt_fullname',
      'marketing_user.mkt_username',
      'marketing_user.mkt_email',
      'marketing_user.mkt_phone_number',
      'marketing_user.mkt_mobile_phone',
      'marketing_user.mkt_address',
      'marketing_user.mkt_profile_photo',
      'marketing_user.dev_user_id',
      'marketing_user.created_at',
      'marketing_user.updated_at',
      'city.city_id',
      'city.city_name',
      'province.province_id',
      'province.province_name'
    )
    ->leftJoin('city', 'marketing_user.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->first();

    return $marketinguser;
  }

  public function generateId()
  {
    $id = 1;
    $getlastid = MarketingUser::select('seqid')->orderBy('seqid', 'desc')->first();

    if( $getlastid !== null )
      $id = $getlastid->seqid + 1;

    $key = 'MKT';
    $pad = str_pad( $id, 4, '0', STR_PAD_LEFT );
    $generate_id = $key . $pad;
    return $generate_id;
  }

  public function hasRequest()
  {
    $session_user = session()->get('mkt_user_id');
    $getdeveloper = MarketingUser::select('dev_user_id')
    ->where('mkt_user_id', $session_user)
    ->first();
    $has_request = 0;

    $check_request = ProjectRequest::where([
      ['dev_user_id', '=', $getdeveloper->dev_user_id],
      ['status_request', '=', 'waiting_response']
    ])->count();

    if( $check_request > 0 )
    {
      $has_request = $check_request;
    }
    return $has_request;
  }

  public function hasMeetingResponse()
  {
    $session_user = session()->get('mkt_user_id');
    $getdeveloper = MarketingUser::select('dev_user_id')
    ->where('mkt_user_id', $session_user)
    ->first();
    $has_request = 0;

    $check_request = MeetingAppointment::where([
      ['project_request.dev_user_id', '=', $getdeveloper->dev_user_id],
      ['meeting_appointment.meeting_status', '=', 'accept']
    ])
    ->orWhere([
      ['project_request.dev_user_id', '=', $getdeveloper->dev_user_id],
      ['meeting_appointment.meeting_status', '=', 'reject']
    ])
    ->join('project_request')
    ->count();

    if( $check_request > 0 )
    {
      $has_request = $check_request;
    }
    return $has_request;
  }
}

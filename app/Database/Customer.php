<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;
use App\Database\MeetingAppointment;

class Customer extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'customer';
  protected $primaryKey = 'customer_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function getinfo()
  {
    $customer = $this::where('customer.customer_id', session()->get('customer_id'))
    ->select(
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_username',
      'customer.customer_email',
      'customer.customer_phone_number',
      'customer.customer_address',
      'customer.customer_photo',
      'customer.created_at',
      'customer.updated_at',
      'customer.status_verification',
      'city.city_id',
      'city.city_name',
      'province.province_id',
      'province.province_name'
    )
    ->leftJoin('city', 'customer.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->first();
    return $customer;
  }

  public function generateId()
  {
    $id = 1;
    $getlastid = $this::select('seqid')->orderBy('seqid', 'desc')->first();

    if( $getlastid !== null )
      $id = $getlastid->seqid + 1;

    $key = 'CUST';
    $pad = str_pad( $id, 4, '0', STR_PAD_LEFT );
    $generate_id = $key . $pad;
    return $generate_id;
  }

  public function hasRequest()
  {
    $session_user = session()->get('customer_id');
    $has_request = 0;

    $check_request = MeetingAppointment::where([
      ['project_request.customer_id', '=', $session_user],
      ['meeting_appointment.meeting_status', '=', 'waiting_confirmation']
    ])
    ->join('project_request', 'meeting_appointment.request_id', '=', 'project_request.request_id')
    ->count();

    if( $check_request > 0 )
    {
      $has_request = $check_request;
    }
    return $has_request;
  }
}

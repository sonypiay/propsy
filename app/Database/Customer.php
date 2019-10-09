<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

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

    $key = 'DEV';
    $pad = str_pad( $id, 4, '0', STR_PAD_LEFT );
    $generate_id = $key . date('ymd') . $pad;
    return $generate_id;
  }
}

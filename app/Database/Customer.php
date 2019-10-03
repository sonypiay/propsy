<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
  public $timestamps = true;
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
      'customer.customer_city',
      'customer.customer_address',
      'customer.customer_photo',
      'customer.created_at',
      'customer.updated_at',
      'customer.status_verification',
      'city.city_name',
      'city.city_slug',
      'province.province_id',
      'province.province_name',
      'province.province_slug'
    )
    ->leftJoin('city', 'customer.customer_city', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->first();
    return $customer;
  }
}

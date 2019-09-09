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
    $customer = $this::where('customer_id', session()->get('customer_id'))
    ->select(
      'customer_id',
      'customer_name',
      'customer_username',
      'customer_email',
      'customer_phone_number',
      'customer_city',
      'customer_region',
      'customer_address',
      'customer_photo',
      'created_at',
      'updated_at'
    )->first();
    return $customer;
  }
}

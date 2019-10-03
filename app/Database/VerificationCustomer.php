<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class VerificationCustomer extends Model
{
  public $timestamps = true;
  protected $table = 'verification_customer';
  protected $primaryKey = 'verify_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function makeVerification($data)
  {
    $verification = $this->where('customer_id', $data['customer_id']);
    if( $verification->count() === 1 )
    {
      $verification = $verification->first();
    }
    else
    {
      $verification = new $this;
    }

    $verification->customer_id = $data['customer_id'];
    $verification->hash_id = $data['hash_id'];
    $verification->expire_date = $data['expire_date'];
    $verification->status_verify = 'N';
    return $verification->save();
  }
}

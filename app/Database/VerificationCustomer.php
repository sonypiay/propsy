<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class VerificationCustomer extends Model
{
  public function $timestamps = true;
  protected $table = 'verification_customer';
  protected $primaryKey = 'verify_id';
  protected $guarded = ['created_at', 'updated_at'];
}

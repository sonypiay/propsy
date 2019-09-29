<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class VerificationDeveloper extends Model
{
  public function $timestamps = true;
  protected $table = 'verification_developer';
  protected $primaryKey = 'verify_id';
  protected $guarded = ['created_at', 'updated_at'];
}

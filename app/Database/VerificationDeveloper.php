<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class VerificationDeveloper extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'verification_developer';
  protected $primaryKey = 'hash_id';
  protected $guarded = ['created_at', 'updated_at'];
}

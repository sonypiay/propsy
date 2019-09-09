<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class Customer extends Model
{
  public $timestamps = true;
  protected $primaryKey = 'request_id';
  protected $guarded = ['created_at', 'updated_at'];
}

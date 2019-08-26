<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class MarketingUser extends Model
{
  public $timestamps = true;
  protected $table = 'marketing_user';
  protected $primaryKey = 'mkt_user_id';
  protected $guarded = ['created_at', 'updated_at'];
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class DeveloperUser extends Model
{
  public $timestamps = true;
  protected $table = 'developer_user';
  protected $primaryKey = 'dev_user_id';
  protected $guarded = ['created_at', 'updated_at'];
}

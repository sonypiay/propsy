<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectRequestInfo extends Model
{
  public $timestamps = true;
  protected $table = 'project_request';
  protected $primaryKey = 'request_id';
  protected $guarded = ['created_at', 'updated_at'];
}

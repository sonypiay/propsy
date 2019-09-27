<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectRequest extends Model
{
  public $timestamps = true;
  protected $table = 'project_request';
  protected $primaryKey = 'request_id';
}

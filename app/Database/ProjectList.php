<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectList extends Model
{
  public $timestamps = true;
  protected $table = 'project_list';
  protected $primaryKey = 'project_id';
  protected $guarded = ['created_at', 'updated_at'];
}

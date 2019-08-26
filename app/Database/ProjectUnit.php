<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectUnit extends Model
{
  public $timestamps = true;
  protected $table = 'project_unit';
  protected $primaryKey = 'project_unit_id';
  protected $guarded = ['created_at', 'updated_at'];
}

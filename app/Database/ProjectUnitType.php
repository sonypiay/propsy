<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectUnitType extends Model
{
  public $timestamps = true;
  protected $table = 'project_unit_type';
  protected $primaryKey = 'unit_type_id';
  protected $guarded = ['created_at', 'updated_at'];
}

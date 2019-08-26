<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectMarketing extends Model
{
  public $timestamps = true;
  protected $table = 'project_marketing';
  protected $primaryKey = 'project_marketing_id';
  protected $guarded = ['created_at', 'updated_at'];
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectSitePlan extends Model
{
  public $timestamps = true;
  protected $table = 'project_siteplan';
  protected $primaryKey = 'siteplan_id';
}

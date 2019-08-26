<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectUnitInstallment extends Model
{
  public $timestamps = true;
  protected $table = 'project_unit_installment';
  protected $primaryKey = 'installment_id';
  protected $guarded = ['created_at', 'updated_at'];
}

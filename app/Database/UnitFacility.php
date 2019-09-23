<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class UnitFacility extends Model
{
  public $timestamps = true;
  protected $table = 'unit_facility';
  protected $primaryKey = 'id_facility';
}

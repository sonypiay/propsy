<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class UnitFacility extends Model
{
  public $timestamps = false;
  protected $table = 'unit_facility';
  protected $primaryKey = 'id_facility';
}

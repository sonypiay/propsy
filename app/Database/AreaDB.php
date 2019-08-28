<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class AreaDB extends Model
{
  public $timestamps = false;
  protected $table = 'area';
  protected $primaryKey = 'area_id';
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProvinceDB extends Model
{
  public $timestamps = false;
  public $incrementing = false;
  protected $table = 'province';
  protected $primaryKey = 'province_id';
}

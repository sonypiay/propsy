<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class CityDB extends Model
{
  public $timestamps = false;
  protected $table = 'city';
  protected $primaryKey = 'city_id';
}

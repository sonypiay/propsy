<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class CityDB extends Model
{
  public $timestamps = false;
  public $incrementing = false;
  protected $table = 'city';
  protected $primaryKey = 'city_id';

  public function getcity()
  {
    return $this::orderBy('city_name', 'asc')->get();
  }
}

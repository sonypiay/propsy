<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class AdminOwner extends Model
{
  public $timestamps = true;
  protected $table = 'admin_owner';
  protected $primaryKey = 'admin_id';

  public function getinfo()
  {
    $result  = $this->where('admin_id', session()->get('cp_admin_id'))->first();
    return $result;
  }
}

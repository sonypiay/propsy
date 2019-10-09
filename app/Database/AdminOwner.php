<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class AdminOwner extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'admin_owner';
  protected $primaryKey = 'admin_id';

  public function getinfo()
  {
    $result  = $this->where('admin_id', session()->get('cp_admin_id'))->first();
    return $result;
  }

  public function generateId()
  {
    $id = 1;
    $getlastid = $this::select('seqid')->orderBy('seqid', 'desc')->first();

    if( $getlastid !== null )
      $id = $getlastid->seqid + 1;

    $key = 'DEV';
    $pad = str_pad( $id, 4, '0', STR_PAD_LEFT );
    $generate_id = $key . date('ymd') . $pad;
    return $generate_id;
  }
}

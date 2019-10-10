<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectRequest extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'project_request';
  protected $primaryKey = 'request_id';

  public function generateId()
  {
    $id = 1;
    $getlastid = $this::select('seqid')->orderBy('seqid', 'desc')->first();

    if( $getlastid !== null )
      $id = $getlastid->seqid + 1;

    $key = 'REQ';
    $pad = str_pad( $id, 4, '0', STR_PAD_LEFT );
    $generate_id = $key . date('Ymd') . $pad;
    return $generate_id;
  }
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectUnitType extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'project_unit_type';
  protected $primaryKey = 'unit_type_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function generateId()
  {
    $id = 1;
    $getlastid = $this::select('seqid')->orderBy('seqid', 'desc')->first();

    if( $getlastid !== null )
      $id = $getlastid->seqid + 1;

    $key = 'UNIT';
    $pad = str_pad( $id, 4, '0', STR_PAD_LEFT );
    $generate_id = $key . date('ymd') . $pad;
    return $generate_id;
  }
}

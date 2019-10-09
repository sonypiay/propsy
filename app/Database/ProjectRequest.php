<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectRequest extends Model
{
  public $timestamps = true;
  protected $table = 'project_request';
  protected $primaryKey = 'request_id';

  public function hasNewRequest( $session_user = null )
  {
    if( $session_user === null )
      $session_user = session()->get('dev_user_id');

    $has_request = false;

    $check_request = $this->where([
      ['dev_user_id', '=', $session_user],
      ['status_request', '=', 'waiting_response']
    ])->count();
    if( $check_request > 0 )
    {
      $has_request = true;
    }
    return $has_request;
  }

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

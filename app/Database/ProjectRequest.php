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
}

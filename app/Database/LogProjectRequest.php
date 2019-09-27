<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class LogProjectRequest extends Model
{
  public $timestamps = true;
  protected $table = 'log_project_request';
  protected $primaryKey = 'log_id';

  public function insert_log($param)
  {
    $this->log_message = $param['message'];
    $this->request_unique_id = $param['request_id'];
    return $this->save();
  }
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class LogProjectRequest extends Model
{
  public $timestamps = false;
  protected $table = 'log_project_request';
  protected $primaryKey = 'log_id';

  public function insert_log($param)
  {
    $this->log_message = $param['message'];
    $this->request_id = $param['request_id'];
    $this->log_date = date('Y-m-d H:i:s');
    return $this->save();
  }
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ResetPassword extends Model
{
  public $timestamps = false;
  protected $table = 'reset_password';
  protected $primaryKey = 'token';
  public $incrementing = false;

  public function insertResetPassword( $data )
  {
    $this->token = $data['token'];
    $this->useremail = $data['email'];
    $this->usertype = $data['usertype'];
    $this->expired_token = $data['expired'];
    $this->created_at = date('Y-m-d H:i:s');
    return $this->save();
  }
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class DeveloperUser extends Model
{
  public $timestamps = true;
  protected $table = 'developer_user';
  protected $primaryKey = 'dev_user_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function getinfo()
  {
    $developeruser = $this::where('dev_user_id', session()->get('dev_user_id'))
    ->select(
      'dev_user_id',
      'dev_ownername',
      'dev_name',
      'dev_email',
      'dev_username',
      'dev_address',
      'dev_city',
      'dev_region',
      'dev_slug',
      'dev_biography',
      'dev_phone_office',
      'dev_mobile_phone',
      'dev_ownership',
      'dev_gmaps',
      'created_at',
      'updated_at'
    )->first();
    return $developeruser;
  }
}

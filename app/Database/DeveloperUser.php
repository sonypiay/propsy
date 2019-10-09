<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class DeveloperUser extends Model
{
  public $timestamps = true;
  public $incrementing = false;
  protected $table = 'developer_user';
  protected $primaryKey = 'dev_user_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function getinfo()
  {
    $developeruser = $this->select(
      'developer_user.dev_user_id',
      'developer_user.dev_logo',
      'developer_user.dev_ownername',
      'developer_user.dev_name',
      'developer_user.dev_email',
      'developer_user.dev_username',
      'developer_user.dev_address',
      'developer_user.dev_slug',
      'developer_user.dev_biography',
      'developer_user.dev_phone_office',
      'developer_user.dev_mobile_phone',
      'developer_user.created_at',
      'developer_user.updated_at',
      'city.city_name',
      'city.city_id',
      'province.province_id',
      'province.province_name'
    )
    ->where('developer_user.dev_user_id', session()->get('dev_user_id'))
    ->leftJoin('city', 'developer_user.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->first();
    return $developeruser;
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

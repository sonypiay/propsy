<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class MarketingUser extends Model
{
  public $timestamps = true;
  protected $table = 'marketing_user';
  protected $primaryKey = 'mkt_user_id';
  protected $guarded = ['created_at', 'updated_at'];

  public function getinfo()
  {
    $marketinguser = $this::where('mkt_user_id', session()->get('mkt_user_id'))
    ->select(
      'mkt_user_id',
      'mkt_fullname',
      'mkt_username',
      'mkt_email',
      'mkt_phone_number',
      'mkt_mobile_phone',
      'mkt_city',
      'mkt_region',
      'mkt_address',
      'mkt_biography',
      'mkt_profile_photo',
      'created_at',
      'updated_at'
    )->first();

    return $marketinguser;
  }
}

<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class PriceInstallment extends Model
{
  public $timestamps = false;
  protected $table = 'price_installment';
  protected $primaryKey = 'id';

  public function store_cicilan( $data )
  {
    $this->unit_type_id = $data['unit_id'];
    $this->dp_price = $data['dp'];
    $this->installment_price = $data['cicilan'];
    $this->installment_tenor = $data['tenor'];
    return $this->save();
  }

  public function save_cicilan( $data, $id )
  {
    $db = $this->where('id', $id)->first();
    $db->unit_type_id = $data['unit_id'];
    $db->dp_price = $data['dp'];
    $db->installment_price = $data['cicilan'];
    $db->installment_tenor = $data['tenor'];
    return $db->save();
  }

  public function delete_cicilan( $id )
  {
    return $this->where( 'id', $id )->delete();
  }
}

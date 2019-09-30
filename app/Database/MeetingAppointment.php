<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class MeetingAppointment extends Model
{
  public $timestamps = true;
  protected $table = 'meeting_appointment';
  protected $primaryKey = 'meeting_id';
  protected $guarded = ['created_at', 'updated_at'];
}

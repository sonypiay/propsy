<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectUnitGallery extends Model
{
  public $timestamps = true;
  protected $table = 'project_unit_gallery';
  protected $primaryKey = 'unit_gallery_id';
}

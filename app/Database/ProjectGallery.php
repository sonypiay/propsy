<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectGallery extends Model
{
  public $timestamps = false;
  protected $table = 'project_gallery';
  protected $primaryKey = 'gallery_id';
}

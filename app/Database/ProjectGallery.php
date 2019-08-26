<?php

namespace App\Database;

use Illuminate\Database\Eloquent\Model;

class ProjectGallery extends Model
{
  public $timestamps = true;
  protected $table = 'project_gallery';
  protected $primaryKey = 'gallery_id';
  protected $guarded = ['created_at', 'updated_at'];
}

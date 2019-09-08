<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\ProjectList;
use App\Database\ProjectGallery;
use App\Http\Controllers\Controller;

class ProjectGalleryController extends Controller
{
  public function project_gallery( Request $request, DeveloperUser $developeruser, ProjectList $project_list, $project_id )
  {
    if( session()->has('isDeveloper') )
    {
      $getproject = $project_list->select(
        'project_id',
        'project_name'
      )
      ->where('project_id', $project_id)->first();
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'projects' => $getproject
      ];

      return response()->view('frontend.pages.developer.gallery', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function get_gallery( Request $request, DeveloperUser $developeruser, ProjectGallery $gallery, $project_id )
  {
    $gallery = new $gallery;
    $query = $gallery->select(
      'project_gallery.gallery_id',
      'project_gallery.gallery_filename',
      'project_gallery.gallery_description',
      'project_gallery.created_at',
      'project_gallery.updated_at',
      'project_list.project_id',
      'project_list.project_name'
    )
    ->join('project_list', 'project_gallery.project_id', '=', 'project_list.project_id')
    ->where('project_gallery.project_id', $project_id)
    ->orderBy('project_gallery.created_at', 'desc');
    $data = [
      'data' => [
        'total' => $query->count(),
        'row' => $query->get()
      ]
    ];

    return response()->json( $data, 200 );
  }

  public function upload_gallery( Request $request, ProjectGallery $gallery, $project_id )
  {
    $image = $request->image;
    $filename = $image->hashName();
    $path_img = 'images/project/gallery';
    $storage = Storage::disk('assets');

    $gallery = new $gallery;
    $gallery->gallery_filename = $filename;
    $gallery->project_id = $project_id;
    $gallery->save();
    $storage->putFileAs( $path_img, $image, $filename );

    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function gallery_asThumbnail( ProjectList $project_list, ProjectGallery $gallery, $gallery_id )
  {
    $getgallery = $gallery->where('gallery_id', $gallery_id)->first();
    $getproject = $project_list->where('project_id', $getgallery->project_id)->first();
    $getproject->project_thumbnail = $getgallery->gallery_filename;
    $getproject->save();
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function delete_gallery( ProjectGallery $gallery, $gallery_id )
  {
    $path_img = 'images/project/gallery';
    $storage = Storage::disk('assets');
    $getgallery = $gallery->where('gallery_id', $gallery_id);
    if( $getgallery->count() != 0 )
    {
      $result = $getgallery->first();
      if( $storage->exists( $path_img . '/' . $result->gallery_filename ) )
      {
        $storage->delete( $path_img . '/' . $result->gallery_filename );
      }
      $getgallery->delete();
    }
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }
}

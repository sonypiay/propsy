<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\ProjectList;
use App\Database\ProjectGallery;
use App\Database\AreaDB;
use App\Http\Controllers\Controller;

class ProjectListController extends Controller
{
  public function dev_manage_project( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo()
      ];

      return response()->view('frontend.pages.developer.projects', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function add_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list )
  {
    $project_name = $request->project_name;
    $project_slug = str_slug( $project_name );
    $project_region = $request->project_region;
    $project_city = $request->project_city;
    $project_address = $request->project_address;
    $project_gmaps = $request->project_gmaps;
    $project_description = $request->project_description;
    $project_status = $request->project_status;

    $insert = new $project_list;
    $insert->project_name = $project_name;
    $insert->project_slug = $project_slug;
    $insert->project_region = $project_region;
    $insert->project_city = $project_city;
    $insert->project_address = $project_address;
    $insert->project_gmaps = $project_gmaps;
    $insert->project_description = $project_description;
    $insert->project_status = $project_status;
    $insert->dev_user_id = session()->get('dev_user_id');
    $insert->save();
    $res = [ 'status' => 200, 'statusText' => 'success' ];

    return response()->json( $res, $res['status'] );
  }

  public function save_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list, $project_id )
  {
    $project_name = $request->project_name;
    $project_slug = str_slug( $project_name );
    $project_region = $request->project_region;
    $project_city = $request->project_city;
    $project_address = $request->project_address;
    $project_gmaps = $request->project_gmaps;
    $project_description = $request->project_description;
    $project_status = $request->project_status;

    $update = $project_list->where('project_id', $project_id)->first();
    $update->project_name = $project_name;
    $update->project_slug = $project_slug;
    $update->project_region = $project_region;
    $update->project_city = $project_city;
    $update->project_address = $project_address;
    $update->project_gmaps = $project_gmaps;
    $update->project_description = $project_description;
    $update->project_status = $project_status;
    $update->save();
    $res = [ 'status' => 200, 'statusText' => 'success' ];

    return response()->json( $res, $res['status'] );
  }

  public function getProjectList( Request $request, ProjectList $project_list, DeveloperUser $developeruser )
  {
    $keywords = $request->keywords;
    $status = $request->status;
    $devuser = $developeruser->getinfo();
    $project = new $project_list;

    if( empty( $keywords ) )
    {
      $query = $project->where('dev_user_id', $devuser->dev_user_id)
      ->orderBy('created_at', 'desc');
      if( $status !== 'all' )
      {
        $query = $project->where([
          ['project_status', $status],
          ['dev_user_id', $devuser->dev_user_id]
        ])
        ->orderBy('created_at', 'desc');
      }
    }
    else
    {
      $query = $project->where([
        ['project_name', 'like', '%' . $keywords . '%'],
        ['dev_user_id', $devuser->dev_user_id]
      ])
      ->orderBy('created_at', 'desc');
      if( $status !== 'all' )
      {
        $query = $project->where([
          ['project_status', $status],
          ['project_name', 'like', '%' . $keywords . '%'],
          ['dev_user_id', $devuser->dev_user_id]
        ])
        ->orderBy('created_at', 'desc');
      }
    }
    $fetchdata = $query->paginate( 6 );
    $data = [
      'status' => 200,
      'statusText' => 'success',
      'results' => $fetchdata
    ];
    return response()->json( $data, $data['status'] );
  }

  public function delete_project( Request $request, ProjectList $project_list, ProjectGallery $gallery, $project_id )
  {
    $path_img = 'images/project/gallery';
    $storage = Storage::disk('assets');
    $getproject = $project_list->where('project_id', $project_id);
    if( $getproject->count() !== 0 )
    {
      $getgallery = $gallery->where('project_id', $project_id);
      if( $getgallery->count() !== 0 )
      {
        foreach( $getgallery->get() as $g ):
          if( $storage->exists( $path_img . '/' . $g->gallery_filename ) )
          {
            $storage->delete( $path_img . '/' . $g->gallery_filename );
          }
        endforeach;
        $getgallery->delete();
      }
      $getproject->delete();
    }
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function detail_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list, AreaDB $area, $project_id )
  {
    if( session()->has('isDeveloper') )
    {
      $getproject = $project_list->where('project_id', $project_id)->first();
      $getkota = $area->where('area_id', $getproject->project_city)->first();
      $getprovinsi = $area->where('area_id', $getproject->project_region)->first();
      $getarea = [ 'kota' => $getkota, 'provinsi' => $getprovinsi ];

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'projects' => $getproject,
        'getarea' => $getarea
      ];
      return response()->view('frontend.pages.developer.detail_project', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }
}

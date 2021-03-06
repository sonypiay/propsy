<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\ProjectGallery;
use App\Database\ProjectUnitGallery;
use App\Database\UnitFacility;
use App\Database\ProvinceDB;
use App\Database\CityDB;
use App\Http\Controllers\Controller;

class ProjectListController extends Controller
{
  public function dev_manage_project( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasrequest' => $developeruser->hasrequest()
      ];

      return response()->view('frontend.pages.developer.projects', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function add_project_page( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasrequest' => $developeruser->hasrequest()
      ];

      return response()->view('frontend.pages.developer.add_project', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function add_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list, ProjectGallery $project_gallery )
  {
    $project_name = $request->project_name;
    $project_slug = str_slug( $project_name );
    $project_city = $request->project_city;
    $project_address = $request->project_address;
    $project_link_map = $request->project_link_map;
    $project_map_embed = $request->project_map_embed;
    $project_description = $request->project_description;
    $project_status = $request->project_status;
    $project_type = $request->project_type;
    $project_thumbnail = $request->project_thumbnail;
    $project_estimate_launch = $request->project_estimate_launch;
    $data_site_plan = [];
    $storage = Storage::disk('assets');
    $thumbnail = ! empty( $project_thumbnail ) ? $project_thumbnail->hashName() : null;
    $project_id = $project_list->generateId();

    $insert_project = new $project_list;
    $insert_gallery = new $project_gallery;
    $insert_project->project_name = $project_name;
    $insert_project->project_id = $project_id;
    $insert_project->project_slug = $project_slug;
    $insert_project->city_id = $project_city;
    $insert_project->project_address = $project_address;
    $insert_project->project_link_map = $project_link_map;
    $insert_project->project_map_embed = $project_map_embed;
    $insert_project->project_description = $project_description;
    $insert_project->project_status = $project_status;
    $insert_project->project_type = $project_type;
    $insert_project->project_thumbnail = $thumbnail;
    if( $project_status == 'soon' )
    {
      $insert_project->project_estimate_launch = $project_estimate_launch;
    }
    $insert_project->dev_user_id = session()->get('dev_user_id');
    $insert_project->save();

    if( ! empty( $project_thumbnail ) || $project_thumbnail !== null )
    {

      $insert_gallery->gallery_filename = $thumbnail;
      $insert_gallery->project_id = $project_id;
      $insert_gallery->save();
      $storage->putFileAs( 'images/project/gallery', $project_thumbnail, $thumbnail );
    }

    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function edit_project_page( Request $request, DeveloperUser $developeruser, ProjectList $project_list, $id )
  {
    if( session()->has('isDeveloper') )
    {
      $getproject = $project_list->select(
        'project_list.project_id',
        'project_list.project_name',
        'project_list.project_slug',
        'project_list.project_thumbnail',
        'project_list.project_description',
        'project_list.city_id',
        'project_list.project_address',
        'project_list.project_link_map',
        'project_list.project_map_embed',
        'project_list.project_status',
        'project_list.project_type',
        'project_list.project_address',
        'project_list.project_estimate_launch',
        'project_list.dev_user_id',
        'project_list.created_at',
        'project_list.updated_at',
        'city.city_name',
        'province.province_id',
        'province.province_name'
      )
      ->leftJoin('city', 'project_list.city_id', '=', 'city.city_id')
      ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
      ->where('project_list.project_id', $id)
      ->orWhere('project_list.project_id', $id)
      ->first();
      if( ! $getproject ) abort(404);

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'hasrequest' => $developeruser->hasrequest(),
        'getproject' => $getproject
      ];

      return response()->view('frontend.pages.developer.edit_project', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function save_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list, ProjectGallery $project_gallery, $project_id )
  {
    $project_name = $request->project_name;
    $project_slug = str_slug( $project_name );
    $project_city = $request->project_city;
    $project_address = $request->project_address;
    $project_link_map = $request->project_link_map;
    $project_map_embed = $request->project_map_embed;
    $project_description = $request->project_description;
    $project_status = $request->project_status;
    $project_type = $request->project_type;
    $project_thumbnail = $request->project_thumbnail;
    $project_estimate_launch = $request->project_estimate_launch;
    $storage = Storage::disk('assets');
    $thumbnail = ! empty( $project_thumbnail ) ? $project_thumbnail->hashName() : '';
    $thumbnail_path = 'images/project/gallery';

    $update = $project_list->where('project_id', $project_id)->first();
    if( ! empty( $project_thumbnail ) )
    {
      $update->project_thumbnail = $thumbnail;

      $insert_gallery = new $project_gallery;
      $insert_gallery->gallery_filename = $thumbnail;
      $insert_gallery->project_id = $update->project_id;
      $insert_gallery->save();
      $storage->putFileAs( $thumbnail_path, $project_thumbnail, $thumbnail );
    }

    if( $project_status == 'soon' )
    {
      $update->project_estimate_launch = $project_estimate_launch;
    }
    else
    {
      $update->project_estimate_launch = null;
    }

    $update->project_name = $project_name;
    $update->project_slug = $project_slug;
    $update->city_id = $project_city;
    $update->project_address = $project_address;
    $update->project_link_map = $project_link_map;
    $update->project_map_embed = $project_map_embed;
    $update->project_description = $project_description;
    $update->project_status = $project_status;
    $update->project_type = $project_type;
    $update->save();
    $res = [ 'status' => 200, 'statusText' => 'success' ];

    return response()->json( $res, $res['status'] );
  }

  public function getProjectList( Request $request, ProjectList $project_list, DeveloperUser $developeruser )
  {
    $keywords = $request->keywords;
    $status = $request->status;
    $devuser = $developeruser->getinfo();
    $project = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_description',
      'project_list.project_address',
      'project_list.project_link_map',
      'project_list.project_map_embed',
      'project_list.project_status',
      'project_list.project_type',
      'project_list.project_estimate_launch',
      'project_list.dev_user_id',
      'project_list.created_at',
      'project_list.updated_at',
      'city.city_id',
      'city.city_name',
      'province.province_id',
      'province.province_name'
    )
    ->leftJoin('city', 'project_list.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id');

    if( empty( $keywords ) )
    {
      $query = $project->where('project_list.dev_user_id', $devuser->dev_user_id)
      ->orderBy('project_list.created_at', 'desc');
      if( $status !== 'all' )
      {
        $query = $project->where([
          ['project_list.project_status', $status],
          ['project_list.dev_user_id', $devuser->dev_user_id]
        ])
        ->orderBy('project_list.created_at', 'desc');
      }
    }
    else
    {
      $query = $project->where([
        ['project_list.project_name', 'like', '%' . $keywords . '%'],
        ['project_list.dev_user_id', $devuser->dev_user_id]
      ])
      ->orderBy('project_list.created_at', 'desc');
      if( $status !== 'all' )
      {
        $query = $project->where([
          ['project_list.project_status', $status],
          ['project_list.project_name', 'like', '%' . $keywords . '%'],
          ['project_list.dev_user_id', $devuser->dev_user_id]
        ])
        ->orderBy('project_list.created_at', 'desc');
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

  public function delete_project( Request $request, ProjectList $project_list, ProjectGallery $gallery, ProjectUnitGallery $unit_gallery, $project_id )
  {
    $path_img = 'images/project/gallery';
    $storage = Storage::disk('assets');
    $getproject = $project_list->where('project_id', $project_id);
    if( $getproject->count() !== 0 )
    {
      $result_project = $getproject->first();
      $getgallery = $gallery->where('project_id', $result_project->project_id);
      $getunitgallery = $unit_gallery->select(
        'project_unit_gallery.unit_gallery_filename',
        'project_unit_gallery.unit_type_id'
      )
      ->join('project_unit_type', 'project_unit_gallery.unit_type_id', '=', 'project_unit_type.unit_type_id')
      ->where('project_unit_type.project_id', $project_id)
      ->groupBy('project_unit_type.unit_type_id')
      ->get();

      if( $getgallery->count() > 0 )
      {
        foreach( $getgallery->get() as $g ):
          if( $storage->exists( $path_img . '/' . $g->gallery_filename ) )
          {
            $storage->delete( $path_img . '/' . $g->gallery_filename );
          }
        endforeach;
      }

      if( $getunitgallery->count() > 0 )
      {
        foreach( $getunitgallery as $g ):
          if( $storage->exists( $path_img . '/' . $g->unit_gallery_filename ) )
          {
            $storage->delete( $path_img . '/' . $g->unit_gallery_filename );
          }
        endforeach;
      }
      $getproject->delete();
    }
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function detail_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list, UnitFacility $unitfacility, $project_id )
  {
    if( session()->has('isDeveloper') )
    {
      $getproject = $project_list->select(
        'project_list.project_id',
        'project_list.project_name',
        'project_list.project_slug',
        'project_list.project_thumbnail',
        'project_list.project_description',
        'project_list.project_address',
        'project_list.project_link_map',
        'project_list.project_map_embed',
        'project_list.project_status',
        'project_list.project_type',
        'project_list.project_estimate_launch',
        'project_list.dev_user_id',
        'project_list.created_at',
        'project_list.updated_at',
        'city.city_id',
        'city.city_name',
        'province.province_id',
        'province.province_name'
      )
      ->leftJoin('city', 'project_list.city_id', '=', 'city.city_id')
      ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
      ->where([
        ['project_list.project_id', $project_id],
        ['project_list.dev_user_id', session()->get('dev_user_id')]
      ])
      ->first();
      if( ! $getproject ) abort(404);

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'getproject' => $getproject,
        'hasrequest' => $developeruser->hasrequest()
      ];
      return response()->view('frontend.pages.developer.detail_project', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

}

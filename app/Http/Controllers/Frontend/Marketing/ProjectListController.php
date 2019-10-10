<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Database\MarketingUser;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\ProjectGallery;
use App\Database\ProjectUnitGallery;
use App\Database\UnitFacility;

use App\Http\Controllers\Controller;

class ProjectListController extends Controller
{
  public function index( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];
      return response()->view('frontend.pages.marketing.projects', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function getProjectList( Request $request, ProjectList $project_list, MarketingUser $marketinguser )
  {
    $keywords = $request->keywords;
    $status = $request->status;
    $devuser = $marketinguser->getinfo();
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

  public function detail_project( Request $request, MarketingUser $marketinguser, ProjectList $project_list, UnitFacility $unitfacility, $project_id )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
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
        ['project_list.dev_user_id', $getmarketing->dev_user_id]
      ])
      ->first();
      if( ! $getproject ) abort(404);

      $data = [
        'request' => $request,
        'session_user' => $getmarketing,
        'getproject' => $getproject
      ];
      return response()->view('frontend.pages.marketing.detail_project', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }
}

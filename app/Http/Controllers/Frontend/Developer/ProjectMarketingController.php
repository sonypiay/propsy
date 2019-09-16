<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Database\ProjectList;
use App\Database\ProjectMarketing;
use App\Database\AreaDB;
use App\Database\CityDB;
use App\Http\Controllers\Controller;

class ProjectMarketingController extends Controller
{
  public function index( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $city = new CityDB;
      $project_list = new ProjectList;
      $getcity = $city->orderBy('city_name', 'asc')->get();
      $getproject = $project_list->where('dev_user_id', session()->get('dev_user_id'))
      ->get();

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'getcity' => $getcity,
        'getproject' => $getproject
      ];
      return response()->view('frontend.pages.developer.find_marketing', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function listOfMarketing( Request $request, MarketingUser $marketinguser )
  {
    $keywords = $request->keywords;
    $sorting = $request->sorting;
    $limit = 10;
    $column = $request->column;
    $city = $request->city;

    $marketing = $marketinguser->select(
      'marketing_user.mkt_user_id',
      'marketing_user.mkt_fullname',
      'marketing_user.mkt_email',
      'marketing_user.mkt_phone_number',
      'marketing_user.mkt_mobile_phone',
      'marketing_user.mkt_city',
      'marketing_user.mkt_address',
      'marketing_user.mkt_biography',
      'marketing_user.mkt_profile_photo',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'marketing_user.mkt_city', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_marketing', 'marketing_user.mkt_user_id', '=', 'project_marketing.mkt_user_id')
    ->groupBy('marketing_user.mkt_user_id');

    if( empty( $keywords ) )
    {
      $getmarketing = $marketing->orderBy('marketing_user.mkt_fullname', $sorting);
      if( $city !== 'all' )
      {
        $getmarketing = $marketing->where('marketing_user.mkt_city', $city)
        ->orderBy('marketing_user.mkt_fullname', $sorting);
      }
    }
    else
    {
      $getmarketing = $marketing->where('marketing_user.' . $column, 'like', '%' . $keywords. '%')
      ->orderBy('marketing_user.mkt_fullname', $sorting);

      if( $city !== 'all' )
      {
        $getmarketing = $marketing->where([
          ['marketing_user.' . $column, 'like', '%' . $keywords. '%'],
          ['marketing_user.mkt_city', $city]
        ])
        ->orderBy('marketing_user.mkt_fullname', $sorting);
      }
    }

    $result = $getmarketing->paginate( $limit );
    $res = [ 'results' => $result ];
    return response()->json( $res, 200 );
  }

  public function projectSelected( ProjectMarketing $project_mkt, $userid )
  {
    $selectedproject = $project_mkt->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_marketing.mkt_user_id'
    )
    ->rightJoin('project_list', 'project_marketing.project_id', '=', 'project_list.project_id')
    ->where('project_list.dev_user_id', session()->get('dev_user_id'))
    ->orderBy('project_list.project_name', 'asc')
    ->groupBy('project_list.project_id')
    ->get();

    $result = [
      'results' => [
        'data' => $selectedproject,
        'total' => $selectedproject->count()
      ]
    ];
    return response()->json( $result, 200 );
  }

  public function recruit_marketing( Request $request, ProjectMarketing $project_mkt, $userid )
  {
    $selectedproject = $request->selectedproject;
    $date = date('Y-m-d H:i:s');
    $dev_user_id = session()->get('dev_user_id');
    $data = [];

    $delete = $project_mkt->where([
      ['dev_user_id', $dev_user_id],
      ['mkt_user_id', $userid]
    ]);
    if( $delete->count() > 0 ) $delete->delete();

    foreach( $selectedproject as $project )
    {
      $data[] = [
        'dev_user_id' => $dev_user_id,
        'mkt_user_id' => $userid,
        'project_id' => $project,
        'created_at' => $date,
        'updated_at' => $date
      ];
    }

    $insert = $project_mkt->insert($data);
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }
}

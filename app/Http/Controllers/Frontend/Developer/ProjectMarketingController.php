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
      $area = new AreaDB;
      $getarea = $area->where('area_level_id', 2)->get();
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'getarea' => $getarea
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
    $offset = $request->offset;
    $city = $request->city;

    $marketing = $marketinguser->select(
      'mkt_fullname',
      'mkt_email',
      'mkt_phone_number',
      'mkt_mobile_phone',
      'mkt_city',
      'mkt_region',
      'mkt_address',
      'mkt_biography',
      'mkt_profile_photo',
      'area.area_id',
      'area.area_name'
    )
    ->leftJoin('area', 'marketing_user.mkt_city', '=', 'area.area_id');
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
    $result = $getmarketing->limit( $limit )->offset( $offset )->get();

    $res = [
      'results' => [
        'data' => $result,
        'total' => $result->count()
      ]
    ];
    return response()->json( $res, 200 );
  }
}

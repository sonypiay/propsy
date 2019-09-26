<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Database\ProjectList;
use App\Database\AreaDB;
use App\Database\CityDB;
use App\Http\Controllers\Controller;

class ProjectMarketingController extends Controller
{
  private $session_user;

  public function __construct() {
    $this->session_user = session()->get('dev_user_id');
  }

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
      return response()->view('frontend.pages.developer.manage_marketing', $data);
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
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'marketing_user.mkt_city', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id');

    if( empty( $keywords ) )
    {
      $getmarketing = $marketing->where('dev_user_id', $this->session_user)
      ->orderBy('marketing_user.mkt_fullname', $sorting);
      if( $city !== 'all' )
      {
        $getmarketing = $marketing->where([
          ['marketing_user.mkt_city', $city],
          ['dev_user_id', $this->session_user]
        ])
        ->orderBy('marketing_user.mkt_fullname', $sorting);
      }
    }
    else
    {
      $getmarketing = $marketing->where([
        ['marketing_user.' . $column, 'like', '%' . $keywords. '%'],
        ['dev_user_id', $this->session_user]
      ])
      ->orderBy('marketing_user.mkt_fullname', $sorting);

      if( $city !== 'all' )
      {
        $getmarketing = $marketing->where([
          ['marketing_user.' . $column, 'like', '%' . $keywords. '%'],
          ['marketing_user.mkt_city', $city],
          ['dev_user_id', $this->session_user]
        ])
        ->orderBy('marketing_user.mkt_fullname', $sorting);
      }
    }

    $result = $getmarketing->paginate( $limit );
    $res = [ 'results' => $result ];
    return response()->json( $res, 200 );
  }

  public function add_marketing( Request $request, MarketingUser $marketinguser )
  {
    $fullname = $request->mkt_fullname;
    $email = $request->mkt_email;
    $username = $request->mkt_username;
    $password = $request->mkt_password;
    $hash_password = md5( $password );
    $check_username = $marketinguser->where('mkt_username', $username);
    $check_email = $marketinguser->where('mkt_email', $email);

    if( $check_username->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $username . ' sudah digunakan'
      ];
    }
    else if( $check_email->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $email . ' sudah digunakan'
      ];
    }
    else
    {
      $insert = new $marketinguser;
      $insert->mkt_fullname = $fullname;
      $insert->mkt_email = $email;
      $insert->mkt_username = $username;
      $insert->mkt_password = $hash_password;
      $insert->dev_user_id = $this->session_user;
      $insert->save();

      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }
}

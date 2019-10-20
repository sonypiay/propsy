<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\MarketingUser;
use App\Database\AdminOwner;
use App\Database\CityDB;
use App\Http\Controllers\Controller;
use PDF;

class MarketingController extends Controller
{
  public function index( Request $request, AdminOwner $owner, CityDB $city )
  {
    if( session()->has('isControlPanel') )
    {
      $getcity = $city->orderBy('city_name', 'asc')->get();
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo(),
        'getcity' => $getcity
      ];
      return response()->view('controlpanel.pages.developer.marketing', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_marketing( Request $request, MarketingUser $marketing )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $city = $request->city;
    $getmarketing = $marketing->select(
      'marketing_user.mkt_user_id',
      'marketing_user.mkt_fullname',
      'marketing_user.mkt_email',
      'marketing_user.mkt_username',
      'marketing_user.mkt_password',
      'marketing_user.mkt_phone_number',
      'marketing_user.mkt_mobile_phone',
      'marketing_user.mkt_address',
      'marketing_user.mkt_profile_photo',
      'marketing_user.created_at',
      'developer_user.dev_name',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->join('developer_user', 'marketing_user.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'marketing_user.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('marketing_user.created_at', 'desc');

    if( $city !== 'all' )
    {
      $getmarketing = $getmarketing->where('marketing_user.city_id', $city);
    }
    if( ! empty( $keywords ) )
    {
      $getmarketing = $getmarketing->where(function($query) use ($keywords) {
        $query->where('marketing_user.mkt_fullname', 'like', '%' . $keywords . '%')
        ->orWhere('marketing_user.mkt_email', 'like', '%' . $keywords . '%');
      });
    }

    $result = $getmarketing->paginate( $limit );
    return response()->json( $result, 200 );
  }
}

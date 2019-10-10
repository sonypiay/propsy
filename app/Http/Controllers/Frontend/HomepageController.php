<?php

namespace App\Http\Controllers\Frontend;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Database\Customer;
use App\Http\Controllers\Controller;

class HomepageController extends Controller
{
  public function index( Request $request, DeveloperUser $developeruser, MarketingUser $marketinguser, Customer $customer )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    if( session()->has('isMarketing') )
    {
      $data['session_user'] = $marketinguser->getinfo();
    }
    else if( session()->has('isDeveloper') )
    {
      $data['session_user'] = $developeruser->getinfo();
    }
    else
    {
      $data['session_user'] = $customer->getinfo();
    }

    return response()->view('frontend.pages.homepage', $data)
    ->header('Content-Type', 'text/html')
    ->header('Accepts', 'text/html');
  }

  public function browse_project( Request $request, Customer $customer )
  {
    $data['session_user'] = null;
    if( session()->has('isDeveloper') ) { return redirect()->route('developer_dashboard_page'); }
    else if( session()->has('isMarketing') ) { return redirect()->route('marketing_dashboard_page'); }
    else
    {
      $data['request'] = $request;
      if( session()->has('isCustomer') ) $data['session_user'] = $customer->getinfo();

      return response()->view('frontend.pages.homepage', $data)
      ->header('Content-Type', 'text/html')
      ->header('Accepts', 'text/html');
    }
  }

  public function homepage_developer( Request $request, MarketingUser $marketinguser, DeveloperUser $developeruser, Customer $customer, $slug )
  {
    $data['request'] = $request;
    $data['session_user'] = [];
    if( session()->has('isMarketing') )
    {
      $data['session_user'] = $marketinguser->getinfo();
    }
    else if( session()->has('isDeveloper') )
    {
      $data['session_user'] = $developeruser->getinfo();
    }
    else
    {
      $data['session_user'] = $customer->getinfo();
    }

    $getdeveloper = $developeruser->select(
      'developer_user.dev_name',
      'developer_user.dev_ownername',
      'developer_user.dev_slug',
      'developer_user.dev_address',
      'developer_user.dev_email',
      'developer_user.dev_biography',
      'developer_user.dev_phone_office',
      'developer_user.dev_mobile_phone',
      'developer_user.dev_logo',
      'developer_user.city_id',
      'developer_user.status_verification',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'developer_user.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->where('developer_user.dev_slug', $slug)
    ->first();

    $data['getdeveloper'] = $getdeveloper;
    return response()->view( 'frontend.pages.developer_profile', $data);
  }
}

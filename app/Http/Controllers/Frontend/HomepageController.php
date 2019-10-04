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
    
  }
}

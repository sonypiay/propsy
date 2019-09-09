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

  public function signup_page( Request $request )
  {
    if( session()->has('isDeveloper')  || session()->has('isMarketing') )
    {
      return redirect()->route('homepage');
    }

    $data = [
      'request' => $request
    ];

    return response()->view('frontend.pages.homepage')
    ->header('Content-Type', 'text/html')
    ->header('Accepts', 'text/html');
  }
}

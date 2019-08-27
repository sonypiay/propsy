<?php

namespace App\Http\Controllers\Frontend;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Http\Controllers\Controller;

class HomepageController extends Controller
{
  public function index( Request $request, DeveloperUser $developeruser, MarketingUser $marketinguser )
  {
    $data['request'] = $request;
    if( session()->has('isMarketing') )
    {
      $mktuser = $marketinguser->getinfo();
      $data['session_user'] = $mktuser;
    }
    else
    {
      $devuser = $developeruser->getinfo();
      $data['session_user'] = $devuser;
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

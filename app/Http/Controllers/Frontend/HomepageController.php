<?php

namespace App\Http\Controllers\Frontend;

use Illuminate\Http\Request;
use App\Database\DeveloperUser;
use App\Database\MarketingUser;
use App\Http\Controllers\Controller;

class HomepageController extends Controller
{
  public function index( Request $request )
  {
    $data['request'] = $request;
    if( session()->has('isMarketing') )
    {
      $marketinguser = MarketingUser::where('mkt_user_id', session()->get('mkt_user_id'))
      ->select(
        'mkt_user_id',
        'mkt_username',
        'mkt_email',
        'mkt_password',
        'mkt_phone_number',
        'mkt_mobile_phone',
        'mkt_city',
        'mkt_region',
        'mkt_biography',
        'mkt_profile_photo'
      )
      ->first();
      $data['session_user'] = $marketinguser;
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

<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Database\MarketingUser;
use App\Http\Controllers\Controller;

class MarketingController extends Controller
{
  public function index( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];

      return response()->view('frontend.pages.marketing.dashboard_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function settings_page( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];

      return response()->view('frontend.pages.marketing.settings_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function profile_page( Request $request, MarketingUser $marketinguser )
  {
    if( session()->has('isMarketing') )
    {
      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo()
      ];

      return response()->view('frontend.pages.marketing.profile_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }
}

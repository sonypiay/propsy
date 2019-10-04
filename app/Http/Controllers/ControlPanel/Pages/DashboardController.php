<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;

class DashboardController extends Controller
{
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];
      return response()->view('controlpanel.pages.dashboard', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }
}

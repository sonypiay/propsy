<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\AdminOwner;
use App\Database\Customer;
use App\Database\DeveloperUser as Developer;
use App\Database\MarketingUser as Marketing;
use App\Database\ProjectRequest;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\ProvinceDB as Province;
use App\Database\CityDB as City;
use App\Http\Controllers\Controller;
use DB;

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

  public function stats_users()
  {
    $customer   = new Customer;
    $developer  = new Developer;
    $marketing  = new Marketing;

    $total_all_cust             = $customer->get();
    $total_verified_cust        = $customer->where('status_verification', 'Y')->get();
    $total_unverified_cust      = $customer->where('status_verification', 'N')->get();
    $cust_current_registered    = $customer->where( DB::raw('date_format(created_at, "%Y-%m-%d")'), '=', date('Y-m-d') )->get();

    $total_all_developer        = $developer->get();
    $total_verified_developer   = $developer->where('status_verification', 'Y')->get();
    $total_unverified_developer = $developer->where('status_verification', 'N')->get();
    $dev_current_registered     = $developer->where( DB::raw('date_format(created_at, "%Y-%m-%d")'), '=', date('Y-m-d') )->get();

    $total_all_marketing   = $marketing->get();

    $response = [
      'data' => [
        'customer' => [
          'all' => $total_all_cust->count(),
          'verified' => $total_verified_cust->count(),
          'unverified' => $total_unverified_cust->count(),
          'current_registered' => $cust_current_registered->count(),
        ],
        'developer' => [
          'all' => $total_all_developer->count(),
          'verified' => $total_verified_developer->count(),
          'unverified' => $total_unverified_developer->count(),
          'current_registered' => $dev_current_registered->count(),
        ],
        'marketing' => [
          'all' => $total_all_marketing->count(),
        ],
      ]
    ];

    return response()->json( $response, 200 );
  }

  public function stats_project()
  {
    $project_list = new ProjectList;
    $project_unit = new ProjectUnitType;

    $total_all_project_list = $project_list->get();
    $available_project_list = $project_list->where('project_status', 'available')->get();
    $soon_project_list      = $project_list->where('project_status', 'soon')->get();
    $sold_project_list      = $project_list->where('project_status', 'sold')->get();

    $total_all_unit = $project_unit->get();
    $available_unit = $project_unit->where('unit_status', 'available')->get();
    $sold_unit      = $project_unit->where('unit_status', 'sold')->get();
    $booked_unit    = $project_unit->where('unit_status', 'booked')->get();

    $response = [
      'data' => [
        'project' => [
          'all' => $total_all_project_list->count(),
          'available' => $available_project_list->count(),
          'soon' => $soon_project_list->count(),
          'sold' => $sold_project_list->count(),
        ],
        'unit' => [
          'all' => $total_all_unit->count(),
          'available' => $available_unit->count(),
          'sold' => $sold_unit->count(),
          'booked' => $booked_unit->count(),
        ],
      ]
    ];

    return response()->json( $response, 200 );
  }
}

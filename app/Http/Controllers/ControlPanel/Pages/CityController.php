<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\AdminOwner;
use App\Database\CityDB;
use App\Database\ProvinceDB;
use App\Http\Controllers\Controller;
use PDF;
use DB;

class CityController extends Controller
{
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];

      return response()->view('controlpanel.pages.wilayah.kota', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_city( Request $request, CityDB $city )
  {
    $keywords = $request->keywords;
    $limit = 10;
    $whereClause = [];

    $getcity = $city->select(
      'city.city_id',
      'city.city_name',
      'province.province_id',
      'province.province_name'
    )
    ->join('province', 'city.province_id', '=' ,'province.province_id')
    ->where('city_name', 'like', '%' . $keywords . '%')
    ->orWhere('province_name', 'like', '%' . $keywords . '%')
    ->orderBy('city.city_id', 'desc')
    ->paginate( $limit );

    return response()->json( $getcity, 200 );
  }

  public function store( Request $request, CityDB $city )
  {
    $city_id = $request->city_id;
    $city_name = $request->city_name;
    $province = $request->province;
    $check_city = $city->where('city_id', $city_id);

    if( $check_city->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $city_id . ' sudah digunakan.'
      ];
    }
    else
    {
      $city->city_name = $city_name;
      $city->city_id = $city_id;
      $city->province_id = $province;
      $city->save();
      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function save( Request $request, CityDB $city, $id )
  {
    $city_id = $request->city_id;
    $city_name = $request->city_name;
    $province = $request->province;
    $getcity = $city->where('city_id', $id)->first();

    $getcity->city_name = $city_name;
    $getcity->province_id = $province;

    if( $getcity->city_id !== $city_id )
    {
      $check_city = $city->where('city_id', $city_id)->count();
      if( $check_city > 0 )
      {
        $res = ['status' => 409, 'statusText' => $city_id . ' sudah digunakan.'];
      }
      else
      {
        $getcity->save();
        $res = ['status' => 200, 'statusText' => 'success'];
      }
    }
    else
    {
      $getcity->save();
      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function destroy( Request $request, CityDB $city, $id )
  {
    $getcity = $city->where('city_id', $id);
    $getcity->delete();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }

  public function save_report( Request $request, CityDB $city, $table )
  {
    if( $table === 'customer' )
    {
      $dbcount = 'count(customer.customer_id) as total_data';
      $getcity = $city->leftJoin('customer', 'city.city_id', '=', 'customer.city_id')
      ->orderBy(DB::raw('count(customer.customer_id)'), 'desc');
      $filename = 'DataCustomer';
    }
    else if( $table === 'developer' )
    {
      $dbcount = 'count(developer_user.dev_user_id) as total_data';
      $getcity = $city->leftJoin('developer_user', 'city.city_id', '=', 'developer_user.city_id')
      ->orderBy(DB::raw('count(developer_user.dev_user_id)'), 'desc');
      $filename = 'DataDeveloper';
    }
    else if( $table === 'project' )
    {
      $dbcount = 'count(project_list.project_id) as total_data';
      $getcity = $city->leftJoin('project_list', 'city.city_id', '=', 'project_list.city_id')
      ->orderBy(DB::raw('count(project_list.project_id)'), 'desc');
      $filename = 'DataProject';
    }
    else { abort(404); }

    $getcity = $getcity->select(
      'city.city_id',
      'city.city_name',
      DB::raw($dbcount)
    )
    ->groupBy('city.city_id')
    ->get();

    $filename = $filename . date('dmY') . '.pdf';
    $res = [
      'filename' => $filename,
      'result' => $getcity,
      'table' => $table
    ];

    //return response()->json( $res );
    return PDF::loadView('controlpanel.pages.reports.kota', $res)->setPaper('a4', 'portrait')->setWarnings(false)->stream( $filename );
  }
}

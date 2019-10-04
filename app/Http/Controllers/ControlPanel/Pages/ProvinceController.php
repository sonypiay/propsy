<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\ProvinceDB;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;

class ProvinceController extends Controller
{
  public function index( Request $request, AdminOwner $owner )
  {
    if( session()->has('isControlPanel') )
    {
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo()
      ];

      return respose()->view('controlpanel.pages.province', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_province( Request $request, ProvinceDB $province )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $whereClause = [];

    if( ! empty( $keywords ) )
    {
      array_push( $whereClause, ['province_name', 'like', '%' . $keywords . '%']);
    }

    $getprovince = $province->where($whereClause)
    ->orderBy('province_id', 'desc')
    ->paginate( $limit );

    return response()->json( $getprovince, 200 );
  }

  public function store( Request $request, ProvinceDB $province )
  {
    $province_name = $request->province_name;
    $slug_name = str_slug( $province_name );

    $province->province_name = $province_name;
    $province->province_slug = $slug_name;
    $province->save();

    $res = ['status' => 200, 'statusText' => 'success'];

    return response()->json( $res, 200 );
  }

  public function save( Request $request, ProvinceDB $province, $id )
  {
    $province_name = $request->province_name;

    $getprovince = $province->where('province_id', $id)->first();
    $getprovince->province_name = $province_name;
    $getprovince->province_slug = $slug_name;
    $getprovince->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }

  public function destroy( Request $request, ProvinceDB $province, $id )
  {
    $getprovince = $province->where('province_id', $id);
    $getprovince->delete();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, 200 );
  }
}

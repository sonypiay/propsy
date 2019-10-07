<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\UnitFacility;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;

class FacilityController extends Controller
{
  public function get_facility( Request $request, UnitFacility $unit_facility )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $getfacility = $unit_facility->orderBy('id_facility', 'desc');
    if( ! empty( $keywords ) )
    {
      $getfacility = $getfacility->where('facility_name', 'like', '%' . $keywords . '%');
    }

    $result = $getfacility->paginate( $limit );
    return response()->json( $result, 200 );
  }
  
  public function store( Request $request, UnitFacility $unit_facility )
  {
    $facility_name = $request->facility_name;
    $unit_facility->facility_name = $facility_name;
    $unit_facility->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function save( Request $request, UnitFacility $unit_facility, $id )
  {
    $facility_name = $request->facility_name;
    $getfacility = $unit_facility->where('id_facility', $id)->first();
    $unit_facility->facility_name = $facility_name;
    $unit_facility->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function destroy( UnitFacility $unit_facility, $id )
  {
    $getfacility = $unit_facility->where('id_facility', $id);
    $getfacility->delete();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

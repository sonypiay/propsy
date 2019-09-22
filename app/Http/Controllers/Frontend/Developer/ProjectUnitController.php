<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\ProjectUnitType;
use App\Database\ProjectUnitInstallment;

use App\Http\Controllers\Controller;

class ProjectUnitController extends Controller
{
  public function get_unit_tipe_project( Request $request, ProjectUnitType $unit_type, $project_id )
  {
    $keywords = $request->keywords;
    $unit = new $unit_type;
    if( empty( $keywords ) )
    {
      $query = $unit->where('project_unique_id', $project_id);
    }
    else
    {
      $query = $unit->where([
        ['project_unique_id', $project_id],
        ['project_unit_name', 'like', '%' . $keywords . '%']
      ]);
    }
    $result = $query->orderBy('created_at', 'desc')
    ->paginate( 5 );

    return response()->json( $result, 200 );
  }

  public function project_add_unit_tipe( Request $request, ProjectUnitType $unit_type, $unit_id )
  {
    $unit_floor = $request->unit_floor;
    $unit_lb = $request->unit_lb;
    $unit_lt = $request->unit_lt;
    $unit_km = $request->unit_km;
    $unit_kt = $request->unit_kt;
    $unit_price = $request->unit_price;

    $insert = new $unit_type;
    $insert->unit_floor = $unit_floor;
    $insert->unit_lb = $unit_lb;
    $insert->unit_lt = $unit_lt;
    $insert->unit_km = $unit_km;
    $insert->unit_kt = $unit_kt;
    $insert->unit_price = $unit_price;
    $insert->project_unit_id = $unit_id;
    $insert->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function project_save_unit_tipe( Request $request, ProjectUnitType $unit_type, $unit_tipe_id )
  {
    $unit_floor = $request->unit_floor;
    $unit_lb = $request->unit_lb;
    $unit_lt = $request->unit_lt;
    $unit_km = $request->unit_km;
    $unit_kt = $request->unit_kt;
    $unit_price = $request->unit_price;

    $insert = $unit_type->where('project_unit_type_id', $unit_tipe_id)->first();
    $insert->unit_floor = $unit_floor;
    $insert->unit_lb = $unit_lb;
    $insert->unit_lt = $unit_lt;
    $insert->unit_km = $unit_km;
    $insert->unit_kt = $unit_kt;
    $insert->unit_price = $unit_price;
    $insert->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function project_delete_unit_tipe( ProjectUnitType $unit_tipe, $id )
  {
    $unit = $unit_tipe->where('project_unit_type_id', $id);
    if( $unit->count() !== 0 )
    {
      $unit->delete();
    }
    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

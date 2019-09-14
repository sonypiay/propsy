<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\ProjectUnit;
use App\Database\ProjectUnitType;
use App\Database\ProjectUnitInstallment;

use App\Http\Controllers\Controller;

class ProjectUnitController extends Controller
{
  public function get_unit_project( Request $request, ProjectUnit $project_unit, $project_id )
  {
    $keywords = $request->keywords;
    $unit = $project_unit->select(
      'project_unit.project_unit_id',
      'project_unit.project_unit_name',
      'project_unit.project_unit_status',
      'project_unit.project_id',
      'project_unit.created_at',
      'project_unit.updated_at',
      DB::raw('count(project_unit_type.project_unit_id) as jumlah_tipe')
    )
    ->leftJoin('project_unit_type', 'project_unit.project_unit_id', '=', 'project_unit_type.project_unit_id');
    if( empty( $keywords ) )
    {
      $query = $unit->where('project_id', $project_id);
    }
    else
    {
      $query = $unit->where([
        ['project_id', $project_id],
        ['project_unit_name', 'like', '%' . $keywords . '%']
      ]);
    }
    $result = $query->groupBy('project_unit.project_unit_id')
    ->orderBy('project_unit.project_unit_id', 'desc')
    ->paginate( 5 );

    return response()->json( $result, 200 );
  }

  public function project_add_unit( Request $request, ProjectUnit $project_unit, $project_id )
  {
    $unit_name = $request->unit_name;
    $startRange = $request->startRange;
    $endRange = $request->endRange;
    $date = date('Y-m-d H:i:s');
    $unit = new $project_unit;
    $data = [];

    if( ! empty( $startRange ) AND ! empty( $endRange ) )
    {
      for( $i = $startRange; $i <= $endRange; $i++ )
      {
        $unit_slug = str_slug( $unit_name . $i );
        array_push( $data, [
          'project_unit_name' => $unit_name . $i,
          'project_unit_slug' => $unit_slug,
          'project_unit_status' => 'available',
          'project_id' => $project_id,
          'created_at' => $date,
          'updated_at' => $date
        ]);
      }
      $unit->insert($data);
    }
    else
    {
      $unit_slug = str_slug( $unit_name );
      $unit->project_unit_name = $unit_name;
      $unit->project_unit_slug = $unit_slug;
      $unit->project_id = $project_id;
      $unit->save();
    }

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function project_save_unit( Request $request, ProjectUnit $project_unit, $unit_id )
  {
    $unit_name = $request->unit_name;
    $unit_slug = str_slug( $unit_name );
    $unit = $project_unit->where('project_unit_id', $unit_id)->first();

    $unit->project_unit_name = $unit_name;
    $unit->project_unit_slug = $unit_slug;
    $unit->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function project_delete_unit( ProjectUnit $project_unit, $unit_id )
  {
    $unit = $project_unit->where('project_unit_id', $unit_id);
    if( $unit->count() !== 0 )
    {
      $unit->delete();
    }
    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function get_unit_tipe_project( Request $request, ProjectUnitType $unit_type, $unit_id )
  {
    $keywords = $request->keywords;
    $unit = new $unit_type;
    if( empty( $keywords ) )
    {
      $query = $unit->where('project_unit_id', $unit_id);
    }
    else
    {
      $query = $unit->where([
        ['project_unit_id', $project_id],
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

  public function get_installment_unit( Request $request, ProjectUnitInstallment $installment, $id )
  {
    $result = $installment->where('project_unit_type_id', $id)
    ->orderBy('created_at', 'desc');
    $res = [
      'total' => $result->count(),
      'data' => $result->get()
    ];
    return response()->json( $res, 200 );
  }

  public function add_installment_unit( Request $request, ProjectUnitInstallment $installment, $id )
  {
    $dp = $request->dp;
    $angsuran = $request->angsuran;
    $tenor = $request->tenor;
    $tenor_tahun = $tenor * 12;

    $installment->installment_dp = $dp;
    $installment->installment_price = $angsuran;
    $installment->installment_tenor = $tenor_tahun;
    $installment->project_unit_type_id = $id;
    $installment->save();

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function save_installment_unit( Request $request, ProjectUnitInstallment $installment, $id )
  {
    $dp = $request->dp;
    $angsuran = $request->angsuran;
    $tenor = $request->tenor;
    $tenor_tahun = $tenor * 12;

    $getinstallment = $installment->where('installment_id', $id)->first();
    $getinstallment->installment_dp = $dp;
    $getinstallment->installment_price = $angsuran;
    $getinstallment->installment_tenor = $tenor_tahun;
    $getinstallment->save();

    $res = ['status' => 200, 'statusText' => 'success', 'request' => $request->all() ];
    return response()->json( $res, $res['status'] );
  }

  public function delete_installment_unit( ProjectUnitInstallment $installment, $id )
  {
    $getinstallment = $installment->where('installment_id', $id);
    if( $getinstallment->count() !== 0 )
    {
      $getinstallment->delete();
    }
    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

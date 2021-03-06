<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\ProjectList;
use App\Database\ProjectUnitType;
use App\Database\ProjectUnitGallery;
use App\Database\UnitFacility;
use App\Database\PriceInstallment;

use App\Http\Controllers\Controller;

class ProjectUnitController extends Controller
{
  public function get_unit( Request $request, ProjectUnitType $unit_type, $project_id )
  {
    $keywords = $request->keywords;
    $unit = new $unit_type;
    if( empty( $keywords ) )
    {
      $query = $unit->where('project_id', $project_id);
    }
    else
    {
      $query = $unit->where([
        ['project_id', $project_id],
        ['unit_name', 'like', '%' . $keywords . '%']
      ]);
    }

    $result = $query->orderBy('created_at', 'desc')
    ->paginate( 6 );

    return response()->json( $result, 200 );
  }

  public function add_unit_page( Request $request, DeveloperUser $developeruser, UnitFacility $unitfacility, ProjectList $project_list, $project_id )
  {
    if( session()->has('isDeveloper') )
    {
      $getproject = $project_list->select(
        'project_id',
        'project_name',
        'project_type'
      )
      ->where('project_id', $project_id)->first();

      if( ! $getproject ) abort(404);

      $getfacility = $unitfacility->orderBy('facility_name', 'asc')->get();

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'project_id' => $project_id,
        'getfacility' => $getfacility,
        'getproject' => $getproject,
        'hasrequest' => $developeruser->hasrequest()
      ];

      return response()->view('frontend.pages.developer.add_unit', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function add_unit( Request $request, ProjectUnitType $unit_type, $project_id )
  {
    $unit_name = $request->unit_name;
    $unit_slug = str_slug( $unit_name );
    $unit_description = $request->unit_description;
    $unit_floor = $request->unit_floor;
    $unit_lb = $request->unit_lb;
    $unit_lt = $request->unit_lt;
    $unit_km = $request->unit_km;
    $unit_kt = $request->unit_kt;
    $unit_price = $request->unit_price;
    $unit_status = $request->unit_status;
    $unit_watt = $request->unit_watt;
    $unit_facility = implode( ',', $request->unit_facility );

    $insert = new $unit_type;
    $insert->unit_type_id = $unit_type->generateId();
    $insert->unit_name = $unit_name;
    $insert->unit_slug = $unit_slug;
    $insert->unit_description = $unit_description;
    $insert->unit_floor = $unit_floor;
    $insert->unit_lb = $unit_lb;
    $insert->unit_lt = $unit_lt;
    $insert->unit_km = $unit_km;
    $insert->unit_kt = $unit_kt;
    $insert->unit_price = $unit_price;
    $insert->unit_status = $unit_status;
    $insert->unit_watt = $unit_watt;
    $insert->unit_facility = $unit_facility;
    $insert->project_id = $project_id;
    $insert->save();

    $res = ['status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function edit_unit_page( Request $request, DeveloperUser $developeruser, ProjectUnitType $unit_type, UnitFacility $unitfacility, ProjectList $project_list, $unit_id )
  {
    if( session()->has('isDeveloper') )
    {
      $getunit = $unit_type->where('unit_type_id', $unit_id)
      ->first();
      if( ! $getunit ) abort( 404 );

      $getproject = $project_list->select(
        'project_id',
        'project_name',
        'project_type'
      )
      ->where('project_id', $getunit->project_id)->first();

      if( ! $getproject ) abort(404);

      $getfacility = $unitfacility->orderBy('facility_name', 'asc')->get();

      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo(),
        'getunit' => $getunit,
        'getfacility' => $getfacility,
        'getproject' => $getproject,
        'hasrequest' => $developeruser->hasrequest()
      ];

      return response()->view('frontend.pages.developer.edit_unit', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function save_unit( Request $request, ProjectUnitType $unit_type, $unit_id )
  {
    $unit_name = $request->unit_name;
    $unit_slug = str_slug( $unit_name );
    $unit_description = $request->unit_description;
    $unit_floor = $request->unit_floor;
    $unit_lb = $request->unit_lb;
    $unit_lt = $request->unit_lt;
    $unit_km = $request->unit_km;
    $unit_kt = $request->unit_kt;
    $unit_price = $request->unit_price;
    $unit_status = $request->unit_status;
    $unit_watt = $request->unit_watt;
    $unit_facility = implode( ',', $request->unit_facility );

    $update = $unit_type->where('unit_type_id', $unit_id)->first();
    $update->unit_name = $unit_name;
    $update->unit_slug = $unit_slug;
    $update->unit_description = $unit_description;
    $update->unit_floor = $unit_floor;
    $update->unit_lb = $unit_lb;
    $update->unit_lt = $unit_lt;
    $update->unit_km = $unit_km;
    $update->unit_kt = $unit_kt;
    $update->unit_price = $unit_price;
    $update->unit_status = $unit_status;
    $update->unit_watt = $unit_watt;
    $update->unit_facility = $unit_facility;
    $update->save();

    $res = ['status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function delete_unit_tipe( ProjectUnitType $unit_tipe, ProjectUnitGallery $unit_gallery, $id )
  {
    $unit = $unit_tipe->where('unit_type_id', $id);
    $storage = Storage::disk('assets');
    $imagepath = 'images/project/gallery';
    if( $unit->count() !== 0 )
    {
      $result = $unit->first();
      $gallery = $unit_gallery->where('unit_type_id', $result->unit_type_id);
      if( $gallery->count() !== 0 )
      {
        foreach( $gallery->get() as $g )
        {
          if( $storage->exists( $imagepath . '/' . $g->unit_gallery_filename ) )
          {
            $storage->delete( $imagepath . '/' . $g->unit_gallery_filename );
          }
        }
      }

      $gallery->delete();
      $unit->delete();
    }
    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function upload_gallery_unit( Request $request, ProjectUnitGallery $unit_gallery, $id )
  {
    $images = $request->images;
    $gallery = new $unit_gallery;
    $data_images = [];
    $storage = Storage::disk('assets');
    $imagepath = 'images/project/gallery';

    foreach( $images as $img )
    {
      $filename = 'unit-' . $img->hashName();
      array_push( $data_images, [
        'unit_gallery_filename' => $filename,
        'unit_type_id' => $id
      ]);
      $storage->putFileAs( $imagepath, $img, $filename );
    }

    $gallery->insert( $data_images );

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }

  public function get_gallery_unit( Request $request, ProjectUnitGallery $unit_gallery, $id )
  {
    $gallery = $unit_gallery->where('unit_type_id', $id)
    ->orderBy('unit_gallery_id', 'desc')->get();

    $res = [
      'results' => [
        'data' => $gallery,
        'total' => $gallery->count()
      ]
    ];

    return response()->json( $res, 200 );
  }

  public function gallery_set_thumbnail( ProjectUnitGallery $unit_gallery, ProjectUnitType $unit_type, $id )
  {
    $gallery = $unit_gallery->where('unit_gallery_id', $id)
    ->first();
    $getunit = $unit_type->where('unit_type_id', $gallery->unit_type_id)
    ->first();

    $getunit->unit_thumbnail = $gallery->unit_gallery_filename;
    $getunit->save();

    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function delete_gallery_unit( ProjectUnitGallery $unit_gallery, ProjectUnitType $unit_type, $id )
  {
    $storage = Storage::disk('assets');
    $imagepath = 'images/project/gallery';

    $gallery = $unit_gallery->where('unit_gallery_id', $id)
    ->first();
    $getunit = $unit_type->where('unit_type_id', $gallery->unit_type_id)
    ->first();

    if( $storage->exists( $imagepath . '/' . $gallery->unit_gallery_filename ) )
    {
      $storage->delete( $imagepath . '/' . $gallery->unit_gallery_filename );

      if( $getunit->unit_thumbnail == $gallery->unit_gallery_filename )
      {
        $getunit->unit_thumbnail = null;
        $getunit->save();
      }

      $gallery->delete();
    }
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function get_installment( PriceInstallment $installment, $unit_id )
  {
    $getinstallment = $installment->where('unit_type_id', $unit_id)->get();

    $res = [
      'results' => [
        'data' => $getinstallment,
        'total' => $getinstallment->count()
      ]
    ];

    return response( $res );
  }

  public function add_installment( Request $request, PriceInstallment $installment )
  {
    $dp = $request->dp;
    $cicilan = $request->cicilan;
    $tenor = $request->tenor;
    $unit_id = $request->unit_id;

    $data = [
      'unit_id' => $unit_id,
      'dp' => $dp,
      'cicilan' => $cicilan,
      'tenor' => $tenor
    ];

    $installment->store_cicilan( $data );
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function save_installment( Request $request, PriceInstallment $installment, $id )
  {
    $dp = $request->dp;
    $cicilan = $request->cicilan;
    $tenor = $request->tenor;
    $unit_id = $request->unit_id;

    $data = [
      'unit_id' => $unit_id,
      'dp' => $dp,
      'cicilan' => $cicilan,
      'tenor' => $tenor
    ];

    $installment->save_cicilan( $data, $id );
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }

  public function delete_installment( PriceInstallment $installment, $id )
  {
    $installment->delete_cicilan( $id );
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }
}

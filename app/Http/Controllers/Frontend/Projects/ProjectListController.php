<?php

namespace App\Http\Controllers\Frontend\Projects;

use Illuminate\Http\Request;
use App\Database\ProjectList;
use App\Database\ProjectGallery;
use App\Database\ProjectUnitGallery;
use App\Database\ProjectUnitType;
use App\Database\ProjectRequest;
use App\Database\LogProjectRequest;
use App\Database\Customer;
use App\Database\MarketingUser;
use App\Database\DeveloperUser;
use App\Database\CityDB;
use App\Database\UnitFacility;
use App\Database\PriceInstallment;
use App\Http\Controllers\Controller;
use DB;

class ProjectListController extends Controller
{
  public function homepage_available_project( Request $request, ProjectList $project_list )
  {
    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_status',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_description',
      'project_list.project_estimate_launch',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'city.city_name',
      'province.province_name',
      DB::raw('min(project_unit_type.unit_price) as unit_price'),
      DB::raw('min(project_unit_type.unit_lb) as unit_lb')
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_id', '=', 'project_unit_type.project_id')
    ->orderBy('project_list.created_at', 'desc')
    ->groupBy('project_list.project_id')
    ->take(9)
    ->get();
    $res = [
      'results' => [
        'total' => $getproject->count(),
        'data' => $getproject
      ]
    ];
    return response()->json($res, 200 );
  }

  public function homepage_available_unit( Request $request, ProjectUnitType $unit_type )
  {
    $getunit  = $unit_type->select(
      'project_unit_type.unit_name',
      'project_unit_type.unit_slug',
      'project_unit_type.unit_price',
      'project_unit_type.unit_floor',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_unit_type.unit_lb',
      'project_unit_type.unit_price',
      'project_unit_type.unit_status',
      'project_unit_type.unit_thumbnail',
      'project_unit_type.unit_facility',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_type',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'city.city_name',
      'province.province_name'
    )
    ->join('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('project_unit_type.created_at', 'desc')
    ->take(9)
    ->get();

    $res = [
      'results' => [
        'data' => $getunit,
        'total' => $getunit->count()
      ]
    ];
    return response()->json( $res, 200 );
  }

  public function view_project( Request $request, ProjectList $project_list, ProjectGallery $project_gallery, ProjectUnitType $unit_type, $slug )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    $data['session_active'] = null;
    $data['hasrequest'] = 0;

    if( session()->has('isCustomer') )
    {
      $customer = new Customer;
      $data['session_active'] = 'customer';
      $data['session_user'] = $customer->getinfo();
      $data['hasrequest'] = $customer->hasRequest();
    }
    else if( session()->has('isDeveloper') )
    {
      $developer = new DeveloperUser;
      $data['session_active'] = 'developer';
      $data['session_user'] = $developer->getinfo();
    }
    else
    {
      $marketing = new MarketingUser;
      $data['session_active'] = 'marketing';
      $data['session_user'] = $marketing->getinfo();
    }

    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_description',
      'project_list.project_status',
      'project_list.project_address',
      'project_list.project_link_map',
      'project_list.project_map_embed',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'project_list.created_at',
      'project_list.updated_at',
      'city.city_id',
      'city.city_name',
      'developer_user.dev_user_id',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'developer_user.dev_logo',
      'developer_user.dev_phone_office',
      'developer_user.dev_mobile_phone'
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->where('project_list.project_slug', $slug)
    ->first();

    if( ! $getproject ) abort(404);

    $getgallery = $project_gallery->where('project_id', $getproject->project_id)
    ->orderBy('gallery_id', 'desc')
    ->get();

    $getunit_price = $unit_type->where('project_id', $getproject->project_id)
    ->orderBy('unit_price', 'asc')
    ->first();

    $data['getproject'] = $getproject;
    $data['getgallery'] = $getgallery;
    $data['getunit_price'] = $getunit_price;

    return response()->view('frontend.pages.view_project', $data);
  }

  public function detail_unit( Request $request, ProjectUnitGallery $project_gallery, ProjectUnitType $unit_type, Customer $customer, DeveloperUser $developer, MarketingUser $marketing, $slug )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    $data['session_active'] = null;
    $data['hasrequest'] = 0;

    if( session()->has('isCustomer') )
    {
      $data['session_active'] = 'customer';
      $data['session_user'] = $customer->getinfo();
      $data['hasrequest'] = $customer->hasRequest();
    }
    else if( session()->has('isDeveloper') )
    {
      $data['session_active'] = 'developer';
      $data['session_user'] = $developer->getinfo();
    }
    else
    {
      $marketing = new MarketingUser;
      $data['session_user'] = $marketing->getinfo();
    }

    $getunit  = $unit_type->select(
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_slug',
      'project_unit_type.unit_floor',
      'project_unit_type.unit_lb',
      'project_unit_type.unit_lt',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_unit_type.unit_price',
      'project_unit_type.unit_description',
      'project_unit_type.unit_status',
      'project_unit_type.unit_watt',
      'project_unit_type.unit_facility',
      'project_unit_type.unit_thumbnail',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_description',
      'project_list.project_address',
      'project_list.project_map_embed',
      'developer_user.dev_user_id',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'developer_user.dev_logo',
      'developer_user.dev_biography',
      'developer_user.dev_phone_office',
      'developer_user.dev_mobile_phone',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->join('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->where('project_unit_type.unit_slug', $slug)
    ->first();

    if( ! $getunit ) abort(404);

    $getgallery = $project_gallery->where('unit_type_id', $getunit->unit_type_id)
    ->orderBy('unit_gallery_id', 'desc')
    ->get();

    $data['getunit'] = $getunit;
    $data['getgallery'] = $getgallery;

    return response()->view('frontend.pages.detail_unit', $data);
  }

  public function list_project_unit( Request $request, ProjectUnitType $project_unit, $project_id )
  {
    $getunit = $project_unit->where('project_unit_type.project_id', $project_id)
    ->orderBy('project_unit_type.created_at', 'desc')
    ->paginate( 10 );

    $res = [
      'results' => $getunit,
      'project_id' => $project_id
    ];
    return response()->json( $res, 200 );
  }

  public function request_unit( Request $request, ProjectRequest $project_request, ProjectUnitType $unit_type, LogProjectRequest $log_request, Customer $customer, $unit_id )
  {
    $message = $request->message;
    $dev_user = $request->dev_user;
    $selectinstallment = $request->selectinstallment;
    $getcustomer = $customer->getinfo();
    $getunit = $unit_type->where('unit_type_id', $unit_id)->first();

    if( $getunit->unit_status === 'booked' )
    {
      $res = [
        'status' => 409,
        'statusText' => 'Maaf, unit ini sudah dipesan'
      ];
    }
    else if( $getunit->unit_status === 'sold' )
    {
      $res = [
        'status' => 409,
        'statusText' => 'Maaf, unit ini sudah terjual'
      ];
    }
    else
    {
      $get_last_id = $project_request->select('request_id')->orderBy('request_id', 'desc')->first();
      $generate_request_id = $project_request->generateId();
      $data_log = [
        'message' => $getcustomer->customer_name . ' mengajukan pemesanan unit ' . $getunit->unit_name,
        'request_id' => $generate_request_id
      ];

      $insert_request = new $project_request;
      $insert_request->request_id = $generate_request_id;
      $insert_request->dev_user_id = $dev_user;
      $insert_request->customer_id = $getcustomer->customer_id;
      $insert_request->unit_type_id = $unit_id;
      $insert_request->installment = $selectinstallment;
      $insert_request->request_message = $message;
      $insert_request->save();

      $getunit->unit_status = 'booked';
      $getunit->save();

      $log_request->insert_log($data_log);

      $res = [
        'status' => 200,
        'statusText' => 'success'
      ];
    }

    return response()->json( $res, $res['status'] );
  }

  public function browse_project_page( Request $request )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    $data['session_active'] = null;
    $data['hasrequest'] = 0;

    if( session()->has('isCustomer') )
    {
      $customer = new Customer;
      $data['session_active'] = 'customer';
      $data['session_user'] = $customer->getinfo();
      $data['hasrequest'] = $customer->hasRequest();
    }
    else if( session()->has('isDeveloper') )
    {
      $developer = new DeveloperUser;
      $data['session_active'] = 'developer';
      $data['session_user'] = $developer->getinfo();
    }
    else
    {
      $marketing = new MarketingUser;
      $data['session_active'] = 'marketing';
      $data['session_user'] = $marketing->getinfo();
    }

    $city = new CityDB;
    $getcity = $city->getcity();

    $data['getcity'] = $getcity;

    return response()->view('frontend.pages.browse_project', $data);
  }

  public function browse_project( Request $request, ProjectList $project_list )
  {
    $keywords = $request->keywords;
    $project_type = $request->type;
    $filtercity = $request->filtercity;

    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_status',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'city.city_name',
      'province.province_name',
      DB::raw('min(project_unit_type.unit_price) as unit_price'),
      DB::raw('min(project_unit_type.unit_lb) as unit_lb')
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_id', '=', 'project_unit_type.project_id');

    if( empty( $keywords ) )
    {
      if( $project_type === 'all' && $filtercity === 'all' )
      {
        $query = $getproject->orderBy('project_list.created_at', 'desc');
      }
      else if( $project_type !== 'all' && $filtercity === 'all' )
      {
        $query = $getproject->where('project_list.project_type', '=', $project_type)
        ->orderBy('project_list.created_at', 'desc');
      }
      else if( $project_type === 'all' && $filtercity !== 'all' )
      {
        $query = $getproject->where('project_list.city_id', '=', $filtercity)
        ->orderBy('project_list.created_at', 'desc');
      }
      else
      {
        $query = $getproject->where([
          ['project_list.project_type', '=', $project_type],
          ['project_list.city_id', '=', $filtercity]
        ])
        ->orderBy('project_list.created_at', 'desc');
      }
    }
    else
    {
      if( $project_type === 'all' && $filtercity === 'all' )
      {
        $query = $getproject->where('project_list.project_name', 'like', '%' . $keywords . '%')
        ->orWhere('developer_user.dev_name', 'like', '%' . $keywords . '%')
        ->orderBy('project_list.created_at', 'desc');
      }
      else if( $project_type !== 'all' && $filtercity === 'all' )
      {
        $query = $getproject->where([
          ['project_list.project_type', '=', $project_type],
          ['project_list.project_name', 'like', '%' . $keywords . '%']
        ])
        ->orWhere([
          ['project_list.project_type', '=', $project_type],
          ['developer_user.dev_name', 'like', '%' . $keywords . '%']
        ])
        ->orderBy('project_list.created_at', 'desc');
      }
      else if( $project_type === 'all' && $filtercity !== 'all' )
      {
        $query = $getproject->where([
          ['project_list.city_id', '=', $filtercity],
          ['project_list.project_name', 'like', '%' . $keywords . '%']
        ])
        ->orWhere([
          ['project_list.city_id', '=', $filtercity],
          ['developer_user.dev_name', 'like', '%' . $keywords . '%']
        ])
        ->orderBy('project_list.created_at', 'desc');
      }
      else
      {
        $query = $getproject->where([
          ['project_list.city_id', '=', $filtercity],
          ['project_list.project_type', '=', $project_type],
          ['project_list.project_name', 'like', '%' . $keywords . '%']
        ])
        ->orWhere([
          ['project_list.city_id', '=', $filtercity],
          ['project_list.project_type', '=', $project_type],
          ['developer_user.dev_name', 'like', '%' . $keywords . '%']
        ])
        ->orderBy('project_list.created_at', 'desc');
      }
    }

    $result = $query->orderBy('project_list.created_at', 'desc')
    ->groupBy('project_list.project_id')
    ->paginate( 10 );

    $results = [
      'results' => $result
    ];
    return response()->json( $results, 200 );
  }

  public function search_project( Request $request, Customer $customer, MarketingUser $marketing, DeveloperUser $developer )
  {
    $data['request'] = $request;
    $data['session_user'] = null;
    $data['session_active'] = null;
    $data['hasrequest'] = 0;

    if( session()->has('isCustomer') )
    {
      $data['session_active'] = 'customer';
      $data['session_user'] = $customer->getinfo();
      $data['hasrequest'] = $customer->hasRequest();
    }
    else if( session()->has('isDeveloper') )
    {
      $data['session_active'] = 'developer';
      $data['session_user'] = $developer->getinfo();
      $data['hasrequest'] = $developer->hasRequest();
    }
    else
    {
      $data['session_active'] = 'marketing';
      $data['session_user'] = $marketing->getinfo();
    }

    $city = new CityDB;
    $getcity = $city->orderBy('city_name', 'asc')->get();
    $data['getcity'] = $getcity;

    $unit_facility = new UnitFacility;
    $getfacility = $unit_facility->orderBy('facility_name', 'asc')->get();
    $data['getfacility'] = $getfacility;

    return response()->view('frontend.pages.search_project', $data);
  }

  public function get_search_list( Request $request, ProjectUnitType $unit_type )
  {
    $keywords = $request->keywords;
    $type = $request->type;
    $filtercity = $request->filtercity;
    $price_min = $request->price_min;
    $price_max = $request->price_max;
    $facility = empty( $request->facility ) ? [] : explode(',', $request->facility);

    $getunit  = $unit_type->select(
      'project_unit_type.unit_name',
      'project_unit_type.unit_slug',
      'project_unit_type.unit_price',
      'project_unit_type.unit_floor',
      'project_unit_type.unit_kt',
      'project_unit_type.unit_km',
      'project_unit_type.unit_lb',
      'project_unit_type.unit_price',
      'project_unit_type.unit_status',
      'project_unit_type.unit_thumbnail',
      'project_unit_type.unit_facility',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_type',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'city.city_name',
      'province.province_name'
    )
    ->join('project_list', 'project_unit_type.project_id', '=', 'project_list.project_id')
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id');

    $whereClause = [];
    $orWhereClause = [];
    $whereSearch = [];
    $hasFilter = false;

    if( $type !== 'all')
    {
      array_push( $whereClause, [ 'project_list.project_type','=', $type ]);
      $hasFilter = true;
    }
    if( $filtercity !== 'all' )
    {
      array_push( $whereClause, [ 'project_list.city_id', '=', $filtercity ]);
      $hasFilter = true;
    }

    $result = $getunit->where($whereClause)
    ->where(function( $query ) use ($keywords) {
      $query->where('project_unit_type.unit_name', 'like', '%' . $keywords . '%')
      ->orWhere('project_list.project_name', 'like', '%' . $keywords . '%')
      ->orWhere('developer_user.dev_name', 'like', '%' . $keywords . '%');
    });
    if( ! empty( $price_min ) && ! empty( $price_max ) )
    {
      $result = $result->whereBetween('project_unit_type.unit_price', [$price_min, $price_max]);
    }

    if( count( $facility ) != 0 )
    {
      foreach( $facility as $key => $val )
      {
        if( $key === 0 )
        {
          $result = $result->where(function($query) use ($val){
            $query->where('project_unit_type.unit_facility', 'like', '%' . $val . '%');
          });
        }
        else
        {
          $result = $result->orWhere(function($query) use ($val){
            $query->where('project_unit_type.unit_facility', 'like', '%' . $val . '%');
          });
        }
      }
    }

    $result = $result->orderBy( 'project_unit_type.created_at', 'desc' )
    ->paginate( 12 );
    $res = [
      'results' => $result
    ];

    return response()->json( $res, 200 );
  }

  public function project_developer( ProjectList $project_list, $slug )
  {
    $getproject  = $project_list->select(
      'project_list.project_id',
      'project_list.project_name',
      'project_list.project_slug',
      'project_list.project_thumbnail',
      'project_list.project_status',
      'project_list.project_type',
      'project_list.project_status',
      'project_list.project_estimate_launch',
      'developer_user.dev_name',
      'developer_user.dev_slug',
      'city.city_name',
      'province.province_name',
      'project_unit_type.unit_price',
      'project_unit_type.unit_lb'
    )
    ->join('developer_user', 'project_list.dev_user_id', '=', 'developer_user.dev_user_id')
    ->join('city', 'project_list.city_id', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->leftJoin('project_unit_type', 'project_list.project_id', '=', 'project_unit_type.project_id')
    ->where('developer_user.dev_slug', $slug)
    ->orderBy('project_unit_type.unit_price', 'asc')
    ->orderBy('project_unit_type.unit_lb', 'asc')
    ->groupBy('project_list.project_id')
    ->get();

    $result = [
      'result' => [
        'data' => $getproject,
        'total' => $getproject->count()
      ]
    ];

    return response()->json( $result );
  }

  public function marketing_developer( MarketingUser $marketing, $id )
  {
    $getmarketing = $marketing->select(
      'marketing_user.mkt_fullname',
      'marketing_user.mkt_email',
      'marketing_user.mkt_phone_number',
      'marketing_user.mkt_mobile_phone',
      'marketing_user.mkt_address',
      'marketing_user.mkt_profile_photo',
      'marketing_user.city_id',
      'marketing_user.created_at',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'marketing_user.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->where('marketing_user.dev_user_id', $id)
    ->get();

    $result = [
      'result' => [
        'data' => $getmarketing,
        'total' => $getmarketing->count()
      ]
    ];
    return response()->json( $result );
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
    return response( $res, 200 );
  }
}

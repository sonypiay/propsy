<?php

namespace App\Http\Controllers\ControlPanel\Pages;

use Illuminate\Http\Request;
use App\Database\Customer;
use App\Database\CityDB;
use App\Database\AdminOwner;
use App\Http\Controllers\Controller;
use PDF;

class CustomerController extends Controller
{
  public function index( Request $request, AdminOwner $owner, CityDB $city )
  {
    if( session()->has('isControlPanel') )
    {
      $getcity = $city->orderBy('city_name', 'asc')->get();
      $data = [
        'request' => $request,
        'session_user' => $owner->getinfo(),
        'getcity' => $getcity
      ];
      return response()->view('controlpanel.pages.customer.customer', $data);
    }
    else
    {
      return redirect()->route('cp_login_page');
    }
  }

  public function get_customer( Request $request, Customer $customer )
  {
    $keywords = $request->keywords;
    $city = $request->city;
    $status = $request->status;
    $limit = isset( $request->limit ) ? $request->limit : 10;

    $getcustomer = $customer->select(
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_address',
      'customer.customer_phone_number',
      'customer.customer_username',
      'customer.customer_password',
      'customer.customer_photo',
      'customer.status_verification',
      'customer.created_at',
      'customer.updated_at',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'customer.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('customer.created_at', 'desc');

    if( $city !== 'all' )
    {
      $getcustomer = $getcustomer->where('city.city_id', '=', $city);
    }

    if( $status !== 'all' )
    {
      $getcustomer = $getcustomer->where('customer.status_verification', $status);
    }

    if( ! empty( $keywords ) )
    {
      $getcustomer = $getcustomer->where(function($query) use ($keywords){
        $query->where('customer.customer_name', 'like', '%' . $keywords . '%')
        ->orWhere('customer.customer_email', 'like', '%' . $keywords . '%')
        ->orWhere('customer.customer_phone_number', 'like', '%' . $keywords . '%');
      });
    }
    $result = $getcustomer->paginate( $limit );

    return response()->json( $result, 200 );
  }

  public function save_report( Request $request, Customer $customer )
  {
    $city = $request->city;
    $status = $request->status;

    $getcustomer = $customer->select(
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_address',
      'customer.customer_phone_number',
      'customer.customer_username',
      'customer.customer_password',
      'customer.customer_photo',
      'customer.status_verification',
      'customer.created_at',
      'customer.updated_at',
      'city.city_id',
      'city.city_name',
      'province.province_name'
    )
    ->leftJoin('city', 'customer.city_id', '=', 'city.city_id')
    ->leftJoin('province', 'city.province_id', '=', 'province.province_id')
    ->orderBy('customer.created_at', 'desc');
    $getcity = '';

    if( $city !== 'all' )
    {
      $getcustomer = $getcustomer->where('city.city_id', '=', $city);
      $getcity = CityDB::where('city_id', $city)->first();
    }

    if( $status !== 'all' )
    {
      $getcustomer = $getcustomer->where('customer.status_verification', $status);
    }

    $filename = 'CustomerUser-' . date('dmY') . '.pdf';
    $res = [
      'filename' => $filename,
      'result' => $getcustomer->get(),
      'getcity' => $getcity
    ];
    return PDF::loadView('controlpanel.pages.reports.customer', $res)->setPaper('a4', 'landscape')->setWarnings(false)->stream( $filename );
  }
}

<?php

namespace App\Http\Controllers\Frontend\Marketing;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\MarketingUser;
use App\Database\ProjectRequest;
use App\Database\Customer;
use App\Http\Controllers\Controller;

class RequestUnitController extends Controller
{
  public function customer_request_unit( Request $request, MarketingUser $marketinguser, ProjectRequest $project_request )
  {
    if( session()->has('isMarketing') )
    {
      $getmarketing = $marketinguser->getinfo();
      $has_request = $project_request->hasNewRequest( $getmarketing->dev_user_id );

      $data = [
        'request' => $request,
        'session_user' => $marketinguser->getinfo(),
        'hasRequest' => $has_request
      ];
      return response()->view('frontend.pages.marketing.request_unit', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function get_request_unit( Request $request, ProjectRequest $project_request, MarketingUser $marketinguser )
  {
    $keywords = $request->keywords;
    $limit = $request->limit;
    $status_request = $request->status_request;
    $mktuser = $marketinguser->getinfo();

    $query = $project_request->select(
      'project_request.request_unique_id',
      'project_request.request_message',
      'project_request.status_request',
      'project_request.request_note',
      'project_request.created_at',
      'project_request.updated_at',
      'customer.customer_id',
      'customer.customer_name',
      'customer.customer_email',
      'customer.customer_phone_number',
      'project_unit_type.unit_type_id',
      'project_unit_type.unit_name',
      'project_unit_type.unit_price',
      'city.city_name',
      'province.province_name'
    )
    ->join('customer', 'project_request.customer_id', '=', 'customer.customer_id')
    ->join('city', 'customer.customer_city', '=', 'city.city_id')
    ->join('province', 'city.province_id', '=', 'province.province_id')
    ->join('project_unit_type', 'project_request.unit_type_id', '=', 'project_unit_type.unit_type_id');

    if( empty( $keywords ) )
    {
      $result = $query->where([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['project_request.status_request', '!=', 'done']
      ]);

      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }
    else
    {
      $result = $query->where([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['customer.customer_name', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orWhere([
        ['project_request.dev_user_id', $mktuser->dev_user_id],
        ['customer.customer_phone_number', 'like', '%' . $keywords . '%'],
        ['project_request.status_request', '!=', 'done']
      ])
      ->orderBy('project_request.created_at', 'desc');
      if( $status_request !== 'all' )
      {
        $result = $query->where([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['customer.customer_name', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orWhere([
          ['project_request.dev_user_id', $mktuser->dev_user_id],
          ['customer.customer_email', 'like', '%' . $keywords . '%'],
          ['project_request.status_request', $status_request]
        ])
        ->orderBy('project_request.created_at', 'desc');
      }
    }

    $getresult = $result->paginate( $limit );

    $res = [
      'results' => $getresult
    ];
    return response()->json( $res, 200 );
  }

  public function get_detail_request( ProjectRequest $project_request, MarketingUser $marketinguser, $reqid )
  {
    
  }
}

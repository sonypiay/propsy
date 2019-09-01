<?php

namespace App\Http\Controllers\Frontend\Developer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\DeveloperUser;
use App\Database\ProjectList;
use App\Http\Controllers\Controller;

class DeveloperController extends Controller
{
  public function index( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo()
      ];

      return response()->view('frontend.pages.developer.dashboard_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function profile_page( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo()
      ];

      return response()->view('frontend.pages.developer.profile_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function change_account_information( Request $request, DeveloperUser $developeruser )
  {
    $name = $request->name;
    $ownername = $request->ownername;
    $ownership = $request->ownership;
    $phone_office = $request->phone_office;
    $mobile_phone = $request->mobile_phone;
    $city = $request->city;
    $region = $request->region;
    $biography = $request->biography;
    $address = $request->address;
    $username = $request->username;
    $getinfo = $developeruser->getinfo();
    if( $getinfo->dev_username === $username )
    {
      $getinfo->dev_name = $name;
      $getinfo->dev_ownername = $ownername;
      $getinfo->dev_phone_office = $phone_office;
      $getinfo->dev_mobile_phone = $mobile_phone;
      $getinfo->dev_city = $city;
      $getinfo->dev_region = $region;
      $getinfo->dev_biography = $biography;
      $getinfo->dev_address = $address;
      $getinfo->dev_ownership = $ownership;
      $getinfo->save();

      $res = [ 'status' => 200, 'statusText' => 'success' ];
    }
    else
    {
      $check_username = $developeruser->where('dev_username', $username)->count();
      if( $check_username > 0 )
      {
        $res = [ 'status' => 409, 'statusText' => $username . ' sudah digunakan' ];
      }
      else
      {
        $getinfo->dev_name = $name;
        $getinfo->dev_ownername = $ownername;
        $getinfo->dev_phone_office = $phone_office;
        $getinfo->dev_mobile_phone = $mobile_phone;
        $getinfo->dev_city = $city;
        $getinfo->dev_region = $region;
        $getinfo->dev_biography = $biography;
        $getinfo->dev_address = $address;
        $getinfo->dev_ownership = $ownership;
        $getinfo->dev_username = $username;
        $getinfo->save();
        $res = [ 'status' => 200, 'statusText' => 'success' ];
      }
    }
    return response()->json( $res, $res['status'] );
  }

  public function change_password( Request $request, DeveloperUser $developeruser )
  {
    $password = $request->password;
    $hash_password = md5( $password );
    $getinfo = $developeruser->getinfo();
    $getinfo->dev_password = $hash_password;
    $getinfo->save();

    return response()->json([ 'status' => 200, 'statusText' => 'success' ], 200);
  }

  public function change_email( Request $request, DeveloperUser $developeruser )
  {
    $email = $request->email;
    $getinfo = $developeruser->getinfo();
    $check_email = $developeruser->where('dev_email', $email);

    if( $getinfo->dev_email !== $email )
    {
      if( $check_email->count() > 0 )
      {
        $res = [ 'status' => 409, 'statusText' => $email . ' sudah digunakan.' ];
      }
      else
      {
        $getinfo->dev_email = $email;
        $getinfo->save();
        $res = [ 'status' => 200, 'statusText' => 'success' ];
      }
    }
    else
    {
      $res = [ 'status' => 200, 'statusText' => 'success' ];
    }

    return response()->json( $res, $res['status'] );
  }

  public function upload_logo( Request $request, DeveloperUser $developeruser )
  {
    $logo_brand = $request->logo_brand;
    $filename = $logo_brand->hashName();
    $storage = Storage::disk('assets');
    $getinfo = $developeruser->getinfo();
    $path_img = 'images/devlogo';
    if( ! empty( $getinfo->mkt_profile_photo ) )
    {
      if( $storage->exists( $path_img . '/' . $getinfo->dev_logo ) )
      {
        $storage->delete( $path_img . '/' . $getinfo->dev_logo );
      }
    }
    $getinfo->dev_logo = $filename;
    $getinfo->save();
    $storage->putFileAs($path_img, $logo_brand, $filename );
    $res = ['status' => 200, 'statusText' => 'upload success'];
    return response()->json( $res, $res['status'] );
  }

  public function dev_manage_project( Request $request, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $data = [
        'request' => $request,
        'session_user' => $developeruser->getinfo()
      ];

      return response()->view('frontend.pages.developer.projects', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function add_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list )
  {
    $project_name = $request->project_name;
    $project_slug = str_slug( $project_name );
    $project_region = $request->project_region;
    $project_city = $request->project_city;
    $project_address = $request->project_address;
    $project_gmaps = $request->project_gmaps;
    $project_description = $request->project_description;
    $project_status = $request->project_status;

    $insert = new $project_list;
    $insert->project_name = $project_name;
    $insert->project_slug = $project_slug;
    $insert->project_region = $project_region;
    $insert->project_city = $project_city;
    $insert->project_address = $project_address;
    $insert->project_gmaps = $project_gmaps;
    $insert->project_description = $project_description;
    $insert->project_status = $project_status;
    $insert->dev_user_id = session()->get('dev_user_id');
    $insert->save();
    $res = [ 'status' => 200, 'statusText' => 'success' ];

    return response()->json( $res, $res['status'] );
  }

  public function save_project( Request $request, DeveloperUser $developeruser, ProjectList $project_list, $project_id )
  {
    $project_name = $request->project_name;
    $project_slug = str_slug( $project_name );
    $project_region = $request->project_region;
    $project_city = $request->project_city;
    $project_address = $request->project_address;
    $project_gmaps = $request->project_gmaps;
    $project_description = $request->project_description;
    $project_status = $request->project_status;

    $update = $project_list->where('project_id', $project_id)->first();
    $update->project_name = $project_name;
    $update->project_slug = $project_slug;
    $update->project_region = $project_region;
    $update->project_city = $project_city;
    $update->project_address = $project_address;
    $update->project_gmaps = $project_gmaps;
    $update->project_description = $project_description;
    $update->project_status = $project_status;
    $update->save();
    $res = [ 'status' => 200, 'statusText' => 'success' ];

    return response()->json( $res, $res['status'] );
  }

  public function getProjectList( Request $request, ProjectList $project_list )
  {
    $keywords = $request->keywords;
    $status = $request->status;
    $project = new $project_list;

    if( empty( $keywords ) )
    {
      $query = $project->orderBy('created_at', 'desc');
      if( $status !== 'all' )
      {
        $query = $project->where('project_status', $status)
        ->orderBy('created_at', 'desc');
      }
    }
    else
    {
      $query = $project->where('project_name', 'like', '%' . $keywords . '%')
      ->orderBy('created_at', 'desc');
      if( $status !== 'all' )
      {
        $query = $project->where([
          ['project_status', $status],
          ['project_name', 'like', '%' . $keywords . '%']
        ])
        ->orderBy('created_at', 'desc');
      }
    }
    $fetchdata = $query->paginate( 6 );
    $data = [
      'status' => 200,
      'statusText' => 'success',
      'results' => $fetchdata
    ];
    return response()->json( $data, $data['status'] );
  }

  public function delete_project( Request $request, ProjectList $project_list, $project_id )
  {
    $getproject = $project_list->where('project_id', $project_id);
    if( $getproject->count() !== 0 )
    {
      $getproject->delete();
    }
    $res = [ 'status' => 200, 'statusText' => 'success' ];
    return response()->json( $res, $res['status'] );
  }
}

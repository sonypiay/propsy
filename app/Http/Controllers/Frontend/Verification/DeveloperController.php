<?php

namespace App\Http\Controllers\Frontend\Verification;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Hash;
use App\Database\DeveloperUser;
use App\Database\VerificationDeveloper;
use App\Http\Controllers\Controller;

class DeveloperController extends Controller
{
  public function index( Request $request, VerificationDeveloper $verification, DeveloperUser $developeruser )
  {
    if( session()->has('isDeveloper') )
    {
      $getdeveloper = $developeruser->getinfo();
      $getverification = $verification->where('dev_user_id', $getdeveloper->dev_user_id)->first();
      $data = [
        'request' => $request,
        'session_user' => $getdeveloper,
        'getverification' => $getverification
      ];

      return response()->view('frontend.pages.developer.request_verification', $data);
    }
    else
    {
      return redirect()->route('developer_login_page');
    }
  }

  public function request_verification( Request $request, VerificationDeveloper $verification, DeveloperUser $developeruser )
  {
    $npwp = $request->npwp;
    $cerificate = $request->certificate;
    $getdeveloper = $developeruser->getinfo();
    $getverification = $verification->where('dev_user_id', $getdeveloper->dev_user_id);
    $storage = Storage::disk('assets');
    $storage_path = 'document/request_verification';

    $npwp_filename = 'NPWP-' . $npwp->hashName();
    $cerificate_filename = 'Cert-' . $cerificate->hashName();

    if( $getverification->count() === 0 )
    {
      $hash_id = sha1( base64_encode( Hash::make( $getdeveloper->dev_user_id ) ) );

      $verification->hash_id = $hash_id;
      $verification->npwp_image = $npwp_filename;
      $verification->official_certificate = $cerificate_filename;
      $verification->dev_user_id = $getdeveloper->dev_user_id;
      $verification->status_verification = 'N';
      $verification->save();

      $storage->putFileAs( $storage_path, $npwp, $npwp_filename );
      $storage->putFileAs( $storage_path, $cerificate, $cerificate_filename );
    }
    else
    {
      $result = $getverification->first();
      if( $result->status_verification === 'N' )
      {
        $res = ['status' => 409, 'statusText' => 'Akun anda belum ditinjau oleh Admin. Silakan menunggu kembali.'];
      }
      else if( $result->status_verification === 'Y' )
      {
        $res = ['status', 409, 'statusText' => 'Akun anda sudah terverifikasi.'];
      }
      else
      {
        if( $storage->exists( $storage_path . '/' . $result->npwp_image ) )
        {
          $storage->delete( $storage_path . '/' . $result->npwp_image );
        }
        if( $storage->exists( $storage_path . '/' . $result->official_certificate ) )
        {
          $storage->delete( $storage_path . '/' . $result->official_certificate );
        }

        $update = $verification->where('hash_id', $result->hash_id)->first();
        $update->npwp_image = $npwp_filename;
        $update->official_certificate = $cerificate_filename;
        $update->dev_user_id = $getdeveloper->dev_user_id;
        $update->status_verification = 'N';
        $update->save();

        $storage->putFileAs( $storage_path, $npwp, $npwp_filename );
        $storage->putFileAs( $storage_path, $cerificate, $cerificate_filename );
      }
    }

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

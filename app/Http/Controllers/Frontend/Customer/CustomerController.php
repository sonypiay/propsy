<?php

namespace App\Http\Controllers\Frontend\Customer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Storage;
use App\Database\Customer;
use App\Database\VerificationCustomer;
use App\Database\ResetPassword;
use App\Database\ProjectRequest;
use App\Http\Controllers\Controller;
use App\Mail\CustomerEmailValidation;
use App\Mail\LinkResetPassword;
use Mail;

class CustomerController extends Controller
{
  public function index( Request $request, Customer $customer )
  {
    if( session()->has('isCustomer') )
    {
      $data = [
        'request' => $request,
        'session_user' => $customer->getinfo(),
        'hasrequest' => $customer->hasrequest()
      ];

      return response()->view('frontend.pages.customer.profile_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function login_page( Request $request )
  {
    if( ! session()->has('isCustomer') )
    {
      $data = [
        'request' => $request,
      ];

      return response()->view('frontend.pages.customer.login', $data);
    }
    else
    {
      return redirect()->route('customer_profile_page');
    }
  }

  public function register_page( Request $request )
  {
    if( ! session()->has('isCustomer') )
    {
      $data = [ 'request' => $request ];

      return response()->view('frontend.pages.customer.register', $data);
    }
    else
    {
      return redirect()->route('customer_profile_page');
    }
  }

  public function profile_page( Request $request, Customer $customer )
  {
    if( session()->has('isCustomer') )
    {
      $data = [
        'request' => $request,
        'session_user' => $customer->getinfo(),
        'hasrequest' => $customer->hasrequest()
      ];

      return response()->view('frontend.pages.customer.profile_page', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function change_password( Request $request, Customer $customer )
  {
    $password = $request->password;
    $hash_password = Hash::make( $password, ['rounds' => 12]);
    $getinfo = $customer->getinfo();
    $getinfo->customer_password = $hash_password;
    $getinfo->save();

    return response()->json([ 'status' => 200, 'statusText' => 'success' ], 200);
  }

  public function change_email( Request $request, Customer $customer, VerificationCustomer $verificationCustomer )
  {
    $email = $request->email;
    $getinfo = $customer->getinfo();
    $check_email = $customer->where('customer_email', $email);

    if( $getinfo->customer_email !== $email )
    {
      if( $check_email->count() > 0 )
      {
        $res = [ 'status' => 409, 'statusText' => $email . ' sudah digunakan.' ];
      }
      else
      {
        $expire_date = time() + 60 * 30;
        $hash_id = sha1( Hash::make($email.$getinfo->customer_password) );
        $data_verify = [
          'customer_id' => $getinfo->customer_id,
          'hash_id' => $hash_id,
          'expire_date' => $expire_date
        ];

        $verificationCustomer->makeVerification($data_verify);
        $send = new CustomerEmailValidation( $data_verify['hash_id'], $email );
        $when = now()->addMinutes(5);
        Mail::to( $email )->later( $when, $send );

        $getinfo->customer_email = $email;
        $getinfo->status_verification = 'N';
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

  public function change_account_information( Request $request, Customer $customer )
  {
    $fullname = $request->fullname;
    $phone_number = $request->phone_number;
    $city = $request->city;
    $username = $request->username;
    $address = $request->address;
    $getinfo = $customer->getinfo();

    $getinfo->customer_name = $fullname;
    $getinfo->customer_phone_number = $phone_number;
    $getinfo->city_id = $city;
    $getinfo->customer_address = $address;

    if( $getinfo->customer_username == $username )
    {
      $getinfo->save();
      $res = ['status' => 200, 'statusText' => 'success'];
    }
    else
    {
      $checkusername = $customer->where('customer_username', $username)->count();
      if( $checkusername > 0 )
      {
        $res = ['status' => 409, 'statusText' => $username . ' sudah digunakan.'];
      }
      else
      {
        $getinfo->customer_username = $username;
        $getinfo->save();
        $res = ['status' => 200, 'statusText' => 'success'];
      }
    }

    return response()->json( $res, $res['status'] );
  }

  public function upload_photo_profile( Request $request, Customer $customer )
  {
    $photo_profile = $request->photo_profie;
    $filename = $photo_profile->hashName();
    $storage = Storage::disk('assets');
    $getinfo = $customer->getinfo();
    $path_img = 'images/avatar';
    if( ! empty( $getinfo->customer_photo ) )
    {
      if( $storage->exists( $path_img . '/' . $getinfo->customer_photo ) )
      {
        $storage->delete( $path_img . '/' . $getinfo->customer_photo );
      }
    }
    $getinfo->customer_photo = $filename;
    $getinfo->save();
    $storage->putFileAs($path_img, $photo_profile, $filename );
    $res = ['status' => 200, 'statusText' => 'upload success'];
    return response()->json( $res, $res['status'] );
  }

  public function request_unit_page( Request $request, Customer $customer )
  {
    if( session()->has('isCustomer') )
    {
      $data = [
        'request' => $request,
        'session_user' => $customer->getinfo(),
        'hasrequest' => $customer->hasrequest()
      ];

      return response()->view('frontend.pages.customer.request_list', $data);
    }
    else
    {
      return redirect()->route('homepage');
    }
  }

  public function resend_verification( Request $request, VerificationCustomer $verificationCustomer, Customer $customer )
  {
    $getcustomer = $customer->getinfo();

    if( $getcustomer->status_verification === 'N' )
    {
      $expire_date = time() + 60 * 30;
      $hash_id = sha1( Hash::make($getcustomer->customer_email.$getcustomer->customer_password) );
      $data_verify = [
        'customer_id' => $getcustomer->customer_id,
        'hash_id' => $hash_id,
        'expire_date' => $expire_date
      ];

      $verificationCustomer->makeVerification($data_verify);
      $send = new CustomerEmailValidation( $data_verify['hash_id'], $getcustomer->customer_email );
      $when = now()->addMinutes(5);
      Mail::to( $email )->later( $when, $send );
      $res = ['status' => 200, 'statusText' => 'Link verifikasi telah terkirim. Silakan cek inbox / spam Anda'];
    }
    else
    {
      $res = ['status' => 200, 'statusText' => 'Anda sudah terverifikasi'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function reset_password_page( Request $request )
  {
    if( ! session()->has('isCustomer') )
    {
      $data = [ 'request' => $request ];
      return response()->view('frontend.pages.customer.reset_password', $data);
    }
    else
    {
      return redirect()->route('customer_profile_page');
    }
  }

  public function send_password_token( Request $request, ResetPassword $resetpassword, Customer $customer )
  {
    $email = $request->email;
    $expired_date = time() + 60 * 30;
    $token = sha1( Hash::make( $email ) );
    $check_email = $customer->where('customer_email', $email)->count();

    if( $check_email === 1 )
    {
      $data_reset_password = [
        'token' => $token,
        'expired' => $expired_date,
        'email' => $email,
        'usertype' => 'customer'
      ];

      $resetpassword->insertResetPassword( $data_reset_password );
      $when = now()->addMinutes(5);
      Mail::to( $email )->later( $when, new LinkResetPassword( $token, $email ) );
    }

    $res = ['status' => 200, 'statusText' => 'success'];
    return response()->json( $res, $res['status'] );
  }
}

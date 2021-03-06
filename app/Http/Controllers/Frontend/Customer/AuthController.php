<?php

namespace App\Http\Controllers\Frontend\Customer;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use App\Database\Customer;
use App\Database\VerificationCustomer;
use App\Http\Controllers\Controller;
use App\Mail\CustomerEmailValidation;
use App\Events\CustomerEmailVerificationEvent;

class AuthController extends Controller
{
  public function do_login( Request $request, Customer $customer )
  {
    $username = $request->username;
    $password = $request->password;
    $check_username = $customer->where('customer_username', $username);
    $check_email = $customer->where('customer_email', $username);
    $valid = false;

    if( $check_username->count() === 1 )
    {
      $result = $check_username->first();
      $valid = true;
    }
    else if( $check_email->count() === 1 )
    {
      $result = $check_email->first();
      $valid = true;
    }
    else { $valid = false; }

    if( $valid )
    {
      if( Hash::check( $password, $result->customer_password ) )
      {
        $res = [
          'status' => 200,
          'statusText' => 'login success'
        ];

        session()->put('isCustomer', true);
        session()->put('customer_id', $result->customer_id);
        session()->put('customer_email', $result->customer_email);
        session()->put('cust_login_date', date('Y-m-d H:i:s'));
      }
      else
      {
        $res = [
          'status' => 401,
          'statusText' => 'Password tidak sesuai.'
        ];
      }
    }
    else
    {
      $res = [
        'status' => 401,
        'statusText' => 'Username atau Email tidak terdaftar.'
      ];
    }

    return response()->json( $res, $res['status'] );
  }

  public function do_register( Request $request, Customer $customer, VerificationCustomer $verificationCustomer )
  {
    $fullname = $request->fullname;
    $email = $request->email;
    $username = $request->username;
    $password = $request->password;
    $hash_password = Hash::make( $password, ['rounds' => 12]);
    $check_username = $customer->where('customer_username', $username);
    $check_email = $customer->where('customer_email', $email);

    if( $check_username->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $username . ' sudah digunakan'
      ];
    }
    else if( $check_email->count() > 0 )
    {
      $res = [
        'status' => 409,
        'statusText' => $email . ' sudah digunakan'
      ];
    }
    else
    {
      $customerid = $customer->generateId();
      $expire_date = time() + 60 * 30;
      $hash_id = sha1( Hash::make($email.$hash_password) );
      $data_verify = [
        'customer_id' => $customerid,
        'hash_id' => $hash_id,
        'expire_date' => $expire_date
      ];


      $insert = new $customer;
      $insert->customer_id = $customerid;
      $insert->customer_name = $fullname;
      $insert->customer_email = $email;
      $insert->customer_username = $username;
      $insert->customer_password = $hash_password;
      $insert->save();

      event( new CustomerEmailVerificationEvent( $data_verify, $email ) );

      $getuser = $customer->where([
        ['customer_username', $username],
        ['customer_password', $hash_password]
      ])->first();

      session()->put('isCustomer', true);
      session()->put('customer_id', $getuser->customer_id);
      session()->put('customer_email', $getuser->customer_email);
      session()->put('cust_login_date', date('Y-m-d H:i:s'));

      $res = ['status' => 200, 'statusText' => 'success'];
    }

    return response()->json( $res, $res['status'] );
  }

  public function do_logout()
  {
    if( session()->has('isCustomer') )
    {
      session()->forget('isCustomer');
      session()->forget('customer_id');
      session()->forget('customer_email');
      session()->forget('cust_login_date');
      session()->flush();
    }

    return redirect()->route('homepage');
  }
}

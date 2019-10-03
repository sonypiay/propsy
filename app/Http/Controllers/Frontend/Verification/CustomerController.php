<?php

namespace App\Http\Controllers\Frontend\Verification;

use Illuminate\Http\Request;
use App\Database\Customer;
use App\Database\VerificationCustomer;
use App\Http\Controllers\Controller;

class CustomerController extends Controller
{
  public function validate_email( Request $request, VerificationCustomer $verify, Customer $customer, $hash_id )
  {
    $getverify = $verify->where('hash_id', $hash_id);
    $res = [];
    if( $getverify->count() == 0 )
    {
      $res['result'] = '';
    }
    else
    {
      $result = $getverify->first();
      $getcustomer = $customer->where('customer_id', $result->customer_id)->first();
      $res['result'] = $result;
      $res['customer'] = $getcustomer;
    }

    return response()->view('frontend.mailing.validate_email', $res);
  }

  public function view_template( Request $request )
  {
    $data = [
      'email' => 'sonypiay@mail.com',
      'hash_id' => base64_encode( uniqid() )
    ];

    return response()->view('frontend.mailing.verification_customer', $data);
  }
}

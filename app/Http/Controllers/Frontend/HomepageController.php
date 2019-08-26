<?php

namespace App\Http\Controllers\Frontend;

use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class HomepageController extends Controller
{
  public function index( Request $request )
  {
    return response()->view('frontend.pages.homepage')
    ->header('Content-Type', 'text/html')
    ->header('Accepts', 'text/html');
  }
}

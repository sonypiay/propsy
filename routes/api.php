<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::group(['prefix' => 'region'], function() {
  Route::get('/provinsi/all', 'RestApi\RegionCityApi@provinsi_all');
  Route::get('/provinsi/where/{id}', 'RestApi\RegionCityApi@provinsi_single');

  Route::get('/kota/all/{provinsi}', 'RestApi\RegionCityApi@kota_all');
  Route::get('/kota/where/{provinsi}/{id}', 'RestApi\RegionCityApi@kota_single');
});

Route::group(['prefix' => 'analytic'], function() {
  //Route::get('/project_list', 'Frontend');
});

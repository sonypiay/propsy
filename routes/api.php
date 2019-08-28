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

  Route::get('/kabupaten/all/{provinsi}', 'RestApi\RegionCityApi@kabupaten_all');
  Route::get('/kabupaten/where/{provinsi}/{id}', 'RestApi\RegionCityApi@kabupaten_single');

  Route::get('/kecamatan/all/{kabupaten}', 'RestApi\RegionCityApi@kecamatan_all');
  Route::get('/kecamatan/where/{id}', 'RestApi\RegionCityApi@kecamatan_single');

  /*Route::get('/kecamatan/all', 'RestApi\RegionCityApi@kelurahan_all');
  Route::get('/kecamatan/where/{id}', 'RestApi\RegionCityApi@kecamatan_single');*/
});

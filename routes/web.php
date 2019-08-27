<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'Frontend\HomepageController@index')->name('homepage');
Route::group(['prefix' => 'authentication'], function() {
  Route::post('/login/developer', 'Frontend\Developer\AuthController@do_login');
  Route::post('/login/marketing', 'Frontend\Marketing\AuthController@do_login');
  Route::get('/logout/developer', 'Frontend\Developer\AuthController@do_logout')->name('auth_logout_dev');
  Route::get('/logout/marketing', 'Frontend\Marketing\AuthController@do_logout')->name('auth_logout_mkt');
});

Route::group(['prefix' => 'registration'], function() {
  //Route::post('/developer', 'Frontend\Developer\AuthController@do_register');
  Route::post('/marketing', 'Frontend\Marketing\AuthController@do_register');
});

// Marketing
Route::group(['prefix' => 'marketing'], function() {
  Route::get('/', function() { return redirect()->route('marketing_dashboard_page'); });
  Route::get('/dashboard', 'Frontend\Marketing\MarketingController@index')->name('marketing_dashboard_page');
  Route::get('/settings', 'Frontend\Marketing\MarketingController@settings_page')->name('marketing_settings_page');
  Route::get('/profile', 'Frontend\Marketing\MarketingController@profile_page')->name('marketing_profile_page');
});

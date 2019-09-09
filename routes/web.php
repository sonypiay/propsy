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
  Route::post('/developer', 'Frontend\Developer\AuthController@do_register');
  Route::post('/marketing', 'Frontend\Marketing\AuthController@do_register');
});

// Marketing
Route::group(['prefix' => 'marketing'], function() {
  Route::get('/', function() { return redirect()->route('marketing_dashboard_page'); });
  Route::get('/dashboard', 'Frontend\Marketing\MarketingController@index')->name('marketing_dashboard_page');
  Route::get('/profile', 'Frontend\Marketing\MarketingController@profile_page')->name('marketing_profile_page');
  Route::get('/masuk', 'Frontend\Marketing\MarketingController@login_page')->name('marketing_login_page');
  Route::get('/daftar', 'Frontend\Marketing\MarketingController@register_page')->name('marketing_register_page');

  Route::group(['prefix' => 'profile'], function() {
    Route::put('/change_password', 'Frontend\Marketing\MarketingController@change_password');
    Route::put('/change_email', 'Frontend\Marketing\MarketingController@change_email');
    Route::put('/change_account_information', 'Frontend\Marketing\MarketingController@change_account_information');
    Route::post('/upload_photo_profile', 'Frontend\Marketing\MarketingController@upload_photo_profile');
  });

  Route::group(['prefix' => 'customer'], function() {
    Route::get('/request', 'Frontend\Marketing\RequestInfoController@customer_request_info')->name('marketing_request_info');
    Route::get('/get_request_info', 'Frontend\Marketing\RequestInfoController@get_request_info');
    Route::get('/detail_request/{reqid}', 'Frontend\Marketing\RequestInfoController@get_detail_request');
  });
});

Route::group(['prefix' => 'developer'], function() {
  Route::get('/', function() { return redirect()->route('developer_dashboard_page'); });
  Route::get('/dashboard', 'Frontend\Developer\DeveloperController@index')->name('developer_dashboard_page');
  Route::get('/profile', 'Frontend\Developer\DeveloperController@profile_page')->name('developer_profile_page');
  Route::get('/masuk', 'Frontend\Developer\DeveloperController@login_page')->name('developer_login_page');
  Route::get('/daftar', 'Frontend\Developer\DeveloperController@register_page')->name('developer_register_page');
  Route::group(['prefix' => 'project'], function() {
    Route::get('/detail/{project_id}', 'Frontend\Developer\ProjectListController@detail_project')->name('developer_detail_project');
    Route::get('/manage_project', 'Frontend\Developer\ProjectListController@dev_manage_project')->name('developer_manage_project');
    Route::post('/add_project', 'Frontend\Developer\ProjectListController@add_project');
    Route::put('/save_project/{project_id}', 'Frontend\Developer\ProjectListController@save_project');
    Route::get('/list_project', 'Frontend\Developer\ProjectListController@getProjectList');
    Route::delete('/delete_project/{project_id}', 'Frontend\Developer\ProjectListController@delete_project');

    Route::get('/gallery/{project_id}', 'Frontend\Developer\ProjectGalleryController@project_gallery')->name('developer_project_gallery');
    Route::get('/data_gallery/{project_id}', 'Frontend\Developer\ProjectGalleryController@get_gallery');
    Route::post('/upload_gallery/{project_id}', 'Frontend\Developer\ProjectGalleryController@upload_gallery');
    Route::delete('/delete_gallery/{gallery_id}', 'Frontend\Developer\ProjectGalleryController@delete_gallery');
    Route::put('/set_asthumbnail/{gallery_id}', 'Frontend\Developer\ProjectGalleryController@gallery_asThumbnail');

    Route::get('/get_unit/{project_id}', 'Frontend\Developer\ProjectUnitController@get_unit_project');
    Route::post('/add_unit/{project_id}', 'Frontend\Developer\ProjectUnitController@project_add_unit');
    Route::post('/save_unit/{unit_id}', 'Frontend\Developer\ProjectUnitController@project_save_unit');
    Route::delete('/delete_unit/{unit_id}', 'Frontend\Developer\ProjectUnitController@project_delete_unit');

    Route::get('/get_unit_tipe/{unit_id}', 'Frontend\Developer\ProjectUnitController@get_unit_tipe_project');
    Route::post('/add_unit_tipe/{unit_id}', 'Frontend\Developer\ProjectUnitController@project_add_unit_tipe');
    Route::put('/save_unit_tipe/{unit_tipe_id}', 'Frontend\Developer\ProjectUnitController@project_save_unit_tipe');
    Route::delete('/delete_unit_tipe/{id}', 'Frontend\Developer\ProjectUnitController@project_delete_unit_tipe');

    Route::get('/installment_unit/{id}', 'Frontend\Developer\ProjectUnitController@get_installment_unit');
    Route::post('/add_installment/{id}', 'Frontend\Developer\ProjectUnitController@add_installment_unit');
    Route::put('/save_installment/{id}', 'Frontend\Developer\ProjectUnitController@save_installment_unit');
    Route::delete('/delete_installment/{id}', 'Frontend\Developer\ProjectUnitController@delete_installment_unit');
  });

  Route::group(['prefix' => 'profile'], function() {
    Route::put('/change_account_information', 'Frontend\Developer\DeveloperController@change_account_information');
    Route::put('/change_password', 'Frontend\Developer\DeveloperController@change_password');
    Route::put('/change_email', 'Frontend\Developer\DeveloperController@change_email');
    Route::post('/upload_logo', 'Frontend\Developer\DeveloperController@upload_logo');
  });
});

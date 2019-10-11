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
Route::get('/profile/developer/{slug}', 'Frontend\HomepageController@homepage_developer')->name('homepage_developer');
Route::group(['prefix' => 'authentication'], function() {
  Route::post('/login/developer', 'Frontend\Developer\AuthController@do_login');
  Route::post('/login/marketing', 'Frontend\Marketing\AuthController@do_login');
  Route::post('/login/customer', 'Frontend\Customer\AuthController@do_login');
  Route::get('/logout/developer', 'Frontend\Developer\AuthController@do_logout')->name('auth_logout_dev');
  Route::get('/logout/marketing', 'Frontend\Marketing\AuthController@do_logout')->name('auth_logout_mkt');
  Route::get('/logout/customer', 'Frontend\Customer\AuthController@do_logout')->name('auth_logout_customer');
});

Route::group(['prefix' => 'registration'], function() {
  Route::post('/developer', 'Frontend\Developer\AuthController@do_register');
  Route::post('/marketing', 'Frontend\Marketing\AuthController@do_register');
  Route::post('/customer', 'Frontend\Customer\AuthController@do_register');
});

Route::group(['prefix' => 'customer'], function() {
  Route::get('/', function() { return redirect()->route('customer_profile_page'); });
  Route::get('/profile', 'Frontend\Customer\CustomerController@profile_page')->name('customer_profile_page');
  Route::get('/masuk', 'Frontend\Customer\CustomerController@login_page')->name('customer_login_page');
  Route::get('/daftar', 'Frontend\Customer\CustomerController@register_page')->name('customer_register_page');
  Route::post('/resend_verification', 'Frontend\Customer\CustomerController@resend_verification');
  Route::group(['prefix' => 'profile'], function() {
    Route::put('/change_password', 'Frontend\Customer\CustomerController@change_password');
    Route::put('/change_email', 'Frontend\Customer\CustomerController@change_email');
    Route::put('/change_account_information', 'Frontend\Customer\CustomerController@change_account_information');
    Route::post('/upload_photo_profile', 'Frontend\Customer\CustomerController@upload_photo_profile');
  });

  Route::get('/request_unit', 'Frontend\Customer\CustomerController@request_unit_page')->name('customer_request_page');
  Route::get('/get_request_list/{status_request}', 'Frontend\Customer\RequestUnitController@get_request_list');
  Route::put('/cancel_request/{request_id}', 'Frontend\Customer\RequestUnitController@cancel_request');
  Route::put('/response_meeting_invitation/{request_id}/{status_request}', 'Frontend\Customer\RequestUnitController@response_meeting_invitation');

  Route::get('/meeting_invitation', 'Frontend\Customer\MeetingInvitationController@index')->name('customer_meeting_page');
  Route::get('/get_meeting_invitation', 'Frontend\Customer\MeetingInvitationController@get_meeting_invitation');
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
    Route::get('/request_unit', 'Frontend\Marketing\RequestUnitController@customer_request_unit')->name('marketing_request_unit');
    Route::get('/get_request_unit', 'Frontend\Marketing\RequestUnitController@get_request_unit');
    Route::get('/detail_request/{request_id}', 'Frontend\Marketing\RequestUnitController@detail_request');
  });

  Route::group(['prefix' => 'meeting'], function() {
    Route::get('/meeting_list', 'Frontend\Marketing\MeetingListController@index')->name('marketing_meeting_list');
    Route::get('/create_schedule/{request_id?}', 'Frontend\Marketing\MeetingListController@create_schedule_page')->name('marketing_create_schedule');
    Route::get('/edit_schedule/{request_id}', 'Frontend\Marketing\MeetingListController@edit_schedule_page')->name('marketing_edit_schedule');
    Route::get('/get_meeting_list', 'Frontend\Marketing\MeetingListController@get_meeting_list');
    Route::post('/create_schedule/{request_id}', 'Frontend\Marketing\MeetingListController@create_schedule');
    Route::post('/update_schedule/{request_id}', 'Frontend\Marketing\MeetingListController@update_schedule');
    Route::get('/detail_meeting/{request_id}', 'Frontend\Marketing\MeetingListController@get_detail_schedule');
    Route::put('/cancel_request/{request_id}', 'Frontend\Marketing\MeetingListController@cancel_request');
  });

  Route::group(['prefix' => 'project'], function() {
    Route::get('/', 'Frontend\Marketing\ProjectListController@index')->name('marketing_view_project');
    Route::get('/list_project', 'Frontend\Marketing\ProjectListController@getProjectList');
    Route::get('/detail/{project_id}', 'Frontend\Marketing\ProjectListController@detail_project')->name('marketing_detail_project');
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
    Route::get('/add_project', 'Frontend\Developer\ProjectListController@add_project_page')->name('developer_add_project_page');
    Route::post('/add_project', 'Frontend\Developer\ProjectListController@add_project');
    Route::get('/edit_project/{id}', 'Frontend\Developer\ProjectListController@edit_project_page')->name('developer_edit_project_page');
    Route::post('/save_project/{project_id}', 'Frontend\Developer\ProjectListController@save_project');
    Route::get('/list_project', 'Frontend\Developer\ProjectListController@getProjectList');
    Route::delete('/delete_project/{project_id}', 'Frontend\Developer\ProjectListController@delete_project');

    Route::get('/gallery/{project_id}', 'Frontend\Developer\ProjectGalleryController@project_gallery')->name('developer_project_gallery');
    Route::get('/data_gallery/{project_id}', 'Frontend\Developer\ProjectGalleryController@get_gallery');
    Route::post('/upload_gallery/{project_id}', 'Frontend\Developer\ProjectGalleryController@upload_gallery');
    Route::delete('/delete_gallery/{gallery_id}', 'Frontend\Developer\ProjectGalleryController@delete_gallery');
    Route::put('/set_asthumbnail/{gallery_id}', 'Frontend\Developer\ProjectGalleryController@gallery_asThumbnail');

    Route::get('/get_unit/{project_id}', 'Frontend\Developer\ProjectUnitController@get_unit');
    Route::get('/add_unit/{project_id}', 'Frontend\Developer\ProjectUnitController@add_unit_page');
    Route::post('/add_unit/{project_id}', 'Frontend\Developer\ProjectUnitController@add_unit');
    Route::get('/edit_unit/{project_id}', 'Frontend\Developer\ProjectUnitController@edit_unit_page');
    Route::put('/save_unit/{id}', 'Frontend\Developer\ProjectUnitController@save_unit');
    Route::delete('/delete_unit_tipe/{id}', 'Frontend\Developer\ProjectUnitController@delete_unit_tipe');
    Route::post('/upload_gallery_unit/{id}', 'Frontend\Developer\ProjectUnitController@upload_gallery_unit');
    Route::get('/gallery_unit/{id}', 'Frontend\Developer\ProjectUnitController@get_gallery_unit');
    Route::put('/gallery_set_thumbnail/{id}', 'Frontend\Developer\ProjectUnitController@gallery_set_thumbnail');
    Route::delete('/delete_gallery_unit/{id}', 'Frontend\Developer\ProjectUnitController@delete_gallery_unit');

    Route::get('/get_installment/{unit_id}', 'Frontend\Developer\ProjectUnitController@get_installment');
    Route::post('/add_installment', 'Frontend\Developer\ProjectUnitController@add_installment');
    Route::put('/save_installment/{id}', 'Frontend\Developer\ProjectUnitController@save_installment');
    Route::delete('/delete_installment/{id}', 'Frontend\Developer\ProjectUnitController@delete_installment');
  });

  Route::group(['prefix' => 'profile'], function() {
    Route::put('/change_account_information', 'Frontend\Developer\DeveloperController@change_account_information');
    Route::put('/change_password', 'Frontend\Developer\DeveloperController@change_password');
    Route::put('/change_email', 'Frontend\Developer\DeveloperController@change_email');
    Route::post('/upload_logo', 'Frontend\Developer\DeveloperController@upload_logo');
  });

  Route::group(['prefix' => 'marketing'], function() {
    Route::get('/manage_marketing', 'Frontend\Developer\ProjectMarketingController@index')->name('developer_manage_marketing');
    Route::get('/list_marketing', 'Frontend\Developer\ProjectMarketingController@listOfMarketing');
    Route::post('/add_marketing', 'Frontend\Developer\ProjectMarketingController@add_marketing');
    Route::put('/save_marketing/{userid}', 'Frontend\Developer\ProjectMarketingController@save_marketing');
    Route::delete('/delete_marketing/{userid}', 'Frontend\Developer\ProjectMarketingController@delete_marketing');

    Route::get('/meeting_list', 'Frontend\Marketing\MeetingListController@index')->name('developer_meeting_list');
    Route::get('/get_meeting_list', 'Frontend\Marketing\MeetingListController@get_meeting_list');
  });

  Route::group(['prefix' => 'customer'], function() {
    Route::get('/request_unit', 'Frontend\Developer\RequestUnitController@customer_request_unit')->name('developer_request_unit');
    Route::get('/get_request_unit', 'Frontend\Developer\RequestUnitController@get_request_unit');
    Route::get('/detail_request/{request_id}', 'Frontend\Developer\RequestUnitController@detail_request');
    Route::put('/review_request_unit/{request_id}/{status_review}', 'Frontend\Developer\RequestUnitController@review_request_unit');
    Route::put('/reject_request_unit/{request_id}', 'Frontend\Developer\RequestUnitController@review_request_unit');
  });

  Route::group(['prefix' => 'report'], function() {
    Route::get('/unit', 'Frontend\Developer\ReportController@page_report_unit')->name('developer_report_unit_page');
    Route::get('/unit/save/{type}', 'Frontend\Developer\ReportController@report_save_unit');
    Route::get('/get_unit', 'Frontend\Developer\ReportController@get_unit_sold');
    Route::get('/request_unit/save/{request_id}', 'Frontend\Developer\ReportController@report_save_project_request');
  });
});

Route::group(['prefix' => 'project'], function() {
  Route::get('/available', 'Frontend\Projects\ProjectListController@homepage_available_project');
  Route::get('/view/{slug}', 'Frontend\Projects\ProjectListController@view_project')->name('project_view_detail');
  Route::get('/unit/{project_id}', 'Frontend\Projects\ProjectListController@list_project_unit')->name('list_project_unit');
  Route::post('/request_unit/{unit_id}', 'Frontend\Projects\ProjectListController@request_unit');
  Route::get('/detail_unit/{unit_id}', 'Frontend\Projects\ProjectListController@detail_unit')->name('project_detail_unit');
  Route::get('/browse_project', 'Frontend\Projects\ProjectListController@browse_project_page')->name('browse_project_page');
  Route::get('/project_list', 'Frontend\Projects\ProjectListController@browse_project');
  Route::get('/search', 'Frontend\Projects\ProjectListController@search_project')->name('page_search_project');
  Route::get('/search_list', 'Frontend\Projects\ProjectListController@get_search_list');
  Route::get('/project_developer/{slug}', 'Frontend\Projects\ProjectListController@project_developer');
  Route::get('/marketing_developer/{id}', 'Frontend\Projects\ProjectListController@marketing_developer');
  Route::get('/get_installment/{unit_id}', 'Frontend\Projects\ProjectListController@get_installment');
});


Route::group(['prefix' => 'verification'], function() {
  Route::get('/email_account', 'Frontend\Verification\CustomerController@view_template');
  Route::get('/validate/{hash_id}', 'Frontend\Verification\CustomerController@validate_email')->name('validate_email_customer');
});

Route::group(['prefix' => 'overview'], function() {
  Route::get('/project', 'RestApi\ProjectApi@overview_project');
  Route::get('/request_unit', 'RestApi\ProjectApi@overview_project_request');
  Route::get('/latest_project', 'RestApi\ProjectApi@overview_latest_project');
  Route::get('/latest_log_request', 'RestApi\ProjectApi@latest_log_request');
});


// Control Panel

Route::group(['prefix' => 'cp'], function() {
  Route::get('/', function() { return redirect()->route('cp_dashboard_page'); });
  Route::get('/dashboard', 'ControlPanel\Pages\DashboardController@index')->name('cp_dashboard_page');
  Route::get('/login', 'ControlPanel\LoginController@index')->name('cp_login_page');
  Route::post('/login', 'ControlPanel\LoginController@do_login');
  Route::get('/logout', 'ControlPanel\LoginController@do_logout')->name('cp_logout');

  Route::group(['prefix' => 'manajemen'], function() {
    Route::get('/user_admin', 'ControlPanel\Pages\AdminOwnerController@admin_page')->name('cp_admin_page');
    Route::get('/get_user_admin', 'ControlPanel\Pages\AdminOwnerController@get_admin_owner');
    Route::post('/user_admin/store', 'ControlPanel\Pages\AdminOwnerController@store');
    Route::put('/user_admin/save/{id}', 'ControlPanel\Pages\AdminOwnerController@save');
    Route::delete('/user_admin/delete/{id}', 'ControlPanel\Pages\AdminOwnerController@destroy');
  });

  Route::group(['prefix' => 'account'], function() {
    Route::get('/profile/{pagenav?}', 'ControlPanel\Pages\AdminOwnerController@index')->name('cp_account_profile_page');
    Route::put('/edit_profile/password', 'ControlPanel\Pages\AdminOwnerController@change_password');
    Route::put('/edit_profile/email', 'ControlPanel\Pages\AdminOwnerController@change_email');
    Route::put('/edit_profile/profile', 'ControlPanel\Pages\AdminOwnerController@change_profile');
  });

  Route::group(['prefix' => 'wilayah'], function() {
    Route::group(['prefix' => 'province'], function() {
      Route::get('/', 'ControlPanel\Pages\ProvinceController@index')->name('cp_province_page');
      Route::get('/get_province', 'ControlPanel\Pages\ProvinceController@get_province');
      Route::post('/store', 'ControlPanel\Pages\ProvinceController@store');
      Route::put('/save/{id}', 'ControlPanel\Pages\ProvinceController@save');
      Route::delete('/delete/{id}', 'ControlPanel\Pages\ProvinceController@destroy');
    });

    Route::group(['prefix' => 'city'], function() {
      Route::get('/', 'ControlPanel\Pages\CityController@index')->name('cp_city_page');
      Route::get('/get_city', 'ControlPanel\Pages\CityController@get_city');
      Route::post('/store', 'ControlPanel\Pages\CityController@store');
      Route::put('/save/{id}', 'ControlPanel\Pages\CityController@save');
      Route::delete('/delete/{id}', 'ControlPanel\Pages\CityController@destroy');
    });
  });

  Route::group(['prefix' => 'property'], function() {
    Route::group(['prefix' => 'facility'], function() {
      Route::get('/', 'ControlPanel\Pages\FacilityController@index')->name('cp_facility_page');
      Route::get('/get_facility', 'ControlPanel\Pages\FacilityController@get_facility');
      Route::post('/store', 'ControlPanel\Pages\FacilityController@store');
      Route::put('/save/{id}', 'ControlPanel\Pages\FacilityController@save');
      Route::delete('/delete/{id}', 'ControlPanel\Pages\FacilityController@destroy');
    });
  });

  Route::group(['prefix' => 'customer'], function() {
    Route::get('/', 'ControlPanel\Pages\CustomerController@index')->name('cp_customer_page');
    Route::get('/get_customer', 'ControlPanel\Pages\CustomerController@get_customer');
    Route::get('/save_report', 'ControlPanel\Pages\CustomerController@save_report');

    Route::group(['prefix' => 'request_unit'], function() {
      Route::get('/get_request', 'ControlPanel\Pages\ProjectRequestController@get_request');
      Route::get('/save_report', 'ControlPanel\Pages\ProjectRequestController@save_report');
      Route::get('/get_detail_request/{request_id}', 'ControlPanel\Pages\ProjectRequestController@get_detail_request');
    });
  });

  Route::group(['prefix' => 'developer'], function() {
    Route::get('/', 'ControlPanel\Pages\DeveloperController@index')->name('cp_developer_page');
    Route::get('/get_developer', 'ControlPanel\Pages\DeveloperController@get_developer');
    Route::get('/save_report', 'ControlPanel\Pages\DeveloperController@save_report');

    Route::group(['prefix' => 'project'], function() {
      Route::get('/get_project', 'ControlPanel\Pages\ProjectController@get_project');
      Route::get('/get_unit/{project_id}', 'ControlPanel\Pages\ProjectController@get_unit_type');
      Route::get('/save_report', 'ControlPanel\Pages\ProjectController@save_report');
    });
  });
});

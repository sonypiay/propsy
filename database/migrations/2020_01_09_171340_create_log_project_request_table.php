<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateLogProjectRequestTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('log_project_request', function (Blueprint $table) {
            $table->increments('id');
            $table->text('log_message');
            $table->string('request_id', 18);
            $table->dateTime('log_date');
            $table->foreign('request_id')->references('request_id')->on('project_request')
            ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('log_project_request');
    }
}

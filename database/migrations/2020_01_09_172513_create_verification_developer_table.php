<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVerificationDeveloperTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('verification_developer', function (Blueprint $table) {
          $table->string('hash_id', 40)->primary();
          $table->string('dev_user_id', 13);
          $table->string('npwp_image', 60);
          $table->string('official_certificate', 60);
          $table->enum('status_verification', ['Y','N','R'])->default('N');
          $table->timestamps();
          $table->foreign('dev_user_id')->references('dev_user_id')->on('developer_user')
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
        Schema::dropIfExists('verification_developer');
    }
}

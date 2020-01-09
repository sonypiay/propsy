<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateDeveloperTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('developer_user', function (Blueprint $table) {
            $table->string('dev_user_id', 13);
            $table->string('dev_name', 32);
            $table->string('dev_ownername', 32);
            $table->text('dev_slug');
            $table->text('dev_address')->nullable();
            $table->string('dev_username', 32);
            $table->string('dev_password', 60);
            $table->string('dev_email', 64);
            $table->text('dev_biography')->nullable();
            $table->string('dev_phone_office', 16)->nullable();
            $table->string('dev_mobile_phone', 16)->nullable();
            $table->string('dev_logo', 50)->nullable();
            $table->char('city_id', 3)->nullable();
            $table->enum('status_verification', ['Y','N'])->default('N');
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->primary('dev_user_id');
            $table->unique(['dev_username', 'dev_email']);
            $table->foreign('city_id')->references('city_id')->on('city')->onDelete('no action')->onUpdate('cascade');
        });

        DB::statement("alter table developer_user modify seqid smallint(4) unsigned not null auto_increment unique");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('developer');
    }
}

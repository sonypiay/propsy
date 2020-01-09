<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateCustomerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('customer', function (Blueprint $table) {
            $table->string('customer_id', 14);
            $table->string('customer_name', 64);
            $table->string('customer_email', 64)->unique();
            $table->text('customer_address')->nullable();
            $table->string('customer_phone_number', 16);
            $table->string('customer_username', 64)->unique();
            $table->string('customer_password', 60);
            $table->string('customer_photo', 50)->nullable();
            $table->char('city_id', 3)->nullable();
            $table->enum('status_verification', ['Y','N'])->default('N');
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->primary('customer_id');
            $table->foreign('city_id')->references('city_id')->on('city')->onDelete('no action')->onUpdate('cascade');
        });
        DB::statement("alter table customer modify seqid smallint(4) unsigned not null auto_increment unique");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('customer');
    }
}

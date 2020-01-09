<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateVerificationCustomerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('verification_customer', function (Blueprint $table) {
            $table->string('hash_id', 40)->primary();
            $table->string('customer_id', 14);
            $table->unsignedInteger('expire_date');
            $table->enum('status_verify', ['Y', 'N'])->default('N');
            $table->timestamps();
            $table->foreign('customer_id')->references('customer_id')->on('customer')
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
        Schema::dropIfExists('verification_customer');
    }
}

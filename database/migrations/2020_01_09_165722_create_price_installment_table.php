<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePriceInstallmentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('price_installment', function (Blueprint $table) {
            $table->smallIncrements('id');
            $table->string('unit_type_id', 8);
            $table->unsignedInteger('dp_price');
            $table->unsignedInteger('installment_price');
            $table->unsignedTinyInteger('installment_tenor');
            $table->foreign('unit_type_id')->references('unit_type_id')->on('project_unit_type')
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
        Schema::dropIfExists('price_installment');
    }
}

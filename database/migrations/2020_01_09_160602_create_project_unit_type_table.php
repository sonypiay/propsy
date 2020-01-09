<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateProjectUnitTypeTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_unit_type', function (Blueprint $table) {
            $table->string('unit_type_id', 8)->primary();
            $table->string('unit_name', 128);
            $table->mediumText('unit_slug');
            $table->unsignedTinyInteger('unit_floor')->nullable()->length(2);
            $table->unsignedSmallInteger('unit_lb')->nullable()->length(3);
            $table->unsignedSmallInteger('unit_lt')->nullable()->length(3);
            $table->unsignedTinyInteger('unit_kt')->length(2);
            $table->unsignedTinyInteger('unit_km')->length(2);
            $table->unsignedBigInteger('unit_price')->length(13);
            $table->longText('unit_description')->nullable();
            $table->enum('unit_status', ['available', 'sold', 'booked'])->default('available');
            $table->unsignedSmallInteger('unit_watt')->nullable();
            $table->mediumText('unit_facility')->nullable();
            $table->string('unit_thumbnail', 60);
            $table->string('project_id', 10);
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->foreign('project_id')->on('project_list')->references('project_id')->onDelete('cascade');
        });

        DB::statement("alter table project_unit_type modify seqid smallint(4) unsigned not null auto_increment unique");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('project_unit_type');
    }
}

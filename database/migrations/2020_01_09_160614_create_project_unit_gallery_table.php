<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProjectUnitGalleryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_unit_gallery', function (Blueprint $table) {
            $table->smallIncrements('unit_gallery_id');
            $table->string('unit_gallery_filename', 60);
            $table->string('unit_type_id', 8);
            $table->foreign('unit_type_id')->on('project_unit_type')->references('unit_type_id')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('project_unit_gallery');
    }
}

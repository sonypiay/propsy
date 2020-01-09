<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateProjectGalleryTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_gallery', function (Blueprint $table) {
            $table->smallIncrements('gallery_id');
            $table->string('gallery_filename', 50);
            $table->string('project_id', 10);
            $table->foreign('project_id')->on('project_list')->references('project_id')->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('project_gallery');
    }
}

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateProjectListTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_list', function (Blueprint $table) {
            $table->string('project_id', 10)->primary();
            $table->string('project_name', 200);
            $table->text('project_slug');
            $table->string('project_thumbnail', 128)->nullable();
            $table->longText('project_description')->nullable();
            $table->text('project_address')->nullable();
            $table->mediumText('project_link_map')->nullable();
            $table->text('project_map_embed')->nullable();
            $table->enum('project_type', ['apartemen', 'residensial'])->default('residensial');
            $table->enum('project_status', ['available', 'sold', 'soon'])->default('available');
            $table->year('project_estimate_launch')->nullable();
            $table->string('dev_user_id', 13);
            $table->char('city_id', 3);
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->foreign('city_id')->on('city')->references('city_id')->onDelete('no action')->onUpdate('cascade');
            $table->foreign('dev_user_id')->on('developer_user')->references('dev_user_id')->onDelete('cascade');
        });

        DB::statement("alter table project_list modify seqid smallint(4) unsigned not null auto_increment unique");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('project_list');
    }
}

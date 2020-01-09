<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateAdminOwnerTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('admin_owner', function (Blueprint $table) {
            $table->string('admin_id', 7);
            $table->string('admin_fullname', 32);
            $table->string('admin_username', 32);
            $table->string('admin_password', 60);
            $table->string('admin_email', 32);
            $table->enum('admin_gender', ['L','P'])->default('L');
            $table->string('created_by', 32)->nullable();
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->primary('admin_id');
            $table->unique(['admin_email', 'admin_username']);
        });

        DB::statement("alter table admin_owner modify seqid smallint(4) unsigned not null auto_increment unique");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('admin_owner');
    }
}

<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateMarketingTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('marketing_user', function (Blueprint $table) {
            $table->string('mkt_user_id', 13);
            $table->string('mkt_fullname', 40);
            $table->string('mkt_email', 64);
            $table->string('mkt_username', 32);
            $table->string('mkt_password', 60);
            $table->string('mkt_phone_number', 16)->nullable();
            $table->string('mkt_mobile_phone', 16)->nullable();
            $table->text('mkt_address')->nullable();
            $table->string('mkt_profile_photo', 50)->nullable();
            $table->string('dev_user_id', 13);
            $table->char('city_id', 3)->nullable();
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->primary('mkt_user_id');
            $table->unique(['mkt_username', 'mkt_email']);
            $table->foreign('city_id')->references('city_id')->on('city')->onDelete('no action')->onUpdate('cascade');
            $table->foreign('dev_user_id')->references('dev_user_id')->on('developer_user')->onDelete('no action');
        });

        DB::statement("alter table marketing_user modify seqid smallint(4) unsigned not null auto_increment unique");
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('marketing_user');
    }
}

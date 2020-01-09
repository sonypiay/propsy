<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateProjectRequestTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('project_request', function (Blueprint $table) {
            $table->string('request_id', 18)->primary();
            $table->string('dev_user_id', 13);
            $table->string('customer_id', 14);
            $table->string('unit_type_id', 8);
            $table->text('request_message');
            $table->enum('status_request', [
              'waiting_response',
              'cancel',
              'meeting',
              'accept',
              'reject'
            ])->default('waiting_response');
            $table->enum('isReviewed', ['Y', 'N']);
            $table->unsignedSmallInteger('seqid');
            $table->unsignedSmallInteger('installment');
            $table->timestamps();
            $table->foreign('installment')->references('id')->on('price_installment');
        });

        DB::statement('alter table project_request modify seqid smallint(4) unsigned not null auto_increment unique');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('project_request');
    }
}

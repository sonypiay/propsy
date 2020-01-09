<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Support\Facades\DB;

class CreateMeetingAppointmentTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('meeting_appointment', function (Blueprint $table) {
            $table->string('meeting_id', 17)->primary();
            $table->dateTime('meeting_time');
            $table->enum('meeting_status', [
              'waiting_confirmation',
              'accept',
              'reject',
              'revision',
              'cancel',
              'done'
            ])->default('waiting_confirmation');
            $table->string('request_id', 18);
            $table->mediumText('meeting_note')->nullable();
            $table->text('meeting_result')->nullable();
            $table->string('document_file', 60)->nullable();
            $table->string('created_by', 40);
            $table->string('updated_by', 40);
            $table->unsignedSmallInteger('seqid');
            $table->timestamps();
            $table->foreign('request_id')->references('request_id')->on('project_request')
            ->onDelete('cascade');
        });

        DB::statement('alter table meeting_appointment modify seqid smallint(4) unsigned not null auto_increment unique');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('meeting_appointment');
    }
}

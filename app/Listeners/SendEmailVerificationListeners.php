<?php

namespace App\Listeners;

use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Facades\Mail;
use App\Mail\CustomerEmailValidation;
use App\Database\VerificationCustomer as Verification;

class SendEmailVerificationListeners implements ShouldQueue
{
    /**
     * Handle the event.
     *
     * @param  object  $event
     * @return void
     */
    public function handle($event)
    {
        $verificationCustomer = new Verification;
        $verificationCustomer->makeVerification($event->data_verify);

        $send = new CustomerEmailValidation( $event->data_verify['hash_id'], $event->email );
        Mail::to( $event->email )->send( $send );
    }
}

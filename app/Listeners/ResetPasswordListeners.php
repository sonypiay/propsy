<?php

namespace App\Listeners;

use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Facades\Mail;
use App\Database\ResetPassword;
use App\Mail\LinkResetPassword;

class ResetPasswordListeners implements ShouldQueue
{
    /**
     * Handle the event.
     *
     * @param  object  $event
     * @return void
     */
    public function handle($event)
    {
      (new ResetPassword)->insertResetPassword( $event->reset_password );
      Mail::to( $event->reset_password['email'] )->send(
        new LinkResetPassword( $event->reset_password['token'], $event->reset_password['email'] )
      );
    }
}

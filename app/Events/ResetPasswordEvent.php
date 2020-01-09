<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class ResetPasswordEvent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $reset_password;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct( $data_reset_password )
    {
        $this->reset_password = $data_reset_password;
    }
}

<?php

namespace App\Events;

use Illuminate\Broadcasting\Channel;
use Illuminate\Queue\SerializesModels;
use Illuminate\Broadcasting\PrivateChannel;
use Illuminate\Broadcasting\PresenceChannel;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Broadcasting\InteractsWithSockets;
use Illuminate\Contracts\Broadcasting\ShouldBroadcast;

class CustomerEmailVerificationEvent
{
    use Dispatchable, InteractsWithSockets, SerializesModels;

    public $data_verify;
    public $email;

    /**
     * Create a new event instance.
     *
     * @return void
     */
    public function __construct( $data_verify, $email )
    {
        $this->data_verify = $data_verify;
        $this->email = $email;
    }
}

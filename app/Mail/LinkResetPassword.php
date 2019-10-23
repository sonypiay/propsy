<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class LinkResetPassword extends Mailable
{
    use Queueable, SerializesModels;

    private $token;
    private $email;

    public function __construct( $token, $email )
    {
      $this->token = $token;
      $this->email = $email;
    }

    public function build()
    {
      $emailTo = 'labmode-b368cf@inbox.mailtrap.io';
      $from = 'no-reply@propsy.com';
      $subject = 'Reset Password';

      return $this->view('frontend.mailing.link_reset_password', [
        'token' => $this->token,
        'email' => $this->email
      ])
      ->from( $from )
      ->subject( $subject )
      ->to( $emailTo );
    }
}

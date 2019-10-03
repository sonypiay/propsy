<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;
use Illuminate\Contracts\Queue\ShouldQueue;

class CustomerEmailValidation extends Mailable
{
    use Queueable, SerializesModels;

    private $hash_id;
    private $email;

    public function __construct( $hash_id, $email )
    {
      $this->hash_id = $hash_id;
      $this->email = $email;
    }

    public function build()
    {
      $emailTo = 'labmode-b368cf@inbox.mailtrap.io';
      $from = 'no-reply@propsy.com';
      $subject = 'Verifikasi Email';
      return $this->view('frontend.mailing.verification_customer', [
        'hash_id' => $this->hash_id,
        'email' => $this->email
      ])
      ->from( $from )
      ->subject( $subject )
      ->to( $emailTo );
    }
}

class TextMessageService

  $key = "85108635f68cf5899770c869e9a68c9541717440";
  $clockwork = new Clockwork( $key );
  // Setup and send a message
  $message = array( "to" => $phone, "message" => $messageString);
  $result = $clockwork->send( $message );
  // Check if the send was successful
  if( $result["success"] ) {
      return true;
  } else {
      return false;
  }
end
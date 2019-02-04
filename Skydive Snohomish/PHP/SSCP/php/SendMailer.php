<?php
  //ini_set("SMTP","xx.xx.xx.xx");
  //ini_set("smtp_port","25");
  //ini_set("sendmail_from","skytribe@spottysworld.com");

  ini_set("sendmail_from", "skytribe@192.168.0.101");

  //Email information
  $admin_email = "skytribe@192.168.0.101";
  $email = "skytribe@hotmail.com";
  $subject = "Test";
  $comment = "TEST COMMENT";
  
   
  
  //send email
  mail($admin_email, "$subject", $comment, "From:" . $email);
  
  //Email response
  echo "Thank you for contacting us!";
  
?>
<?php 
require 'PHPMailerAutoload.php';

$recipient = "skytribe@hotmail.com";
$DZrecipient = "skytribe@spottysworld.com";

    // Only process POST requests.
if ($_SERVER["REQUEST_METHOD"] == "POST") {
        // Get the form fields and remove whitespace.
        $name = strip_tags(trim($_POST["name"]));
		$name = str_replace(array("\r","\n"),array(" "," "),$name);
        $email = filter_var(trim($_POST["email"]), FILTER_SANITIZE_EMAIL);
        $message = trim($_POST["message"]);
		$reasoning = trim($_POST["reasoning"]);
	
		$mail = new PHPMailer;
		//$mail->SMTPDebug = 3;                          // Enable verbose debug output

		$mail->isSMTP();                                 // Set mailer to use SMTP 
		$mail->Host = 'smtp.sendgrid.net';               // Specify main/backup SMTP servers 
		$mail->SMTPAuth = true;                          // Enable SMTP authentication 
		$mail->Username = 'skytribe';    // SMTP username 
		$mail->Password = 'Triathlon99';    // SMTP password 
		$mail->SMTPSecure = 'tls';                        // Enable TLS/SSL encryption 
		$mail->Port = 587;                                      // TCP port to connect to



//These would be related to the DZ.
$mail->From = 'admin@skydiveSnohomish.com'; 
$mail->FromName = 'From SS Admin'; 

$mail->addAddress($email, $name);     // Add as a recipient the sender

//Add the CC:
$mail->AddCC($DZrecipient , 'DZ');

$mail->WordWrap = 50;                              // Set word wrap to 50 characters 
$mail->isHTML(true);                                  // Set email format to HTML

//Get the confirmation email
//Substiture a few values
$EmailMesage = file_get_contents("testMessage.txt");
$EmailMesage = str_replace('{Item1}',$name, $EmailMesage);

// Build the email content.
$mail->Subject = 'Experienced Jumper Details Submitted:'.$name;
$mail->Body    = $EmailMesage ;

if(!$mail->send()) { 
    echo 'Message could not be sent.'; 
    echo 'Mailer Error: ' . $mail->ErrorInfo; 
} else { 
    echo 'Message has been sent'; 
}

//Send 2nd email to DZ including reasoning....
$mail->clearAddresses();
$mail->addAddress($DZrecipient , 'DZ');     // Add as a recipient the sender

// Build the email content.
$email2_content .= $EmailMesage;
$email2_content .= "DATA VALUES \n"  .nl2br($message);

$email2_content .= "CANOPY POLICY REASONING\n" ."$reasoning\n";

$mail->Subject = 'DZ - Experienced Jumper Details Submitted:'.$name;
$mail->Body    = nl2br($email2_content);

if(!$mail->send()) { 
    echo 'Message could not be sent.'; 
    echo 'Mailer Error: ' . $mail->ErrorInfo; 
} else { 
    echo 'Message 2 has been sent'; 
}

} // End Post
?>
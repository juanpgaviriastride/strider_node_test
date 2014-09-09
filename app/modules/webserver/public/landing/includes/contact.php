<?php
    phpinfo();
    require_once('simple_form_validator.php');

    // Only process POST reqeusts.
    if ($_SERVER["REQUEST_METHOD"] === "POST") {
        
        if(isset($_POST['beta_email'])) {
            // create an instance of the form validator
            $validator = new simple_fv;
            $field = array();

            // Get the form fields and remove whitespace.
            $email = filter_var(trim($_POST["beta_email"]), FILTER_SANITIZE_EMAIL);

            // set important data to field array
            $field[] = array('index'=>$email, 'label'=>'Your Email', 'type'=>'email');

            // validate the field
            $validator->formHandle($field);

            // get errors (if any)
            $error = $validator->getErrors();

            // if errors is FALSE - print the succesfull message
            if($error) {
                // Set a 400 (bad request) response code and exit.
                http_response_code(400);
                echo $error;
                exit;
            }
            else {
                // Get the fields back from the validator
                $fv = $validator->form_val;

                // set sender email address
                $email = $fv['beta_email'];

                // Set the recipient email address.
                $recipient = "alison.stump@contextaware.io";

                // Set the email subject.
                $subject = 'Context Surgery Beta';

                // Build the email content.
                $email_content = "Email: $email\n\n";

                // Build the email headers.
                $email_headers = "From: $email";

                // Send the email.
                if (mail($recipient, $subject, $email_content, $email_headers)) {
                    // Set a 200 (okay) response code.
                    http_response_code(200);
                    echo "Thank you for subscribing!";

                } else {
                    // Set a 500 (internal server error) response code.
                    http_response_code(500);
                    echo "We are sorry. Something went wrong and we subscribe you to our mailing list.";
                }
            }
        } else {
            // Set a 500 (internal server error) response code.
            http_response_code(500);
            echo "We are sorry. There was a problem with your request. Please make sure you entered a valid email.";
        }
    } else {
        // Not a POST request, set a 403 (forbidden) response code.
        http_response_code(403);
        echo "We are sorry. There was a problem with your request, please try again.";
    }

?>
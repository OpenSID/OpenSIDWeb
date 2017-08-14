<?php defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';
class MY_Controller extends REST_Controller {
  protected $result = array(
    'status' => 0,
    'content' => array()
  );
}
/* harus login dulu untuk bisa akses ke controller ini */
use \Firebase\JWT\JWT;
class Secure_Controller extends MY_Controller{
  protected $userData = array();
  public function __construct(){
    parent::__construct();
    $headers = $this->input->request_headers();
    try{
      if (array_key_exists('Authorization', $headers) && !empty($headers['Authorization'])) {
          $decodedToken = AUTHORIZATION::validateToken($headers['Authorization']);
          if ($decodedToken === false) {
              throw new Exception("Unauthorised", REST_Controller::HTTP_UNAUTHORIZED);
          }else{
            $this->userData = $decodedToken;
          }
      }else{
        throw new Exception("Unauthorised", REST_Controller::HTTP_UNAUTHORIZED);
      }
    }catch(Exception $e){
      $this->output->set_status_header($e->getCode());
      die(json_encode($e->getMessage()));
    }
  }

  protected function getUserData(){
    return $this->userData;
  }
}

class Web_Controller extends Secure_Controller{
    public function __construct(){
      parent::__construct();
    }
}

class Admin_Controller extends Secure_Controller{
    public function __construct(){
      parent::__construct();
    }
}

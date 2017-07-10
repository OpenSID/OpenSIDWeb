<?php defined('BASEPATH') OR exit('No direct script access allowed');

class First extends MY_Controller
{
    public function user_get(){
      $this->load->model('api/User_model','user');
      $output = $this->user->get_all();
      $this->set_response($output, REST_Controller::HTTP_OK);
    }
}

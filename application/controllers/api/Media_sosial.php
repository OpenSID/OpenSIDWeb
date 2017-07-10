<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Media_sosial extends MY_Controller
{

  public function list_get(){
    $this->load->model('api/Media_sosial_model','medsos');
    $_data = $this->medsos->get_all(array('enabled' => 1));
    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => array($_data)
    );
    $this->set_response($output, REST_Controller::HTTP_OK);
  }
}

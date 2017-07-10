<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Kategori extends MY_Controller
{

    public function list_get(){
      $this->load->model('api/Kategori_model','kategori');
      $_data = $this->kategori->get_all();
      $output = array(
        'status' => !empty($_data) ? 1 : 0,
        'content' => array($_data)
      );
      $this->set_response($output, REST_Controller::HTTP_OK);
    }

  
}

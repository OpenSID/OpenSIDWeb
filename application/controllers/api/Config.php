<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Config extends MY_Controller
{

    public function list_get(){
      $_data = $this->activeConfig();
      $output = array(
        'status' => !empty($_data) ? 1 : 0,
        'content' => array($_data)
      );
      $this->set_response($output, REST_Controller::HTTP_OK);
    }

    /** ambil data konfigurasi aplikasi
    */
    private function activeConfig(){
      $this->load->model('api/Config_model','cm');
      return $this->cm->get();
    }
}

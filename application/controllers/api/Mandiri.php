<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Mandiri extends Web_Controller
{
    public function __construct(){
      parent::__construct();
    }
    public function penduduk_get(){
      $credentialData = $this->userData->data;
      $this->load->model('api/Penduduk_model','apm');
      $this->result['content'] = $this->apm->get_by(array('nik' => $credentialData->nik));
      $this->result['status'] = 1;
      $this->set_response($this->result, REST_Controller::HTTP_OK);
    }
}

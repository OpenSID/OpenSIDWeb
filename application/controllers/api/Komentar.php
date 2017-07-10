<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Komentar extends MY_Controller
{

    public function list_get(){
      $this->load->model('api/Komentar_model','komentar');
      $limit = $this->get('limit');
      $limit = empty($limit) ? 10 : $limit;
      $_data = $this->komentar->limit($limit)->order_by('tgl_upload','desc')->get_all();
      $output = array(
        'status' => !empty($_data) ? 1 : 0,
        'content' => array($_data)
      );
      $this->set_response($output, REST_Controller::HTTP_OK);
    }
}

<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Menu extends MY_Controller
{
  /* konversi dari list_menu_atas*/
  public function list_get(){
    $this->load->model('api/Menu_model','menu');
    $_data = $this->menu->with('child',array(array('where'=>'enabled = 1 and tipe = 3')))
                        ->order_by('urut','asc')
                        ->get_all(array('parrent' => 1, 'tipe' => 1, 'enabled' => 1));

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }

}

<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Artikel extends MY_Controller
{
    public function artikel_get()
    {
        $this->load->model('Artikel_model','artikel');
        $output = $this->artikel->get_all();
        $this->set_response($output, REST_Controller::HTTP_OK);
    }
}

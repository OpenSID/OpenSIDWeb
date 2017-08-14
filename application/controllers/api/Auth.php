<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends MY_Controller
{
    private $key;
    private function setKey(){
        $this->key=$this->config->item('jwt_key');
    }
    /**
     * URL: http://localhost/CodeIgniter-JWT-Sample/auth/token
     * Method: GET
     */
    public function tokenMandiri_get()
    {

        $this->load->model('api/Penduduk_mandiri_model','pmm');
        $nik = $this->get('nik');
        $pin = $this->get('pin');
        $this->result['content'] = 'NIK tidak ditemukan';
        $dataWarga = $this->pmm->get($nik);
        if(!empty($dataWarga)){
          if($dataWarga->pin == hash_pin($pin)){
            $tokenData = array();
            $issueAt = time();
            $notBefore  = $issueAt + 3;
            $expire = $issueAt + 3600;/* expired satu jam */
            $tokenData = array(
                "iat" => $issueAt,
                "iss" => site_url(),
                "iat" => $issueAt,
                "nbf" => $notBefore,
                "exp" => $expire,
                "data" => array(
                  "nik" => $dataWarga->nik,
                  "id" => $dataWarga->id,
                  "isLogin" => 1
                )
            );
            $this->result['status'] = 1;
            $this->result['content'] = AUTHORIZATION::generateToken($tokenData);
          }else{
            $this->result['content'] = 'Pin yang anda masukkan tidak sesuai';
          }
        }
        $this->set_response($this->result, REST_Controller::HTTP_OK);
    }

    public function tokenSiteman_get()
    {
        $tokenData = array();
        $this->setKey();
        $tokenData = array(
            "iss" => "http://example.org",
            "aud" => "http://example.com",
            "iat" => 1356999524,
            "nbf" => 1357000000
        );
       // $output['token'] = AUTHORIZATION::generateToken($tokenData);
        $output['token'] = JWT::encode($tokenData, $this->key);
        $output['token2'] = JWT::decode($output['token'], $this->key, array('HS256'));
        $this->set_response($output, REST_Controller::HTTP_OK);
    }
}

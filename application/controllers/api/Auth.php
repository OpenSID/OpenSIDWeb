<?php

defined('BASEPATH') OR exit('No direct script access allowed');

class Auth extends MY_Controller
{
    private $key;
    private function setKey(){
        $this->key=$this->config->item('jwt_key');
    }
    /**
     * @api {get} /auth/tokenMandiri Mendapatkan token yang akan digunakan untuk mengakses data yang bersifat rahasia
     * @apiName GetToken
     * @apiGroup Authentication
     * @apiParam {String} nik nik warga unique ID.
     * @apiParam {String} pin pin warga, diperoleh setelah melakukan registrasi pada layanan mandiri.
     * @apiSuccessExample Success-Response:
     *     HTTP/1.1 200 OK
     *{
     *  "status": 1,
     *  "content": 	"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1MDMyNzk2MDMsImlzcyI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDgwXC9lZHNhLW9wZW5zaWR3ZWJcLyIsIm5iZiI6MTUwMzI3OTYwNiwiZXhwIjoxNTAzMjgzMjAzLCJkYXRhIjp7Im5payI6IjMyNzUwMTQ2MDE5NzcwMDUiLCJpc0xvZ2luIjoxfX0.vv-HTaHDVDHpVkgFccfl4-wqMzL080SlZIgHC-5qbmw"
     *}
     *
     * @apiError notFound nik tidak ditemukan atau pin salah
     *
     * @apiErrorExample Error-Response:
     *     HTTP/1.1 404 Not Found
     *     {
     *       "status": "0",
     *       "content" : []
     *     }
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
    /**
     * @api {post} /auth/tokenSiteman Mendapatkan token yang akan digunakan untuk mengakses data yang bersifat rahasia sebagai admin opensid
     * @apiName PostToken
     * @apiGroup Authentication
     * @apiParam {String} username username .
     * @apiParam {String} password password .
     * @apiSuccessExample Success-Response:
     *     HTTP/1.1 200 OK
     *{
     *  "status": 1,
     *  "content": 	"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1MDMyODIwMDcsImlzcyI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDgwXC9lZHNhLW9wZW5zaWR3ZWJcLyIsIm5iZiI6MTUwMzI4MjAxMCwiZXhwIjoxNTAzMjg1NjA3LCJkYXRhIjp7InNpdGVtYW4iOjEsInNlc2kiOiJhOGQ0MDgwMjQ1NjY0ZWQyMDQ5YzFiMmRlZDdjYWMzMCIsInVzZXIiOiIxIiwiZ3J1cCI6IjEiLCJpc0xvZ2luIjoxfX0.fPryREYUrtlZR8IoeywkynJZXqNke8_S1JM4CChlQKk"
     *}
     *
     * @apiError notFound username tidak ditemukan atau password salah
     *
     * @apiErrorExample Error-Response:
     *     HTTP/1.1 404 Not Found
     *     {
     *       "status": "0",
     *       "content" : []
     *     }
     */
    public function tokenSiteman_post()
    {
        $username = $this->post('username');
        $password = $this->post('password');
        $this->load->model('api/User_model','um');
        $userLogin = $this->um->allField()->get_by(array('username' => $username, 'active' => 1));

        if(!empty($userLogin)){
          if($userLogin->password == md5($password)){
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
                "siteman" => 1,
                'sesi' => $userLogin->session,
                'user' => $userLogin->id,
                'grup' => $userLogin->id_grup,
                "isLogin" => 1,
              )
            );
            $this->result['status'] = 1;
            $this->result['content'] = AUTHORIZATION::generateToken($tokenData);
          }else{
            $this->result['content'] = 'Password salah';
          }
        }else{
          $this->result['content'] = 'Username tidak ditemukan atau status tidak aktif';
        }
        $this->set_response($this->result, REST_Controller::HTTP_OK);
    }
}

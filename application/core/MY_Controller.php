<?php defined('BASEPATH') OR exit('No direct script access allowed');
require APPPATH . '/libraries/REST_Controller.php';
class MY_Controller extends REST_Controller {

}
/* harus login dulu untuk bisa akses ke controller ini */
class Secure_Controller extends MY_Controller{

}
<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Menu_model extends MY_Model
{
    protected $_table = 'menu';
    public $primary_key = 'id';


    function __construct()
  	{
      parent::__construct();
  		$this->has_many['sub_menu'] = array('model'=>'api/Menu_model','alias'=>'mm','primary_key'=>'parrent','where' => array('enabled' => '1','tipe'=>'3'));
  	}
}

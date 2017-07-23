<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Kategori_model extends MY_Model
{
    protected $_table = 'kategori';
    public $primary_key = 'id';

    function __construct()
  	{
      parent::__construct();
  		$this->has_many['child'] = array('model'=>'api/Kategori_model','alias'=>'ch','primary_key'=>'parrent');
      $this->has_many['menu_kiri'] = array('model'=>'api/Kategori_model','alias'=>'mk','primary_key'=>'parrent','where' => array('enabled' => '2'));
      $this->has_many['artikel'] = array('model'=>'api/Artikel_model','alias'=>'ar','primary_key'=>'id_kategori');
  	}
}

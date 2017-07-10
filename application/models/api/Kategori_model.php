<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Kategori_model extends MY_Model
{
    public $table = 'kategori';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
    function __construct()
  	{
      parent::__construct();
  		$this->has_many['child'] = array('foreign_model'=>'api/Kategori_model','foreign_table'=>'kategori','foreign_key'=>'parrent','local_key'=>'id');
      $this->has_many['artikel'] = array('foreign_model'=>'api/Artikel_model','foreign_table'=>'artikel','foreign_key'=>'id_kategori','local_key'=>'id');
  	}
}

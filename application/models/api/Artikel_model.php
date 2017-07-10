<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Artikel_model extends MY_Model
{
    public $table = 'artikel';
    public $primary_key = 'id';
    protected $timestamps = FALSE;

    function __construct()
  	{
      parent::__construct();
  		$this->has_one['user'] = array('foreign_model'=>'api/User_model','foreign_table'=>'user','foreign_key'=>'id','local_key'=>'id_user');
      $this->has_one['kategori'] = array('foreign_model'=>'api/Kategori_model','foreign_table'=>'kategori','foreign_key'=>'id','local_key'=>'id_kategori');
  	}
}

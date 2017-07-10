<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Menu_model extends MY_Model
{
    public $table = 'menu';
    public $primary_key = 'id';
    protected $timestamps = FALSE;

    function __construct()
  	{
      parent::__construct();
  		$this->has_many['child'] = array('foreign_model'=>'api/Menu_model','foreign_table'=>'menu','foreign_key'=>'parrent','local_key'=>'id');
  	}
}

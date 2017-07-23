<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Artikel_model extends MY_Model
{
    protected $_table = 'artikel';
    public $primary_key = 'id';
    function __construct()
  	{
      parent::__construct();
  		$this->belongs_to['author'] = array( 'model' => 'api/User_model', 'alias' => 'um', 'primary_key' => 'id_user' );
      $this->belongs_to['kategori'] = array( 'model' => 'api/Kategori_model', 'alias' => 'km', 'primary_key' => 'id_kategori' );
  	}
}

<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Menu_model extends MY_Model
{
    public $table = 'menu';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
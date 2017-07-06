<?php defined('BASEPATH') OR exit('No direct script access allowed');
class User_model extends MY_Model
{
    public $table = 'user';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
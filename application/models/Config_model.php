<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Config_model extends MY_Model
{
    public $table = 'config';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
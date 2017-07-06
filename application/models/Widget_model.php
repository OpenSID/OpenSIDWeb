<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Widget_model extends MY_Model
{
    public $table = 'widget';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
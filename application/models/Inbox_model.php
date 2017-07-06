<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Inbox_model extends MY_Model
{
    public $table = 'inbox';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
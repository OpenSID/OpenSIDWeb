<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Outbox_model extends MY_Model
{
    public $table = 'outbox';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
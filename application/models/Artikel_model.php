<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Artikel_model extends MY_Model
{
    public $table = 'artikel';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
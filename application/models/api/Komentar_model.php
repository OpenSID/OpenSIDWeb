<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Komentar_model extends MY_Model
{
    public $table = 'komentar';
    public $primary_key = 'id';
    protected $timestamps = FALSE;
}
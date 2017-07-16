<?php defined('BASEPATH') OR exit('No direct script access allowed');
class User_model extends MY_Model
{
    protected $_table = 'user';
    public $primary_key = 'id';
    protected $after_get = array('showField');
    protected $_hidden = array('username','password','session');

    public function showField($rows){
      $multi = $this->is_multidimensional($rows);
      $_rows = array();
      if($multi !== FALSE){
        foreach($rows as $row){
          array_push($_rows,$this->_showField($row));
        }
      }else{
        $_rows = $this->_showField($rows);
      }


      return $_rows;
    }
    private function _showField($row){
      if(is_array($row)){
        $_row = array();
        foreach($row as $_k => $_v){
          if(!in_array($_k,$this->_hidden)){
            $_row[$_k] = $row[$_k];
          }
        }
      }
      if(is_object($row)){
        $_row = new stdClass();
        foreach($row as $_k => $_v){
          if(!in_array($_k,$this->_hidden)){
            $_row->$_k = $row->$_k;
          }
        }
      }

      $row = $_row;
      return $row;
    }
}

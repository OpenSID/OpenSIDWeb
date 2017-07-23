<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Home extends CI_Controller{
	public $rest;
	public function __construct(){
		parent::__construct();
		$this->load->library('rest');
		$this->load->config('opensidws');
		$config_rest = $this->config->item('ws_opensid');
		$this->_initRest($config_rest);
	}

	private function _initRest($config = NULL){
		if(!empty($config)){
			$this->rest->initialize($config);
		}
	}

	public function index(){
		/* id artikel di hardcode dulu ya */
		$idArtikel = 62;
		$data = array(
			'menu' => $this->_getMenu(),
			'configDesa' => $this->_getConfig(),
			'artikel' => $this->_getDetailArtikel($idArtikel)
		);
		$this->load->view('ui/home',$data);
	}

	private function _getDetailArtikel($id){
		$_result = $this->rest->get('artikel/detail/id/'.$id);
		return $_result->content;

	}

	private function _getMenu(){
		$_result = $this->rest->get('menu/list',array(),'json');
		return $_result->content;
	}

	private function _getConfig(){
		$_result = $this->rest->get('config/list');
		return $_result->content[0];
	}

}

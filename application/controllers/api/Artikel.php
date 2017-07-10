<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Artikel extends MY_Controller
{
  /** content selalu berbentuk array 2 dimensi
  */
  public function headline_get(){
    $this->load->model('api/Artikel_model','artikel');
    $_data = $this->artikel->with('user')
                           ->order_by('tgl_upload','desc')
                           ->get(array('headline' => 1));
    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => array($_data)
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }
  /* konversi dari list_menu_kiri */
  public function kategori_get(){
    $this->load->model('api/Kategori_model','kategori');
    $_data = $this->kategori->with('child',array(array('where'=>'enabled = 2')))
                            ->order_by('urut','asc')->where('kategori', '!=','teks_berjalan')
                            ->get_all(array('parrent' => 0, 'enabled' => 1));

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }

  /* konversi dari teks_berjalan */
  public function teks_berjalan_get(){
    $this->load->model('api/Kategori_model','kategori');
    $_data = $this->kategori->with('artikel',array(array('where'=>'enabled = 1')))
                            ->order_by('urut','asc')
                            ->get_all(array('parrent' => 0, 'enabled' => 1, 'kategori' => 'teks_berjalan'));

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );
    $this->set_response($output, REST_Controller::HTTP_OK);
  }


  public function list_get(){
    $this->load->model('api/Artikel_model','artikel');
    $page = $this->get('page');
    $limit = $this->get('limit');
    $page = empty($page) ? 1 : $page;
    $limit = empty($limit) ? 1 : $limit;
    $_data = $this->artikel->order_by('tgl_upload','desc')
                            ->paginate($limit,NULL,$page);

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data,
      'page' => $this->artikel->all_pages
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }

  public function detail_get(){
    $this->load->model('api/Artikel_model','artikel');
    $id = $this->get('id');
    $_data = $this->artikel->with('user')->with('kategori')->get($id);

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }

}

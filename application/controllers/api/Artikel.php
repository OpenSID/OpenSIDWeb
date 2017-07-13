<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Artikel extends MY_Controller
{
  /**
 * @api {get} /artikel/headline Mengambil artikel yang dijadikan sebagai headline
 * @apiName GetHeadline
 * @apiGroup Artikel
 *
 * @apiSuccess {String} firstname Firstname of the User.
 * @apiSuccess {String} lastname  Lastname of the User.
 *
 * @apiSuccessExample Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *      "status": 1,
 *      "content": [
  *          {
  *            "id": "99",
  *          "gambar": "1472228892Raja Lombok 1902.jpg",
  *          "isi": "<p style=\"text-align: justify;\" align=\"center\">Sejarah telah mencatat bahwa Pulau Lombok pernah menjadi wilayah kekuasaan Kerajaan Karang Asem Bali yang berkedudukan di Cakranegara dengan seorang raja bernama Anak Agung Gde Jelantik. Berakhirnya <strong>kekuasaan</strong>
  *          "enabled": "1",
  *          "tgl_upload": "2016-08-26 15:38:09",
  *          "id_kategori": "999",
  *          "id_user": "1",
  *          "judul": "Sejarah Desa",
  *          "headline": "1",
  *          "gambar1": "1472229325490125_20121123041539.jpg",
  *          "gambar2": "1472197089",
  *          "gambar3": "1472197089",
  *          "dokumen": "",
  *          "link_dokumen": "",
  *          "urut": "0",
  *          "user": {
  *            "id": "1",
  *            "id_grup": "1",
  *            "email": "admin@combine.or.id",
  *            "last_login": "2017-05-01 13:04:01",
  *            "active": "1",
  *            "nama": "Administrator",
  *            "company": "ADMIN",
  *            "phone": "321",
  *            "foto": "favicon.png"
  *          }
  *        }
  *      ]
  *      }
 *
 * @apiError UserNotFound The id of the User was not found.
 *
 * @apiErrorExample Error-Response:
 *     HTTP/1.1 404 Not Found
 *     {
 *       "error": "UserNotFound"
 *     }
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
    $limit = empty($limit) ? 10 : $limit;
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

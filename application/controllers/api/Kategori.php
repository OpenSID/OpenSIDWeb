<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Kategori extends MY_Controller
{
  /**
   * @api {get} /kategori/list Mengambil semua kategori
   * @apiName GetKategori
   * @apiGroup Kategori
   *
   * @apiSuccessExample Success-Response:
   * HTTP/1.1 200 OK
   * {
   *   "status": 1,
   *   "content": [
   *  {
   *    "id": "1",
   *    "kategori": "Berita Desa",
   *    "tipe": "1",
   *    "urut": "1",
   *    "enabled": "1",
   *    "parrent": "0"
   *  },
   *  {
   *    "id": "2",
   *    "kategori": "Produk Desa",
   *    "tipe": "1",
   *    "urut": "3",
   *    "enabled": "2",
   *    "parrent": "0"
   *  },
   *  {
   *    "id": "22",
   *    "kategori": "teks_berjalan",
   *    "tipe": "1",
   *    "urut": "0",
   *    "enabled": "1",
   *    "parrent": "0"
   *  }
   *   ]
   *}
   *
   * @apiError kategori tidak ditemukan
   *
   * @apiErrorExample Error-Response:
   * HTTP/1.1 404 Not Found
   * {
   *   "status": "0",
   *   "content" : []
   * }
   */

  public function list_get(){
  $this->load->model('api/Kategori_model','kategori');
  $_data = $this->kategori->get_all();
  $output = array(
    'status' => !empty($_data) ? 1 : 0,
    'content' => $_data
  );
  $this->set_response($output, REST_Controller::HTTP_OK);
    }

    /**
 * @api {get} /kategori/list Mengambil kategori untuk dijadikan sebagai menu di sidebar kiri, konversi dari list_menu_kiri
 * @apiName GetKategori
 * @apiGroup Kategori
 *
 * @apiSuccessExample Success-Response:
 * HTTP/1.1 200 OK
 * {
 *  "status": 1,
 *  "content": [
 *{
 *   "id": "1",
 *   "kategori": "Berita Desa",
 *   "tipe": "1",
 *   "urut": "1",
 *   "enabled": "1",
 *   "parrent": "0",
 *   "menu_kiri": [
 *     {
 *       "id": "20",
 *       "kategori": "Berita Lokal",
 *       "tipe": "1",
 *       "urut": "0",
 *       "enabled": "2",
 *       "parrent": "1"
 *     },
 *     {
 *       "id": "21",
 *       "kategori": "Berita Kriminal",
 *       "tipe": "1",
 *       "urut": "0",
 *       "enabled": "2",
 *       "parrent": "1"
 *     }
 *   ]
 *  },
 *  {
 *   "id": "4",
 *   "kategori": "Agenda Desa",
 *   "tipe": "2",
 *   "urut": "2",
 *   "enabled": "1",
 *   "parrent": "0",
 *   "menu_kiri": []
 *   },
 *   {
 *   "id": "5",
 *   "kategori": "Peraturan Desa",
 *   "tipe": "2",
 *   "urut": "5",
 *   "enabled": "1",
 *   "parrent": "0",
 *   "menu_kiri": [
 *     {
 *       "id": "17",
 *       "kategori": "Peraturan Kebersihan Desa",
 *       "tipe": "1",
 *       "urut": "0",
 *       "enabled": "2",
 *       "parrent": "5"
 *     }
 *   ]
 *  }
 *  ]
 *  }
 *
 * @apiError sidebar tidak ditemukan
 *
 * @apiErrorExample Error-Response:
 * HTTP/1.1 404 Not Found
 * {
 *   "status": "0",
 *   "content" : []
 * }
 */

  public function sidebar_get(){
  $this->load->model('api/Kategori_model','kategori');
  $_data = $this->kategori->with('menu_kiri')
      ->order_by('urut','asc')//->where('kategori', '!=','teks_berjalan')
      ->get_many_by(array('parrent' => 0, 'enabled' => 1,'kategori != \'teks_berjalan\''));

  $output = array(
    'status' => !empty($_data) ? 1 : 0,
    'content' => $_data
  );

  $this->set_response($output, REST_Controller::HTTP_OK);
    }
}

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
 *          "author": {
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
 *        },
 *         {
 *           headline yang lain
 *        }
 *      ]
 *      }
 *
 * @apiError headline tidak ditemukan
 *
 * @apiErrorExample Error-Response:
 *     HTTP/1.1 404 Not Found
 *     {
 *       "status": "0",
 *       "content" : []
 *     }
 */
  public function headline_get(){
    $this->load->model('api/Artikel_model','artikel');
    $_data = $this->artikel->with('author')
                           ->order_by('tgl_upload','desc')
                           ->get_many_by(array('headline' => 1));
    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }
  /**
   * @api {get} /artikel/list/{page}/1/{limit}/10 Mengambil semua artikel
   * @apiName GetList
   * @apiGroup Artikel
   * @apiSuccessExample Success-Response:
   *     HTTP/1.1 200 OK
   * {
   *  "status": 1,
   *  "content": [
   *  {
   *   "id": "96",
   *   "gambar": "1472782915artikel-3-1.jpeg",
   *   "isi": "<p>Dalam rapat pembahasan komitmen perekrutan karyawan hotel pada tanggal </p>",
   *   "enabled": "1",
   *   "tgl_upload": "2016-08-24 13:55:10",
   *   "id_kategori": "4",
   *   "id_user": "1",
   *   "judul": "Rapat membangun Komitmen antara Karang Taruna Desa Senggigi dengan Taruna Hotel",
   *   "headline": "3",
   *   "gambar1": "1472018109IMG-20160824-WA0000.jpg",
   *   "gambar2": "1472018109",
   *   "gambar3": "1472018109",
   *   "dokumen": "",
   *   "link_dokumen": "",
   *   "urut": "0"
   *    },
   *    {
   *   "id": "95",
   *   "gambar": "1472782634galeri-1-1.jpg",
   *   "isi": "<p>Desa Senggigi ikut memeriahkan perayaan 17 Agustus 2016 sebagai hari jadi Indonesia yang ke 71 melalui kegiatan </p>",
   *   "enabled": "1",
   *   "tgl_upload": "2016-08-24 13:05:21",
   *   "id_kategori": "1",
   *   "id_user": "1",
   *   "judul": "Perayaan Hari Kemerdekaan 2016",
   *   "headline": "3",
   *   "gambar1": "1472782634galeri-1-2.jpeg",
   *   "gambar2": "1472015120",
   *   "gambar3": "1472015120",
   *   "dokumen": "",
   *   "link_dokumen": "",
   *   "urut": "0"
   *     }
   *    ]
   * }
   *
   * @apiError artikel tidak ditemukan
   *
   * @apiErrorExample Error-Response:
   *     HTTP/1.1 404 Not Found
   *     {
   *       "status": "0",
   *       "content" : []
   *     }
   */
  public function list_get(){
    $this->load->model('api/Artikel_model','artikel');
    $page = $this->get('page');
    $limit = $this->get('limit');
    $page = empty($page) ? 1 : $page;
    $limit = empty($limit) ? 10 : $limit;
    $offset = $page * $limit;
    $_data = $this->artikel->order_by('tgl_upload','desc')
                           ->limit($limit,$offset)
                           ->get_all();

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }
  /**
   * @api {get} /artikel/detail/{id}/96 Mengambil detail artikel berdasarkan id artikel
   * @apiName GetList
   * @apiGroup Artikel
   * @apiSuccessExample Success-Response:
   *     HTTP/1.1 200 OK
   * {
   *  "status": 1,
   *  "content": {
   *   "id": "96",
   *   "gambar": "1472782915artikel-3-1.jpeg",
   *   "isi": "<p>Dalam rapat pembahasan komitmen perekrutan karyawan hotel pada tanggal </p>",
   *   "enabled": "1",
   *   "tgl_upload": "2016-08-24 13:55:10",
   *   "id_kategori": "4",
   *   "id_user": "1",
   *   "judul": "Rapat membangun Komitmen antara Karang Taruna Desa Senggigi dengan Taruna Hotel",
   *   "headline": "3",
   *   "gambar1": "1472018109IMG-20160824-WA0000.jpg",
   *   "gambar2": "1472018109",
   *   "gambar3": "1472018109",
   *   "dokumen": "",
   *   "link_dokumen": "",
   *   "urut": "0",
   *   "author": {
   *    "id": "1",
   *    "id_grup": "1",
   *    "email": "admin@combine.or.id",
   *    "last_login": "2017-05-01 13:04:01",
   *    "active": "1",
   *    "nama": "Administrator",
   *    "company": "ADMIN",
   *    "phone": "321",
   *    "foto": "favicon.png"
   *   },
   *   "kategori": {
   *    "id": "1",
   *    "kategori": "Berita Desa",
   *    "tipe": "1",
   *    "urut": "1",
   *    "enabled": "1",
   *    "parrent": "0"
   *   }
   *    }
   * }
   *
   * @apiError detail artikel tidak ditemukan
   *
   * @apiErrorExample Error-Response:
   *     HTTP/1.1 404 Not Found
   *     {
   *       "status": "0",
   *       "content" : null
   *     }
   */
  public function detail_get(){
    $this->load->model('api/Artikel_model','artikel');
    $id = $this->get('id');
    $_data = $this->artikel->with('author')->with('kategori')->get($id);

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }

  /**
* @api {get} /artikel/teks_berjalan Mengambil artikel yang kategorinya adalah teks_berjalan
* @apiName GetTeksBerjalan
* @apiGroup Artikel
*
* @apiSuccessExample Success-Response:
* HTTP/1.1 200 OK
* {
*  "status": 1,
*  "content": [
*  {
*    "id": "22",
*    "kategori": "teks_berjalan",
*    "tipe": "1",
*    "urut": "0",
*    "enabled": "1",
*    "parrent": "0",
*    "artikel": [
*   {
*     "id": "100",
*     "gambar": "1473071921",
*     "isi": "<p>Ini contoh teks berjalan. Isi dengan tulisan yang menampilkan suatu ciri atau kegiatan penting di desa anda.</p>",
*     "enabled": "1",
*     "tgl_upload": "2016-09-05 10:38:41",
*     "id_kategori": "22",
*     "id_user": "1",
*     "judul": "Contoh teks berjalan",
*     "headline": "0",
*     "gambar1": "1473071921",
*     "gambar2": "1473071921",
*     "gambar3": "1473071921",
*     "dokumen": "",
*     "link_dokumen": "",
*     "urut": "0"
*   }
*    ]
*  }
*]
*  }
*
* @apiError teks berjalan tidak ditemukan
*
* @apiErrorExample Error-Response:
* HTTP/1.1 404 Not Found
* {
*   "status": "0",
*   "content" : []
* }
*/
public function teks_berjalan_get(){
$this->load->model('api/Kategori_model','kategori');
$_data = $this->kategori->with('artikel')
    ->order_by('urut','asc')
    ->get_many_by(array('parrent' => 0, 'enabled' => 1, 'kategori' => 'teks_berjalan'));

$output = array(
  'status' => !empty($_data) ? 1 : 0,
  'content' => $_data
);
$this->set_response($output, REST_Controller::HTTP_OK);
  }


}

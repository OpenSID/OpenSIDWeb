<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Komentar extends MY_Controller
{
  /**
* @api {get} /komentar/list/{limit}/{10} Mengambil daftar komentar
* @apiName GetKomentar
* @apiGroup Artikel
*
* @apiSuccessExample Success-Response:
* HTTP/1.1 200 OK
* {
*  "status": 1,
* "content": [
* {
 *    "id": "11",
 *    "id_artikel": "775",
 *    "owner": "DENATUL SUARTINI",
 *    "email": "3275014601977005",
 *    "komentar": "Laporan ini tidak relevan. Hanya berisi komentar saja.",
 *    "tgl_upload": "2016-09-14 11:05:02",
 *    "enabled": "2"
 *   },
 * {
 *    "id": "10",
 *    "id_artikel": "775",
 *    "owner": "DENATUL SUARTINI",
 *    "email": "3275014601977005",
 *    "komentar": "Saya ke kantor desa kemarin jam 12:30 siang, tetapi tidak ada orang. Anak kami akan pergi ke Yogyakarta untuk kuliah selama 4 tahun. Apakah perlu kami laporkan?",
 *    "tgl_upload": "2016-09-14 10:49:34",
 *    "enabled": "2"
 *   },
 * {
 *    "id": "9",
 *    "id_artikel": "775",
 *    "owner": "AHMAD ALLIF RIZKI",
 *    "email": "5201140706966997",
 *    "komentar": "Harap alamat keluarga kami diperbaik menjadi RT 002 Dusun Mangsit. \n\nTerima kasih.",
 *    "tgl_upload": "2016-09-14 07:44:59",
 *    "enabled": "1"
 *   },
 * {
 *    "id": "8",
 *    "id_artikel": "95",
 *    "owner": "Penduduk Biasa",
 *    "email": "penduduk@desaku.desa.id",
 *    "komentar": "Selamat atas keberhasilan Senggigi merayakan Hari Kemerdeakaan 2016!",
 *    "tgl_upload": "2016-09-14 06:09:16",
 *    "enabled": "1"
 *   }
 * ]
*  }
*
* @apiError komentar tidak ditemukan
*
* @apiErrorExample Error-Response:
* HTTP/1.1 404 Not Found
* {
*   "status": "0",
*   "content" : null
* }
*/
    public function list_get(){
      $this->load->model('api/Komentar_model','komentar');
      $limit = $this->get('limit');
      $limit = empty($limit) ? 10 : $limit;
      $_data = $this->komentar->limit($limit)->order_by('tgl_upload','desc')->get_all();
      $output = array(
        'status' => !empty($_data) ? 1 : 0,
        'content' => $_data
      );
      $this->set_response($output, REST_Controller::HTTP_OK);
    }
    /**
  * @api {get} /komentar/artikel/id_artikel/{id_artikel}/{limit}/{10} Mengambil daftar komentar berdasarkan artikel tertentu
  * @apiName GetKomentarArtikel
  * @apiGroup Artikel
  *
  * @apiSuccessExample Success-Response:
  * HTTP/1.1 200 OK
  * {
  *  "status": 1,
  *"content": [
  *   {
  *    "id": "8",
  *    "id_artikel": "95",
  *    "owner": "Penduduk Biasa",
  *    "email": "penduduk@desaku.desa.id",
  *    "komentar": "Selamat atas keberhasilan Senggigi merayakan Hari Kemerdeakaan 2016!",
  *    "tgl_upload": "2016-09-14 06:09:16",
  *    "enabled": "1"
  *   }
  * ]
  *  }
  *
  * @apiError komentar tidak ditemukan
  *
  * @apiErrorExample Error-Response:
  * HTTP/1.1 404 Not Found
  * {
  *   "status": "0",
  *   "content" : null
  * }
  */
      public function artikel_get(){
        $this->load->model('api/Komentar_model','komentar');
        $id_artikel = $this->get('id_artikel');
        $limit = $this->get('limit');
        $limit = empty($limit) ? 10 : $limit;
        $_data = $this->komentar->limit($limit)->order_by('tgl_upload','desc')->get_many_by(array('id_artikel' => $id_artikel));
        $output = array(
          'status' => !empty($_data) ? 1 : 0,
          'content' => $_data
        );
        $this->set_response($output, REST_Controller::HTTP_OK);
      }
}

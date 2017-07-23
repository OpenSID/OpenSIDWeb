<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Config extends MY_Controller
{
  /**
   * @api {get} /config/list Mengambil konfigurasi untuk opensid
   * @apiName GetList
   * @apiGroup Config
   * @apiSuccessExample Success-Response:
   *     HTTP/1.1 200 OK
   *{
   *  "status": 1,
   *  "content": [
   *      {
   *      "id": "1",
   *      "nama_desa": "Senggigi ",
   *      "kode_desa": "05",
   *      "nama_kepala_desa": "Muhammad Ilham ",
   *      "nip_kepala_desa": "--",
   *      "kode_pos": "83355",
   *      "nama_kecamatan": "Batulayar ",
   *      "kode_kecamatan": "14",
   *      "nama_kepala_camat": "Bambang Budi Sanyoto, S. H",
   *      "nip_kepala_camat": "-",
   *      "nama_kabupaten": "Lombok Barat ",
   *      "kode_kabupaten": "01",
   *      "nama_propinsi": "NTB ",
   *      "kode_propinsi": "52",
   *      "logo": "LogoSenggigi100x100.png",
   *      "lat": "-8.488005310891758",
   *      "lng": "116.0406072534065",
   *      "zoom": "19",
   *      "map_tipe": "hybrid",
   *      "path": "(-7.8312189550359586, 110.2565517439507);(-7.8676102927000695, 110.25380516191944);(-7.843803235881495, 110.29843711992726);(-7.831899196157655, 110.36504173418507);(-7.8169336350355465, 110.32933616777882);(-7.8169336350355465, 110.29775047441944);",
   *      "alamat_kantor": "Jl. Raya Senggigi Km 10 Kerandangan ",
   *      "g_analytic": "gsgsdgsdgsg"
   *       }
   *    ]
   *}
   *
   * @apiError config tidak ditemukan
   *
   * @apiErrorExample Error-Response:
   *     HTTP/1.1 404 Not Found
   *     {
   *       "status": "0",
   *       "content" : []
   *     }
   */
    public function list_get(){
      $_data = $this->activeConfig();
      $output = array(
        'status' => !empty($_data) ? 1 : 0,
        'content' => $_data
      );
      $this->set_response($output, REST_Controller::HTTP_OK);
    }

    /** ambil data konfigurasi aplikasi
    */
    private function activeConfig(){
      $this->load->model('api/Config_model','cm');
      return $this->cm->get_all();
    }
}

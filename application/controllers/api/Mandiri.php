<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Mandiri extends Web_Controller
{
    public function __construct(){
      parent::__construct();
    }
    /**
     * @api {get} /mandiri/pribadi mendapatkan data pribadi penduduk untuk layanan mandiri
     * @apiName GetMandiri
     * @apiGroup Layanan Mandiri
     * @apiHeader {String} Authorization Token yang didapatkan dari menu auth/tokenMandiri.
     * @apiSuccessExample Success-Response:
     * HTTP/1.1 200 OK
     * {"status":1,
     * "content":
     *    {"id":"20","nama":"DENATUL SUARTINI","nik":"3275014601977005","id_kk":"7","kk_level":"3","id_rtm":"0","rtm_level":"0","sex":"2","tempatlahir":"JAKARTA","tanggallahir":"1996-01-06","agama_id":"1","pendidikan_kk_id":"5","pendidikan_id":"0","pendidikan_sedang_id":"18","pekerjaan_id":"2","status_kawin":"2","warganegara_id":"1","dokumen_pasport":null,"dokumen_kitas":null,"ayah_nik":"","ibu_nik":"","nama_ayah":"G. AMIN. P","nama_ibu":"NGATI","foto":"","golongan_darah_id":"13","id_cluster":"16","status":"1","alamat_sebelumnya":"","alamat_sekarang":"","status_dasar":"1","hamil":null,"cacat_id":null,"sakit_menahun_id":"0","akta_lahir":"","akta_perkawinan":"","tanggalperkawinan":null,"akta_perceraian":"","tanggalperceraian":null,"cara_kb_id":null,"no_kk_sebelumnya":null,"telepon":null,"tanggal_akhir_paspor":null}}
     *
     * @apiError Unauthorized token tidak valid
     *
     * @apiErrorExample Error-Response:
     * HTTP/1.1 401 Unauthorized
     * {
     *   Unauthorized
     * }
     */
    public function pribadi_get(){
      $credentialData = $this->userData->data;
      $this->load->model('api/Penduduk_model','apm');
      $this->result['content'] = $this->apm->get_by(array('nik' => $credentialData->nik));
      $this->result['status'] = 1;
      $this->set_response($this->result, REST_Controller::HTTP_OK);
    }
}

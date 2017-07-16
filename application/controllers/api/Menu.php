<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Menu extends MY_Controller
{
  /**
* @api {get} /menu/list Mengambil daftar menu
* @apiName GetMenu
* @apiGroup Menu
*
* @apiSuccessExample Success-Response:
* HTTP/1.1 200 OK
* {
*  "status": 1,
* "content": [
*     {
*       "id": "16",
*       "nama": "Profil Desa",
*       "link": "artikel/32",
*       "tipe": "1",
*       "parrent": "1",
*       "link_tipe": "1",
*       "enabled": "1",
*       "urut": null,
*       "sub_menu": [
*         {
 *       "id": "55",
 *       "nama": "Profil Wilayah Desa",
 *       "link": "artikel/33",
 *       "tipe": "3",
 *       "parrent": "16",
 *       "link_tipe": "1",
 *       "enabled": "1",
 *       "urut": null
*         },
*         {
 *       "id": "114",
 *       "nama": "Sejarah Desa",
 *       "link": "artikel/99",
 *       "tipe": "3",
 *       "parrent": "16",
 *       "link_tipe": "0",
 *       "enabled": "1",
 *       "urut": null
*         }
*       ]
*     },
*     {
*       "id": "17",
*       "nama": "Pemerintahan Desa",
*       "link": "artikel/85",
*       "tipe": "1",
*       "parrent": "1",
*       "link_tipe": "1",
*       "enabled": "1",
*       "urut": null,
*       "sub_menu": [
*         {
 *       "id": "57",
 *       "nama": "Visi dan Misi",
 *       "link": "artikel/93",
 *       "tipe": "3",
 *       "parrent": "17",
 *       "link_tipe": "0",
 *       "enabled": "1",
 *       "urut": null
*         },
*         {
 *       "id": "58",
 *       "nama": "Pemerintah Desa",
 *       "link": "artikel/92",
 *       "tipe": "3",
 *       "parrent": "17",
 *       "link_tipe": "0",
 *       "enabled": "1",
 *       "urut": null
*         }
*       ]
*     }
*   ]
*  }
*
* @apiError menu tidak ditemukan
*
* @apiErrorExample Error-Response:
* HTTP/1.1 404 Not Found
* {
*   "status": "0",
*   "content" : null
* }
*/
  public function list_get(){
    $this->load->model('api/Menu_model','menu');
    $_data = $this->menu->with('sub_menu')
                        ->order_by('urut','asc')
                        ->get_many_by(array('parrent' => 1, 'tipe' => 1, 'enabled' => 1));

    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );

    $this->set_response($output, REST_Controller::HTTP_OK);
  }

}

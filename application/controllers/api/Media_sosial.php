<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Media_sosial extends MY_Controller
{
  /**
* @api {get} /media_sosial/list Mengambil daftar media sosial
* @apiName GetMediaSosial
* @apiGroup MediaSosial
*
* @apiSuccessExample Success-Response:
* HTTP/1.1 200 OK
* {
*  "status": 1,
*"content": [
*{
*   "id": "1",
*   "gambar": "fb.png",
*   "link": "https://www.facebook.com/groups/OpenSID/",
*   "nama": "Facebook",
*   "enabled": "1"
*},
*{
*   "id": "2",
*   "gambar": "twt.png",
*   "link": "",
*   "nama": "Twitter",
*   "enabled": "1"
*},
*{
*   "id": "3",
*   "gambar": "goo.png",
*   "link": "",
*   "nama": "Google Plus",
*   "enabled": "1"
*}
* ]
*  }
*
* @apiError media sosial tidak ditemukan
*
* @apiErrorExample Error-Response:
* HTTP/1.1 404 Not Found
* {
*   "status": "0",
*   "content" : null
* }
*/

  public function list_get(){
    $this->load->model('api/Media_sosial_model','medsos');
    $_data = $this->medsos->get_many_by(array('enabled' => 1));
    $output = array(
      'status' => !empty($_data) ? 1 : 0,
      'content' => $_data
    );
    $this->set_response($output, REST_Controller::HTTP_OK);
  }
}

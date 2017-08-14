<?php defined('BASEPATH') OR exit('No direct script access allowed');

class Token extends MY_Controller
{
/**
 * @api {get} /token/headline Mengambil token yang digunakan untuk mengakses halaman yang secure
 * @apiName GetTokenMandiri
 * @apiGroup Token
 * @apiParam {string} nik
 * @apiParam {string} pin
 * @apiSuccessExample Success-Response:
 *     HTTP/1.1 200 OK
 *     {
 *      "status": 1,
 *      "content": 78789fdsfafasfasfasfdasfadfasf
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

  public function mandiri_get(){
    $this->load->model('api/Penduduk_mandiri_model','pmm');
    $username = $this->get('nik');
    $password = $this->get('pin');
    $_data = $this->pmm->
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

require_once('vendor/autoload.php');
use \Firebase\JWT\JWT;
define('SECRET_KEY','Your-Secret-Key')  /// secret key can be a random string and keep in secret from anyone
define('ALGORITHM','HS512')   // Algorithm used to sign the token, see
                               https://tools.ietf.org/html/draft-ietf-jose-json-web-algorithms-40#section-3
//// Suppose you have submitted your form data here with username and password
$action = $_REQUEST['action']
if ($username && $password && $action == 'login' ) {


                // if there is no error below code run
		$statement = $config->prepare("select * from login where name = :name" );
                $statement->execute(array(':name' => $_POST['username'])));
		$row = $statement->fetchAll(PDO::FETCH_ASSOC);
                $hashAndSalt = password_hash($password, PASSWORD_BCRYPT);
		if(count($row)>0 && password_verify($row[0]['password'],$hashAndSalt))
		{

                    $tokenId    = base64_encode(mcrypt_create_iv(32));
                    $issuedAt   = time();
                    $notBefore  = $issuedAt + 10;  //Adding 10 seconds
                    $expire     = $notBefore + 7200; // Adding 60 seconds
                    $serverName = 'http://localhost/php-json/'; /// set your domain name


                    /*
                     * Create the token as an array
                     */
                    $data = [
                        'iat'  => $issuedAt,         // Issued at: time when the token was generated
                        'jti'  => $tokenId,          // Json Token Id: an unique identifier for the token
                        'iss'  => $serverName,       // Issuer
                        'nbf'  => $notBefore,        // Not before
                        'exp'  => $expire,           // Expire
                        'data' => [                  // Data related to the logged user you can set your required data
				    'id'   => $row[0]['id'], // id from the users table
				     'name' => $row[0]['name'], //  name
                                  ]
                    ];
                  $secretKey = base64_decode(SECRET_KEY);
                  /// Here we will transform this array into JWT:
                  $jwt = JWT::encode(
                            $data, //Data to be encoded in the JWT
                            $secretKey, // The signing key
                             ALGORITHM
                           );
                 $unencodedArray = ['jwt' => $jwt];
                  echo  "{'status' : 'success','resp':".json_encode($unencodedArray)."}"
           } else {

                  echo  "{'status' : 'error','msg':'Invalid email or passowrd'}"

                  }

     }

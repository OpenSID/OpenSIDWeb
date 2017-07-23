<?php defined('BASEPATH') OR exit('No direct script access allowed');
class Generate extends CI_Controller
{
    public function create_model($nama_table = NULL){
        if($nama_table == 'artikel' || $nama_table == 'user') return 1;
        $data = array(
          'table' => $nama_table,
          'classname' => ucfirst($nama_table).'_model',
        );
        $output_file = APPPATH.'api2/models/'.ucfirst($nama_table).'_model.php';
        $source = $this->load->view('template_model',$data,TRUE);
        $fp = fopen($output_file,'w+');
        fwrite($fp,"<?php defined('BASEPATH') OR exit('No direct script access allowed');\n");
        fwrite($fp,$source);
        fclose($fp);
    }

    public function create_all_model(){
      $tables = $this->db->list_tables();
      foreach ($tables as $table)
      {
        $this->create_model($table);
      }
    }
}

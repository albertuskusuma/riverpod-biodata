<?php
defined('BASEPATH') OR exit('No direct script access allowed');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: POST, GET, DELETE, PUT, PATCH, OPTIONS');
    header('Access-Control-Allow-Headers: token, Content-Type');
    header('Access-Control-Max-Age: 1728000');
    header('Content-Length: 0');
    header('Content-Type: text/plain');
    die();
}

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');


class Belajarbiodata extends CI_Controller {

	/**
	 * Index Page for this controller.
	 *
	 * Maps to the following URL
	 * 		http://example.com/index.php/welcome
	 *	- or -
	 * 		http://example.com/index.php/welcome/index
	 *	- or -
	 * Since this controller is set as the default controller in
	 * config/routes.php, it's displayed at http://example.com/
	 *
	 * So any other public methods not prefixed with an underscore will
	 * map to /index.php/welcome/<method_name>
	 * @see https://codeigniter.com/user_guide/general/urls.html
	 */

	public function list_biodata()
	{
		$sql = "select * from belajar_biodata where is_delete = 0";
        $data = $this->db->query($sql);

        if($data->num_rows() > 0){
            echo json_encode(array(
                'status'=>"OK",
                'data'=>$data->result_array(),
                'message'=>'Data Ada'
            ));
        }else{
            echo json_encode(array(
                'status'=>"ERR",
                'data'=>[],
                'message'=>'Data Tidak Ada'
            ));
        }
	}

    public function add_biodata()
    {
        $nama = $_POST['nama'];
        $umur = $_POST['umur'];
        $jenis_kelamin = $_POST['jenis_kelamin'];
        $alamat = $_POST['alamat'];
        $hobi = $_POST['hobi'];

        $sql = "INSERT INTO belajar_biodata(nama, umur, jenis_kelamin, alamat, hobi, is_delete) VALUES(
            '$nama','$umur','$jenis_kelamin','$alamat','$hobi',0)
        )";

        $i = $this->db->query($sql);
        if($i){
            $sql_select = "select * from belajar_biodata where is_delete = 0";
            $data = $this->db->query($sql_select);
            echo json_encode(array(
                'status'=>"OK",
                'data'=>$data->result_array(),
                'message'=>'Data Berhasil di Insert'
            ));
        }else{
            echo json_encode(array(
                'status'=>"ERR",
                'data'=>[],
                'message'=>'gagal insert'
            ));
        }
    }
}

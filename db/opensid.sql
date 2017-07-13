-- Adminer 4.3.1 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

DROP TABLE IF EXISTS `analisis_indikator`;
CREATE TABLE `analisis_indikator` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_master` int(11) NOT NULL,
  `nomor` int(3) NOT NULL,
  `pertanyaan` varchar(400) NOT NULL,
  `id_tipe` tinyint(4) NOT NULL DEFAULT '1',
  `bobot` tinyint(4) NOT NULL DEFAULT '0',
  `act_analisis` tinyint(1) NOT NULL DEFAULT '2',
  `id_kategori` tinyint(4) NOT NULL,
  `is_publik` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_master` (`id_master`,`id_tipe`),
  KEY `id_tipe` (`id_tipe`),
  KEY `id_kategori` (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_indikator` (`id`, `id_master`, `nomor`, `pertanyaan`, `id_tipe`, `bobot`, `act_analisis`, `id_kategori`, `is_publik`) VALUES
(1,	2,	1,	'kepemilikan rumah',	1,	1,	1,	1,	0),
(2,	2,	2,	'penghasilan perbulan',	1,	4,	1,	2,	0);

DROP TABLE IF EXISTS `analisis_kategori_indikator`;
CREATE TABLE `analisis_kategori_indikator` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `id_master` tinyint(4) NOT NULL,
  `kategori` varchar(50) NOT NULL,
  `kategori_kode` varchar(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_master` (`id_master`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_kategori_indikator` (`id`, `id_master`, `kategori`, `kategori_kode`) VALUES
(1,	2,	'Aset',	''),
(2,	2,	'Penghasilan',	'');

DROP TABLE IF EXISTS `analisis_klasifikasi`;
CREATE TABLE `analisis_klasifikasi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_master` int(11) NOT NULL,
  `nama` varchar(20) NOT NULL,
  `minval` double(5,2) NOT NULL,
  `maxval` double(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_master` (`id_master`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_klasifikasi` (`id`, `id_master`, `nama`, `minval`, `maxval`) VALUES
(1,	2,	'Miskin',	5.00,	10.00),
(2,	2,	'Sedang',	11.00,	20.00),
(3,	2,	'Kaya',	21.00,	25.00);

DROP TABLE IF EXISTS `analisis_master`;
CREATE TABLE `analisis_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(40) NOT NULL,
  `subjek_tipe` tinyint(4) NOT NULL,
  `lock` tinyint(1) NOT NULL DEFAULT '1',
  `deskripsi` text NOT NULL,
  `kode_analisis` varchar(5) NOT NULL DEFAULT '00000',
  `id_kelompok` int(11) NOT NULL,
  `pembagi` varchar(10) NOT NULL DEFAULT '100',
  `id_child` smallint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_master` (`id`, `nama`, `subjek_tipe`, `lock`, `deskripsi`, `kode_analisis`, `id_kelompok`, `pembagi`, `id_child`) VALUES
(1,	'Analisis Keahlian Individu',	1,	1,	'<p>survey</p>',	'00000',	0,	'1',	0),
(2,	'AKP Lombok Tengah',	2,	1,	'<p>keterangan</p>',	'00000',	0,	'1',	0);

DROP TABLE IF EXISTS `analisis_parameter`;
CREATE TABLE `analisis_parameter` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_indikator` int(11) NOT NULL,
  `jawaban` varchar(200) NOT NULL,
  `nilai` tinyint(4) NOT NULL DEFAULT '0',
  `kode_jawaban` int(3) NOT NULL,
  `asign` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `id_indikator` (`id_indikator`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_parameter` (`id`, `id_indikator`, `jawaban`, `nilai`, `kode_jawaban`, `asign`) VALUES
(1,	1,	'milik sendiri',	5,	0,	0),
(2,	1,	'milik orang tua',	4,	0,	0),
(3,	1,	'kontrak',	1,	0,	0),
(4,	2,	'< Rp.500.000,-',	1,	0,	0),
(5,	2,	'Rp 500.000,- sampa Rp 1.000.000,-',	3,	0,	0),
(6,	2,	'diatas Rp 2.000.000,-',	5,	0,	0);

DROP TABLE IF EXISTS `analisis_partisipasi`;
CREATE TABLE `analisis_partisipasi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_subjek` int(11) NOT NULL,
  `id_master` int(11) NOT NULL,
  `id_periode` int(11) NOT NULL,
  `id_klassifikasi` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `id_subjek` (`id_subjek`,`id_master`,`id_periode`,`id_klassifikasi`),
  KEY `id_master` (`id_master`),
  KEY `id_periode` (`id_periode`),
  KEY `id_klassifikasi` (`id_klassifikasi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `analisis_periode`;
CREATE TABLE `analisis_periode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_master` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `id_state` tinyint(4) NOT NULL DEFAULT '1',
  `aktif` tinyint(1) NOT NULL DEFAULT '0',
  `keterangan` varchar(100) NOT NULL,
  `tahun_pelaksanaan` year(4) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_master` (`id_master`),
  KEY `id_state` (`id_state`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_periode` (`id`, `id_master`, `nama`, `id_state`, `aktif`, `keterangan`, `tahun_pelaksanaan`) VALUES
(1,	2,	'Pendataan 2014',	2,	2,	'ket',	'2014'),
(2,	2,	'Pendataan 2015',	1,	1,	'nnn',	'2015');

DROP TABLE IF EXISTS `analisis_ref_state`;
CREATE TABLE `analisis_ref_state` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `analisis_ref_state` (`id`, `nama`) VALUES
(1,	'Belum Entri / Pendataan'),
(2,	'Sedang Dalam Pendataan'),
(3,	'Selesai Entri / Pendataan');

DROP TABLE IF EXISTS `analisis_ref_subjek`;
CREATE TABLE `analisis_ref_subjek` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `subjek` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `analisis_ref_subjek` (`id`, `subjek`) VALUES
(1,	'Penduduk'),
(2,	'Keluarga / KK'),
(3,	'Rumah Tangga'),
(4,	'Kelompok');

DROP TABLE IF EXISTS `analisis_respon`;
CREATE TABLE `analisis_respon` (
  `id_indikator` int(11) NOT NULL,
  `id_parameter` int(11) NOT NULL,
  `id_subjek` int(11) NOT NULL,
  `id_periode` int(11) NOT NULL,
  KEY `id_parameter` (`id_parameter`,`id_subjek`),
  KEY `id_periode` (`id_periode`),
  KEY `id_indikator` (`id_indikator`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_respon` (`id_indikator`, `id_parameter`, `id_subjek`, `id_periode`) VALUES
(1,	1,	129,	1),
(2,	6,	129,	1),
(1,	3,	254,	1),
(2,	4,	254,	1),
(1,	1,	298,	1),
(2,	5,	298,	1),
(1,	1,	304,	1),
(2,	5,	304,	1),
(1,	3,	308,	1),
(2,	6,	308,	1),
(1,	1,	309,	1),
(2,	4,	309,	1),
(1,	3,	129,	2),
(2,	4,	129,	2),
(1,	1,	254,	2),
(2,	6,	254,	2),
(1,	2,	298,	2),
(2,	6,	298,	2),
(1,	3,	304,	2),
(2,	6,	304,	2),
(1,	2,	308,	2),
(2,	6,	308,	2),
(1,	3,	309,	2),
(2,	6,	309,	2);

DROP TABLE IF EXISTS `analisis_respon_bukti`;
CREATE TABLE `analisis_respon_bukti` (
  `id_master` tinyint(4) NOT NULL,
  `id_periode` tinyint(4) NOT NULL,
  `id_subjek` int(11) NOT NULL,
  `pengesahan` varchar(100) NOT NULL,
  `tgl_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `analisis_respon_hasil`;
CREATE TABLE `analisis_respon_hasil` (
  `id_master` tinyint(4) NOT NULL,
  `id_periode` tinyint(4) NOT NULL,
  `id_subjek` int(11) NOT NULL,
  `akumulasi` double(8,3) NOT NULL,
  `tgl_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  UNIQUE KEY `id_master` (`id_master`,`id_periode`,`id_subjek`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_respon_hasil` (`id_master`, `id_periode`, `id_subjek`, `akumulasi`, `tgl_update`) VALUES
(2,	1,	129,	25.000,	'2017-04-01 23:27:28'),
(2,	1,	254,	5.000,	'2017-04-01 23:27:28'),
(2,	1,	298,	17.000,	'2017-04-01 23:27:28'),
(2,	1,	304,	17.000,	'2017-04-01 23:27:28'),
(2,	1,	308,	21.000,	'2017-04-01 23:27:28'),
(2,	1,	309,	9.000,	'2017-04-01 23:27:28'),
(2,	2,	129,	5.000,	'2017-04-01 23:27:28'),
(2,	2,	254,	25.000,	'2017-04-01 23:27:28'),
(2,	2,	298,	24.000,	'2017-04-01 23:27:28'),
(2,	2,	304,	21.000,	'2017-04-01 23:27:28'),
(2,	2,	308,	24.000,	'2017-04-01 23:27:28'),
(2,	2,	309,	21.000,	'2017-04-01 23:27:28');

DROP TABLE IF EXISTS `analisis_tipe_indikator`;
CREATE TABLE `analisis_tipe_indikator` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `tipe` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `analisis_tipe_indikator` (`id`, `tipe`) VALUES
(1,	'Pilihan (Tunggal)'),
(2,	'Pilihan (Multivalue)'),
(3,	'Isian Angka'),
(4,	'Isian Tulisan');

DROP TABLE IF EXISTS `area`;
CREATE TABLE `area` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `path` text NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '1',
  `ref_polygon` int(9) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `id_cluster` int(11) NOT NULL,
  `desk` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `artikel`;
CREATE TABLE `artikel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gambar` varchar(200) DEFAULT NULL,
  `isi` text NOT NULL,
  `enabled` int(2) NOT NULL DEFAULT '1',
  `tgl_upload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_kategori` int(4) NOT NULL,
  `id_user` int(4) NOT NULL,
  `judul` varchar(100) NOT NULL,
  `headline` int(1) NOT NULL DEFAULT '0',
  `gambar1` varchar(200) NOT NULL,
  `gambar2` varchar(200) DEFAULT NULL,
  `gambar3` varchar(200) DEFAULT NULL,
  `dokumen` varchar(400) NOT NULL,
  `link_dokumen` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `artikel` (`id`, `gambar`, `isi`, `enabled`, `tgl_upload`, `id_kategori`, `id_user`, `judul`, `headline`, `gambar1`, `gambar2`, `gambar3`, `dokumen`, `link_dokumen`) VALUES
(7,	'',	'<p><strong>Awal mula SID</strong><br /> \"Awalnya ada keinginan dari pemerintah Desa Balerante yang berharap pelayanan pemerintah desa bisa seperti pengunjung rumah sakit yang ingin mencari data pasien rawat inap, tinggal ketik nama di komputer, maka data tersebut akan keluar\"<br /> (Mart Widarto, pengelola Program Lumbung Komunitas)<br /> Program ini mulai dibuat dari awal 2006: <br /> 1. (2006) komunitas melakukan komunikasi dan diskusi lepas tentang sebuah sistem yang bisa digunakan untuk menyimpan data.<br /> 2. (2008) Rangkaian FDG dengan pemerintah desa membahas tentang tata kelola pendokumentasian di desa<br /> 3. (2009) Ujicoba SID yang sudah dikembangkan di balerante<br /> 4. (2009-2010) Membangun SID (aplikasi) dibeberapa desa yang lain: terong (bantul), Nglegi (Gunungkidul) <br /> 5. (2011) Kandangan (Temanggung) Gilangharjo (bantul) Girikarto (gunungkidul) Talun (klaten) Pager Gunung (magelang) <br /> 6. hingga saat ini 2013 sudah banyak desa pengguna SID.<br /> <br /> <strong>SID sebagai tanggapan atas kebutuhan:</strong><br /> Kalau dulu untuk mencari data penduduk menurut kelompok umur saja kesulitan karena tidak mempunyai databasenya. Dengan adanya SID menjadi lebih mudah.<br /> (Nuryanto, Kabag Pelayanan Pemdes Terong)<br /> <br /> Membangun sebuah sistem bukan hanya membuatkan software dan meninggalkan begitu saja, namun ada upaya untuk memadukan sistem dengan kebutuhan yang ada pada desa. sehingga software dapat memenuhi kebutuhan yang telah ada bukan memaksakan desa untuk mengikuti dan berpindah sistem. inilah yang melatari combine melaksanakan alur pengaplikasian software.<br /> 1. Bentuk tim kerja bersama pemerintah desa<br /> 2. Diskusikan basis data apa saja yang diperlukan untuk warga<br /> 3. Himpun data kependudukan warga dari Kartu Keluarga (KK)<br /> 4. Daftarkan proyek SID dan dapatkan aplikasi softwarenya di http://abcd.lumbungkomunitas.net<br /> 5. Install aplikasi software SID di komputer desa<br /> 6. Entry data penduduk ke SID<br /> 7. Basis data kependudukan sudah bisa dimanfaatkan<br /> 8. Diskusikan rencana pengembangan SID sesuai kebutuhan desa<br /> 9. Sebarluaskan informasi desa melalui beragam media untuk warga<br /> <br /> Pemberdayaan data desa yang dibangun diharapkan dapat menjunjung kesejahteraan masyarakat desa, data-data tersebut dapat diperuntukkan untuk riset lebih lanjut tentang kemiskinan, tanggap bencana, sumberdaya desa yang bisa diekspose keluar dan dengan menghubungkan dari desa ke desa dapat mencontohkan banyak hal dalam keberhasilan pemberdayaannya.<br /> (sumber: Buku Sistem Informasi Desa) <br /> <strong><br /></strong></p>',	1,	'2013-03-31 13:31:04',	999,	1,	'Awal mula SID',	0,	'',	'',	'',	'',	''),
(32,	'',	'<div class=\"contentText\">\r\n<div align=\"justify\">Bagian ini berisi informasi dasar mengenai desa kami. Sila klik pada tautan berikut untuk mendapatkan informasi yang lebih rinci.</div>\r\n<div align=\"justify\">&nbsp;</div>\r\n<div align=\"justify\"><ol>\r\n<li>Sejarah Desa</li>\r\n<li>Profil Wilayah Desa</li>\r\n<li>Profil Masyarakat Desa</li>\r\n<li>Profil Potensi Desa</li>\r\n</ol></div>\r\n</div>',	1,	'2013-07-29 10:46:44',	999,	1,	'Profil Desa',	0,	'',	'',	'',	'',	''),
(34,	'',	'<p style=\"text-align: justify;\"><span style=\"color: #ff0000;\"><strong>Contoh (Sila edit halaman ini sesuai dengan deskripsi desa ini)!</strong></span></p>\r\n<p style=\"text-align: justify;\">Berdasarkan data desa pada bulan Februari 2010, jumlah penduduk Desa Terong sebanyak 6484 orang. Jumlah Kepala Keluarga (KK) sebanyak 1605 KK.</p>\r\n<p style=\"text-align: justify;\">Jumlah penduduk Desa Terong usia produktif pada tahun 2009 adalah 4746 orang. Jumlah angkatan kerja tersebut jika dilihat berdasarkan tingkat pendidikannya adalah sebagai berikut:</p>\r\n<table style=\"width: 100%;\" border=\"1\" cellspacing=\"0\" cellpadding=\"4\">\r\n<tbody>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\"><strong>No.</strong></p>\r\n</td>\r\n<td style=\"width: 42%;\">\r\n<p style=\"text-align: center;\"><strong>Angkatan Kerja</strong></p>\r\n</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\"><strong>L</strong></p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\"><strong>P</strong></p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\"><strong>Jumlah</strong></p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\">1</p>\r\n</td>\r\n<td style=\"width: 42%;\">Tidak Tamat SD</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">59</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">56</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">115</p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\">2</p>\r\n</td>\r\n<td style=\"width: 42%;\">SD</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">880</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">792</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">1672</p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\">3</p>\r\n</td>\r\n<td style=\"width: 42%;\">SLTP</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">813</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">683</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">1496</p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\">4</p>\r\n</td>\r\n<td style=\"width: 42%;\">SLTA</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">725</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">673</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">1398</p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\">5</p>\r\n</td>\r\n<td style=\"width: 42%;\">Akademi</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">13</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">11</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">24</p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 8%;\">\r\n<p style=\"text-align: center;\">6</p>\r\n</td>\r\n<td style=\"width: 42%;\">Perguruan Tinggi</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">23</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">18</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">41</p>\r\n</td>\r\n</tr>\r\n<tr valign=\"top\">\r\n<td style=\"width: 50%;\" colspan=\"2\">\r\n<p style=\"text-align: center;\">Jumlah Total</p>\r\n</td>\r\n<td style=\"width: 17%;\">\r\n<p style=\"text-align: center;\">2513</p>\r\n</td>\r\n<td style=\"width: 18%;\">\r\n<p style=\"text-align: center;\">2233</p>\r\n</td>\r\n<td style=\"width: 15%;\">\r\n<p style=\"text-align: center;\">4746</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\"><strong>Profil sosial masyarakat</strong></p>\r\n<p style=\"text-align: justify;\">Dalam aktivitas keseharian, masyarakat Desa Terong sangat taat dalam menjalankan ibadah keagamaan. Setiap Rukung Tetangga (RT) dan pedukuhan memiliki kelompok-kelompok pengajian. Pada peringatan hari besar Islam, penduduk Desa Terong kerap menggelar acara peringatan dan karnaval budaya dengan tema yang disesuaikan dengan hari besar keagamaan. Sebagian besar warga Desa Terong terafiliasi pada organisasi kemasyarakat Islam Muhammadiyah.</p>\r\n<p style=\"text-align: justify;\">Gelaran perayaan lain selalu dilakukan dalam rangka memperingati Hari Kemerdekaan Republik Indonesia. Setiap pedukuhan akan turut serta dan semangat menampilkan ciri khasnya dalam acara peringatan dan karnaval budaya.</p>\r\n<p style=\"text-align: justify;\">Kelompok pemuda di Desa Terong yang tergabung dalam kelompok pegiat Karang Taruna menjadi aktor utama dalam banyak kegiatan desa. Kelompok ini aktif menggelar program kegiatan untuk isu demokrasi kepada warga, penguatan ekonomi produktif, pelatihan penanggulangan bencana, dan kampanye Gerakan Remaja Sayang Ibu (GEMAS).</p>\r\n<p style=\"text-align: justify;\">Sejumlah penduduk Desa Terong bekerja merantau di daerah di luar Yogyakarta. Namun, ikatan sosial mereka terhadap tanah kelahiran tetap tinggi. Penduduk asli Desa Terong yang tinggal di Jakarta dan sekitarnya misalnya, mereka membentuk paguyuban untuk memelihara silaturahmi antar sesama warga perantauan. Setiap bulan diadakan kegiatan arisan keliling secara bergilir di setiap tempat anggotanya. Setiap dua tahun sekali diadakan pula kegiatan mudik bersama ke kampung halaman di Desa Terong</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\"><strong>Profil politik masyarakat</strong></p>\r\n<p style=\"text-align: justify;\">Warga Desa Terong dikenal sebagai kelompok masyarakat yang paling aktif dan memiliki potensi tertinggi untuk berpartisipasi dalam pemberian suara untuk Pemilihan Umum dan Pemilihan Kepala Daerah Langsung. Tingkat partisipasi warga di desa ini terbanyak jika dibandingkan dengan desa lain di Kecamatan Dlingo, Bantul.</p>\r\n<p style=\"text-align: justify;\">Warga Desa Terong sangat aktif dalam mengawal proses penyusunan Rancangan Undang-Undang (RUU) Keistimewaan Yogyakarta. Banyak warga Desa Terong yang tergabung dalam Gerakan Rakyat Yogyakarta (GRY) dan aktif dalam beragam kegiatan serta demontrasi mendukung penetapan keistimewaan Yogyakarta. Kepala Desa Terong Sudirman Alfian merupakan Ketua Paguyuban Lurah dan Pamong Desa Ing Sedya Memetri Asrining Yogyakarta (ISMAYA) se Daerah Istimewa Yogyakarta (DIY). Beliau ditunjuk pula sebagai anggota tim perumus RUU Keistimewaan Yogyakarta bersi masyarakat Yogyakarta. Salah satu hal yang diperjuangkan dalam RUU tersebut adalah tidak adanya pelaksanaan pemilihan kepala daerah langsung dalam pemilihan Gubernur DIY; dengan mempertahankan konsep dwi tunggal Sri Sultan Hamengku Buwono dan Paku Alam sebagai Gubernur dan Wakil Bubernur DIY.</p>\r\n<p style=\"text-align: justify;\">Permasalahan mendasar yang ada di Desa Terong adalah tidak imbangnya jumlah pencari kerja dengan jumlah lapangan kerja yang tersedia. Sekalipun jumlah pengangguran di Desa Terong pada Tahun 2009 hanya orang tetapi kebanyakan mereka bekerja di luar Desa. Jadi, perlu gerakan kembali ke Desa serta menarik sumber-sumber ekonomi ke desa agar pencari kerja tidak banyak tersedot ke luar Desa.</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\">Sumber:<br />Laporan Pertanggung Jawaban Lurah Desa Terong, Kecamatan Dlingo, Kabupaten Bantul tahun 2009.</p>',	1,	'2013-07-29 11:13:36',	999,	1,	'Profil Masyarakat Desa',	0,	'',	'',	'',	'',	''),
(36,	'',	'<p>Kontak kami berisi cara menghubungi desa, seperti contoh berikut :</p>\r\n<p>Alamat : Jl desa no 01</p>\r\n<p>No Telepon : 081xxxxxxxxx</p>\r\n<p>Email : xx@desa.com</p>',	1,	'2013-07-29 11:28:31',	999,	1,	'Kontak Kami',	0,	'',	'',	'',	'',	''),
(37,	'',	'<p><span style=\"color: #ff0000;\"><strong>Contoh (Sila edit halaman ini dan sesuaikan dengan deskripsi untuk desa ini)!</strong></span><br /><br />Susunan Organisasi Badan Permusyawaratan Desa:</p>\r\n<p>Ketua</p>\r\n<p>Sekretaris</p>\r\n<p>Anggota</p>',	1,	'2013-07-29 11:33:33',	999,	1,	'Badan Permusyawaratan Desa',	0,	'',	'',	'',	'',	''),
(38,	'',	'<p>Berisi data lembaga yang ada di desa beserta deskripsi dan susunan pengurusnya</p>',	1,	'2013-07-29 11:38:33',	999,	1,	'Lembaga Kemasyarakatan',	0,	'',	'',	'',	'',	''),
(40,	'',	'<p>Berisi tentang peraturan yang ada di Desa</p>',	1,	'2013-07-29 12:06:50',	1001,	1,	'Peraturan',	0,	'',	'',	'',	'',	''),
(41,	'',	'<p>Agenda Bulan Agustus :</p>\r\n<p>01/08/2013 : Rapat rutin</p>\r\n<p>04/08/2013 : Pertemuan Pengurus</p>\r\n<p>05/08/2013 : Seminar</p>\r\n<p>&nbsp;</p>',	1,	'2013-07-30 07:08:52',	1000,	1,	'Agenda',	0,	'',	'',	'',	'',	''),
(42,	'',	'<p>Daftar Undang Undang Desa</p>\n<p><a href=\"../../../../../../assets/front/dokumen/Profil_SSN_SMP1Kepil.pdf\">1. UU No desa</a></p>\n<p>berisi asf basdaf.</p>\n<p>&nbsp;</p>\n<p><a href=\"kebumenkab.go.id/uu.pdf\">2.UU Perdangangan</a></p>',	1,	'2014-04-20 11:21:56',	999,	1,	'Undang Undang',	0,	'',	'',	'',	'',	''),
(43,	'',	'<p>Isi Peraturan Pemerintah</p>',	1,	'2014-04-20 11:24:01',	999,	1,	'Peraturan Pemerintah',	0,	'',	'',	'',	'',	''),
(44,	'',	'<p>Isi Peraturan Desa</p>',	1,	'2014-04-20 11:24:35',	999,	1,	'Peraturan Desa',	0,	'',	'',	'',	'',	''),
(45,	'',	'<p>Isi Peraturan Kepala Desa</p>',	1,	'2014-04-20 11:25:04',	999,	1,	'Peraturan Kepala Desa',	0,	'',	'',	'',	'',	''),
(46,	'',	'<p>Isi Keputusan kepala desa</p>',	1,	'2014-04-20 11:25:36',	999,	1,	'Keputusan Kepala Desa',	0,	'',	'',	'',	'',	''),
(47,	'',	'<p>Isi Panduan</p>',	1,	'2014-04-20 11:38:10',	999,	1,	'Panduan',	0,	'',	'',	'',	'',	''),
(51,	'',	'<p>Wahai masyarakat yang ber,,,,,,,,,,,,,,,,,,,,</p>\n<p>no hp : 097867575</p>\n<p>email: jkgkgkg</p>\n<p>ato komentar di bawah ini :</p>',	1,	'2014-04-22 03:11:20',	999,	1,	'Pengaduan',	0,	'',	'',	'',	'',	''),
(59,	'',	'<ol>\r\n<li><strong>a.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong><strong>Jumlah Penduduk</strong></li>\r\n</ol>\r\n<p>&nbsp;</p>\r\n<table style=\"width: 372px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Jumlah jiwa</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Jumlah laki-laki</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Jumlah perempuan</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Jumlah Kepala Keluarga</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">KK</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n<ol>\r\n<li><strong>b.&nbsp;&nbsp;&nbsp;&nbsp; </strong><strong>Tingkat Pendidikan</strong></li>\r\n</ol>\r\n<table style=\"width: 373px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align=\"left\">\r\n<tbody>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Belum sekolah</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Usia 7-45 tahun tidak pernah sekolah</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pernah sekolah SD tetapi tidak tamat</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">&nbsp;</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pendidikan terakhir</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Tamat SD/sederajat</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">SLTP/sederajat</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">SLTA/sederajat</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">D-1</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">D-2</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">D-3</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">S-1</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">S-2</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">S-3</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"121\">&nbsp;</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>&nbsp;</p>\r\n<ol>\r\n<li><strong>c.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong><strong>Mata Pencaharian</strong></li>\r\n</ol>\r\n<p><strong>&nbsp;</strong></p>\r\n<table style=\"width: 372px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Petani</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">246</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Buruh tani</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">125</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Buruh/swasta</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">136</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pegawai Negeri</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">35</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pengrajin</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">&nbsp;</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pedagang</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">9</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Peternak</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">-</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Nelayan</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">-</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Montir</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">8</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Dokter</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">-</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">POLRI/ABRI</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">1</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pensiunan</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">36</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Perangkat Desa</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">15</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Pembuat Bata</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">3</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><strong>&nbsp;</strong></p>\r\n<ol>\r\n<li><strong>d.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </strong><strong>AGAMA</strong></li>\r\n</ol>\r\n<table style=\"width: 372px;\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n<tbody>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Islam</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">2215</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Kristen</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">5</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Katholik</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">&nbsp;</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Hindu</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">&nbsp;</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n<tr>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"168\">\r\n<p align=\"right\">Budha</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"120\">\r\n<p align=\"right\">1</p>\r\n</td>\r\n<td valign=\"bottom\" nowrap=\"nowrap\" width=\"84\">\r\n<p align=\"right\">orang</p>\r\n</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><strong>&nbsp;</strong></p>\r\n<p><strong>&nbsp;</strong></p>',	1,	'2014-04-30 11:23:24',	999,	1,	'Profil Potensi Desa',	0,	'',	'',	'',	'',	''),
(62,	'',	'<p>Lembaga Kemasyarakatan Desa (LKMD) adalah salah satu lembaga kemasyaratan yang berada di desa.</p>\n<p>TUGAS LKMD</p>\n<ol>\n<li>menyusun rencana pembangunan secara partisipatif,</li>\n<li>menggerakkan swadaya gotong royong masyarakat,</li>\n<li>melaksanakan dan</li>\n<li>mengendalikan pembangunan.</li>\n</ol>\n<p align=\"left\">FUNGSI LKMD</p>\n<ol>\n<li>penampungan dan penyaluran aspirasi masyarakat dalam pembangunan;</li>\n<li>penanaman dan pemupukan rasa persatuan dan kesatuan masyarakat dalam kerangka memperkokoh Negara Kesatuan Republik Indonesia;</li>\n<li>peningkatan kualitas dan percepatan pelayanan pemerintah kepada masyarakat;</li>\n<li>penyusunan rencana, pelaksanaan, pelestarian dan pengembangan hasil-hasil pembangunan secara partisipatif;</li>\n<li>penumbuhkembangan dan penggerak prakarsa, partisipasi, serta swadaya gotong royong masyarakat; dan</li>\n<li>penggali, pendayagunaan dan pengembangan potensi sumber daya alam serta keserasian lingkungan hidup.</li>\n</ol>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS &hellip;&hellip;&hellip;&hellip;</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang Penetapan Pengurus Lembaga Kemasyarakatan Desa &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p>&nbsp;</p>',	1,	'2014-04-30 11:39:07',	999,	1,	'LKMD',	0,	'',	'',	'',	'',	''),
(63,	'',	'<p>TUGAS PKK</p>\n<ol>\n<li>menyusun rencana kerja PKK Desa/Kelurahan, sesuai dengan basil Rakerda Kabupaten/Kota;</li>\n<li>melaksanakan kegiatan sesuai jadwal yang disepakati;</li>\n<li>menyuluh dan menggerakkan kelompok-kelompok PKK Dusun/Lingkungan, RW, RT dan dasa wisma agar dapat mewujudkan kegiatan-kegiatan yang telah disusun dan disepakati;</li>\n<li>menggali, menggerakan dan mengembangkan potensi masyarakat, khususnya keluarga untuk meningkatkan kesejahteraan keluarga sesuai dengan kebijaksanaan yang telah ditetapkan;</li>\n<li>melaksanakan kegiatan penyuluhan kepada keluarga-keluarga yang mencakup kegiatan bimbingan dan motivasi dalam upaya mencapai keluarga sejahtera;.</li>\n<li>mengadakan pembinaan dan bimbingan mengenai pelaksanaan program kerja;</li>\n<li>berpartisipasi dalam pelaksanaan program instansi yang berkaitan dengan kesejahteraan keluarga di desa/kelurahan;</li>\n<li>membuat laporan basil kegiatan kepada Tim Penggerak PKK Kecamatan dengan tembusan kepada Ketua Dewan Penyantun Tim Penggerak PKK setempat;</li>\n<li>melaksanakan tertib administrasi; dan</li>\n<li>mengadakan konsultasi dengan Ketua Dewan Penyantun Tim Penggerak PKK setempat.</li>\n</ol>\n<p>&nbsp;</p>\n<p>FUNGSI PKK</p>\n<ol>\n<li>penyuluh, motivator dan penggerak masyarakat agar mau dan mampu melaksanakan program PKK; dan</li>\n<li>fasilitator, perencana, pelaksana, pengendali, pembina dan pembimbing Gerakan PKK.</li>\n</ol>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS &hellip;&hellip;&hellip;&hellip;</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang Penetapan Pengurus Lembaga Kemasyarakatan Desa &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"center\"><strong>Alamatn</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"center\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"center\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"180\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"241\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p>&nbsp;</p>',	2,	'2014-04-30 11:41:13',	999,	1,	'PKK',	0,	'',	'',	'',	'',	''),
(64,	'',	'<p align=\"left\">TUGAS &nbsp;KARANGTARUNA</p>\n<p align=\"left\">menanggulangi berbagai masalah kesejahteraan sosial terutama yang dihadapi generasi muda, baik yang bersifat preventif, rehabilitatif, maupun pengembangan potensi generasi muda di lingkungannya</p>\n<p align=\"left\">FUNGSI KARANGTAURNA</p>\n<ol>\n<li>penyelenggara usaha kesejahteraan sosial;</li>\n<li>penyelenggara pendidikan dan pelatihan bagi masyarakat;</li>\n<li>penyelenggara pemberdayaan masyarakat terutama generasi muda di lingkungannya secara komprehensif, terpadu dan terarah serta berkesinambungan;</li>\n<li>penyelenggara kegiatan pengembangan jiwa kewirausahaan bagi generasi muda di lingkungannya;</li>\n<li>penanaman pengertian, memupuk dan meningkatkan kesadaran tanggung jawab sosial generasi muda;</li>\n<li>penumbuhan dan pengembangan semangat kebersamaan, jiwa kekeluargaan, kesetiakawanan sosial dan memperkuat nilai-nilai kearifan dalam bingkai Negara Kesatuan Republik Indonesia;</li>\n</ol>\n<p align=\"left\">&nbsp;</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS &hellip;&hellip;&hellip;&hellip;</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang Penetapan Pengurus Lembaga Kemasyarakatan Desa &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p>&nbsp;</p>',	1,	'2014-04-30 11:44:28',	999,	1,	'Karang Taruna',	0,	'',	'',	'',	'',	''),
(65,	'',	'<p align=\"left\">TUGAS RT/RW</p>\n<p align=\"left\">membantu Pemerintah Desa dan Lurah dalam penyelenggaraan urusan pemerintahan</p>\n<p align=\"left\">FUNGSI PKK</p>\n<ol>\n<li>pendataan kependudukan dan pelayanan administrasi pemerintahan lainnya;</li>\n<li>pemeliharaan keamanan, ketertiban dan kerukunan hidup antar warga;</li>\n<li>pembuatan gagasan dalam pelaksanaan pembangunan dengan mengembangkan aspirasi dan swadaya murni masyarakat; dan</li>\n<li>penggerak swadaya gotong royong dan partisipasi masyarakat di wilayahnya.</li>\n</ol>\n<p align=\"left\">&nbsp;</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS &hellip;&hellip;&hellip;&hellip;</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang Penetapan Pengurus Lembaga Kemasyarakatan Desa &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\"><strong>Nama Pejabat</strong></p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">Ketua RW 1</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">Ketua RW 1 Rt 01</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">Ketua RW 1 Rt 02</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"186\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"204\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"193\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p>&nbsp;</p>',	1,	'2014-04-30 11:45:19',	999,	1,	'RT RW',	0,	'',	'',	'',	'',	''),
(66,	'',	'<p class=\"Default\">&nbsp;</p>\n<p class=\"Default\">Tim Koordinasi Percepatan Penanggulangan Kemiskinan Desa yang selanjutnya disingkat TKP2KDes adalah wadah koordinasi lintas sektor dan lintas pemangku kepentingan untuk percepatan penanggulangan kemiskinan di desa.</p>\n<p class=\"Default\">TKP2KDes bertugas mengkoordinasikan perencanaan, pengorganisasian, pelaksanaan dan pengendalian program penanggulangan kemiskinan di tingkat Desa.</p>\n<p>( Perda Kabupaten Kebumen Nomor 20 Tahun 2012 Tentang Percepatan Penanggulangan Kemiskinan )</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS &hellip;&hellip;&hellip;&hellip;</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip; Nomor : &hellip;&hellip;tanggal &hellip;&hellip;.. bulan&hellip;.. tentang &hellip;..</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p>&nbsp;</p>',	2,	'2014-04-30 11:46:01',	999,	1,	'TKP2KDes',	0,	'',	'',	'',	'',	''),
(67,	'',	'<p class=\"Default\">&nbsp;</p>\n<p class=\"Default\">Kelompok Perlindungan Anak Desa atau Kelurahan yang selanjutnya disingkat KPAD atau KPAK adalah lembaga perlindungan anak berbasis masyarakat yang berkedudukan dan melakukan kerja&ndash;kerja perlindungan anak di wilayah desa atau kelurahan tempat anak bertempat tinggal&nbsp;&nbsp;&nbsp;&nbsp; ( Perda Kaupaten Kebumen No 3 Tahun 2013 Tentang Penyelenggaraan Perlindungan Anak&nbsp; )</p>\n<p>TUGAS-TUGAS KPAD</p>\n<p>1.1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sosialisasi</p>\n<ol>\n<li>Mensosialisasikan kepada masyarakat tentang hak-hak anak</li>\n<li>Mempromosikan CHILD RIGHTS dan CHILD PROTECTION</li>\n<li>Melakukan upaya pencegahan, respon dan penanganan kasus kasus kekerasan terhadap anak dan masalah anak.</li>\n</ol>\n<p>1.2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Mediasi</p>\n<ol>\n<li>Mengedepankan upaya musyawarah dan mufakat (Rembug Desa)&nbsp; dalam menyelesaikan masalah &ndash; (Restorative Justive)</li>\n<li>Melakukan koordinasi dengan pihak terkait di level desa, kecamatan dan kabupaten dalam upaya perlindungan anak.</li>\n<li>Melakukan pendampingan kasus (dari pelaporan &ndash; medis &ndash; psikologi - reintegrasi)</li>\n</ol>\n<p>1.3&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Fasilitasi</p>\n<ol>\n<li>Memfasilitasi terbentuknya kelompok anak di desa sebagai media partisipasi anak</li>\n<li>Memfasilitasi partisipasi anak untuk terlibat dalam penyusunan perencanaan pembangunan yang berbasis hak anak (penyusunan RPJMDesa)</li>\n</ol>\n<p>1.4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Dokumentasi</p>\n<ol>\n<li>Mendokumentasikan semua proses yang dilakukan (Kegiatan Promosi; Penanganan Kasus dan mencatat kasus yang dilaporkan; Perkembangan Kasus, Pertemuan,dll)</li>\n</ol>\n<p>1.5&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Advokasi</p>\n<ol>\n<li>Mendorong adanya kebijakan dan penganggaran untuk perlindungan anak di level desa</li>\n<li>Menerima pengaduan kasus dan konsultasi tentang perlindungan anak</li>\n<li>Berhubungan dengan P2TP2A dan LPA untuk pendampingan hukum kasus anak (korban dan atau pelaku)</li>\n</ol>\n<p class=\"Default\">&nbsp;</p>\n<p class=\"Default\">&nbsp;</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS &hellip;&hellip;&hellip;&hellip;</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang Penetapan Pengurus Lembaga Kemasyarakatan Desa &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"1\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p align=\"left\">&nbsp;</p>\n<p>&nbsp;</p>',	2,	'2014-04-30 11:47:21',	999,	1,	'KPAD',	0,	'',	'',	'',	'',	''),
(68,	'',	'<p align=\"center\"><strong>DAFTAR NAMA PENGURUS KELOMPOK TERNAK &hellip;..</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang</p>\n<p align=\"center\">&hellip;&hellip;&hellip;&hellip;&hellip;.. &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS KELOMPOK WANITA TANI TERNAK&nbsp; &hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. bulan&hellip;..</p>\n<p align=\"center\">tentang &hellip;&hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p>&nbsp;</p>',	2,	'2014-04-30 11:47:58',	999,	1,	'Kelompok Ternak',	0,	'',	'',	'',	'',	''),
(69,	'',	'<p align=\"center\"><strong>DAFTAR NAMA PENGURUS GAPOKTAN</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. Juni &hellip;.. tentang</p>\n<p align=\"center\">&hellip;&hellip;&hellip;&hellip;&hellip;.. &hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"left\">&nbsp;</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS KELOMPOK TANI &hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. bulan&hellip;..</p>\n<p align=\"center\">tentang &hellip;&hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\">&nbsp;</p>\n<p align=\"center\"><strong>DAFTAR NAMA PENGURUS KELOMPOK TANI &hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>MASA JABATAN &hellip;&hellip;s/d&hellip;&hellip;.</strong></p>\n<p align=\"center\"><strong>DESA &hellip;&hellip;&hellip;&hellip;.. KECAMATAN &hellip;&hellip;&hellip; KABUPATEN &hellip;&hellip;&hellip;..</strong></p>\n<p align=\"center\">Surat Keputusan Kepala Desa &hellip;&hellip;&hellip;&hellip;. Nomor : &hellip;&hellip;&hellip;&hellip;&hellip; tanggal &hellip;&hellip;.. bulan&hellip;..</p>\n<p align=\"center\">tentang &hellip;&hellip;&hellip;&hellip;&hellip;&hellip;.</p>\n<p align=\"center\">&nbsp;</p>\n<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n<tbody>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\"><strong>No</strong></p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"center\"><strong>Jabatan</strong></p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"center\"><strong>Nama Pengurus</strong></p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"center\"><strong>Alamat</strong></p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">1</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">2</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"center\">3</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n<tr>\n<td valign=\"top\" width=\"55\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"162\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"192\">\n<p align=\"left\">&nbsp;</p>\n</td>\n<td valign=\"top\" width=\"229\">\n<p align=\"left\">&nbsp;</p>\n</td>\n</tr>\n</tbody>\n</table>',	1,	'2014-04-30 11:48:39',	999,	1,	'Kelompok Tani',	0,	'',	'',	'',	'',	''),
(70,	'',	'<p>Linmas</p>',	1,	'2014-04-30 11:53:18',	999,	1,	'LinMas',	0,	'',	'',	'',	'',	''),
(71,	'',	'<p>Kelompok Ekonomi Lainya</p>',	2,	'2014-04-30 11:54:20',	999,	1,	'Kelompok Ekonomi Lainya',	0,	'',	'',	'',	'',	''),
(83,	'',	'<p>Tiap hari rapat sampai kumat</p>',	1,	'2014-11-06 11:17:52',	1000,	1,	'Rapat Lagi',	0,	'',	'',	'',	'',	''),
(84,	'Penguins.jpg',	'<p style=\"text-align: justify;\">1. Pada komputer/PC server, buka web-browser (direkomendasikan <span style=\"text-decoration: underline;\">Mozilla Firefox</span> atau <span style=\"text-decoration: underline;\">Chrome</span>)</p>\r\n<p style=\"text-align: justify; padding-left: 30px;\">Ketik:<span style=\"color: #0000ff;\"> localhot/phpmyadmin</span></p>\r\n<p>2. Muncul halaman <span style=\"text-decoration: underline;\">PHPMyAdmin</span>. Periksa kolom kiri.</p>\r\n<p style=\"padding-left: 30px;\">Klik/Pilih: &ldquo;sid&rdquo;</p>\r\n<p>3. Muncul halaman yang menampilkan deretan isi tabel &ldquo;<span style=\"text-decoration: underline;\">sid</span>&ldquo;.</p>\r\n<p style=\"padding-left: 30px;\">Klik/Pilih: &ldquo;Export&rdquo; pada bagian menu atas di kolom kanan</p>\r\n<p>4. Muncul halaman <span style=\"text-decoration: underline;\">Export</span>. Kolom isian yang ada tak perlu diubah. Lihat bagian kanan bawah.</p>\r\n<p style=\"padding-left: 30px;\">Klik: &ldquo;Go&rdquo;</p>\r\n<p>5. Muncul jendela pilihan lokasi untuk menyimpan file database.</p>\r\n<p style=\"padding-left: 30px;\">Klik: &ldquo;Save&rdquo;<br /> Klik: &ldquo;OK&rdquo;</p>\r\n<p>6. File database SID 3.0 akan tersimpan otomatis di folder Download (tergantung setting komputer masing-masing). File tersimpan dalam sebagai &ldquo;sid.sql&rdquo;</p>\r\n<p>7. Simpan/amankan file &ldquo;sid.sql&rdquo; di media lain: Hard-disk eksternal, CD, <em>online storage</em>, dan sebagainya.</p>\r\n<p>8. Lakukan proses <em>back-up</em> database ini secara berkala.</p>\r\n<p>.<br /> Selamat mencoba!</p>',	1,	'2014-11-06 11:25:34',	1004,	1,	'Panduan Back-Up Data (Export Database) SID 3.0',	0,	'',	'',	'',	'',	''),
(85,	'1471927406download (1).jpg',	'<div class=\"contentText\">\r\n<div align=\"justify\">Bagian ini berisi informasi mengenai PemerintahanDesa. Sila klik pada tautan berikut untuk mendapatkan informasi yang lebih rinci.</div>\r\n<div align=\"justify\">&nbsp;</div>\r\n<ol>\r\n<li>Visi dan Misi</li>\r\n<li>Pemerintah Desa</li>\r\n<li>Badan Permusyawaratan Desa</li>\r\n</ol>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>VISI dan MISI</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>VISI</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>\"Senggigi Berseri\"</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>(Bersih, Relegius, Sejahtera, Rapi, dan Indah)</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>\"Terwujudnya masyarakat Desa Senggigi yang Bersih, Relegius, Sejahtra, Rapi dan Indah melalui Akselerasi Pembangunan yang berbasis Keagamaan, Budaya Hukum dan Berwawasan Lingkungan dengan berorentasi pada peningkatan Kinerja Aparatur dan Pemberdayaan Masyarakat\"</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>MISI</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\"><strong>Misi dan Program Desa Senggigi</strong></p>\r\n<p style=\"text-align: justify;\">Dan untuk melaksanakan visi Desa Senggigi dilaksanakan misi dan program sebagai berikut:</p>\r\n<p style=\"text-align: justify;\">1. Pembangunan Jangka Panjang</p>\r\n<ul>\r\n<li style=\"text-align: justify;\">Melanjutkan Pembangunan Desa yang belum terlaksana</li>\r\n<li style=\"text-align: justify;\">Meningkatkan Kerjasama antara pemerintah Desa dengan Lembaga desa yang ada</li>\r\n<li style=\"text-align: justify;\">Meningkatkan Kesejahtraan Masyarakat desa dengan meningkatkan sarana dan prasarana ekonomi warga.&nbsp;</li>\r\n</ul>\r\n<p style=\"text-align: justify;\">&nbsp;</p>\r\n<p style=\"text-align: justify;\">2. Pembangunan Jangka Pendek &nbsp;</p>\r\n<ul>\r\n<li style=\"text-align: justify;\">Mengembangkan dan Menjaga serta melestarikan ada istiadat desa terutama yang telah mengakar di desa senggigi.&nbsp;</li>\r\n<li style=\"text-align: justify;\">Meningkatkan pelayanan dalam bidang pemerintahan kepada warga masyarakat&nbsp;</li>\r\n<li style=\"text-align: justify;\">Meningkatkan sarana dan prasarana ekonomi warga desa dengan perbaikan prasarana dan sarana ekonomi.</li>\r\n<li style=\"text-align: justify;\">Meningkatkan sarana dan prasarana pendidikan guna peningkatan sumber daya manusia desa senggigi.&nbsp;</li>\r\n</ul>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>Kepala Desa Senggigi</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>Muhammad Ilham</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>&nbsp;</p>\r\n</div>',	1,	'2014-11-07 03:53:54',	999,	1,	'Pemerintahan Desa',	0,	'',	'',	'',	'',	''),
(86,	'',	'',	1,	'2014-12-10 08:00:22',	1006,	1,	'',	0,	'',	'',	'',	'',	''),
(87,	'',	'<p>bla bla bla</p>',	1,	'2014-12-10 09:59:20',	16,	1,	'Sejumlah Tukang Becak Merampok Indoapril',	0,	'',	'',	'',	'ddd.xls',	'hahaha'),
(90,	'1471968200IMG-20160823-WA0007.jpg',	'',	1,	'2016-08-23 17:03:21',	5,	1,	'PERDES PHBS ',	3,	'1471968200IMG-20160823-WA0012.jpg',	'1471968200',	'1471968200',	'PERDES PHBS.docx',	'PERDES PHBS '),
(92,	'1472006396',	'<p><strong>Susunan Organisasi Pemerintah Desa Senggigi</strong><br /><br />Kepala Desa: MUHAMMAD ILHAM<br />Sekretaris Desa:&nbsp;<span>MUSTAHIQ, S.Adm</span><br />Kepala Urusan Pemerintahan: SYAFRUDIN<br />Kepala Urusan&nbsp;Pembangunan: SYAFI\'I, SE<br />Kepala Urusan&nbsp;Kesra: HAMIDIAH<br />Kepala Urusan&nbsp;Keuangan: MARDIANA<br />Kepala Urusan&nbsp;Trantib: SUPARDI RUSTAM<br />Kepala Urusan&nbsp;Umum: MAHRUP<br /><br /></p>',	1,	'2016-08-24 03:39:56',	999,	1,	'Pemerintah Desa',	0,	'1472006396',	'1472006396',	'1472006396',	'',	''),
(93,	'1472006908',	'<p style=\"text-align: center;\"><strong>VISI dan MISI</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>VISI</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>\"Senggigi Berseri\"</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>(Bersih, Relegius, Sejahtera, Rapi, dan Indah)</strong></p>\r\n<p style=\"text-align: center;\">&nbsp;</p>\r\n<p style=\"text-align: center;\"><strong>\"Terwujudnya masyarakat Desa Senggigi yang Bersih, Relegius, Sejahtera, Rapi dan Indah melalui Akselerasi Pembangunan yang berbasis Keagamaan, Budaya Hukum dan Berwawasan Lingkungan dengan berorentasi pada peningkatan Kinerja Aparatur dan Pemberdayaan Masyarakat\"</strong></p>\r\n<p>&nbsp;&nbsp;</p>\r\n<p><strong>MISI</strong></p>\r\n<p><strong>Misi dan Program Desa Senggigi</strong></p>\r\n<p>Dan untuk melaksanakan visi Desa Senggigi dilaksanakan misi dan program sebagai berikut:</p>\r\n<p>1. Pembangunan Jangka Panjang</p>\r\n<p>&nbsp; &nbsp; - Melanjutkan pembangunan desa yang belum terlaksana.</p>\r\n<p>&nbsp; &nbsp; - Meningkatkan kerjasama antara pemerintah desa dengan lembaga desa yang ada.</p>\r\n<p>&nbsp; &nbsp; - Meningkatkan kesejahtraan masyarakat desa dengan meningkatkan sarana dan prasarana ekonomi warga.&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>2. Pembangunan Jangka Pendek &nbsp;</p>\r\n<p>&nbsp; &nbsp; - Mengembangkan dan Menjaga serta melestarikan ada istiadat desa terutama yang telah mengakar di desa senggigi.&nbsp;</p>\r\n<p>&nbsp; &nbsp; - Meningkatkan pelayanan dalam bidang pemerintahan kepada warga masyarakat&nbsp;</p>\r\n<p>&nbsp; &nbsp; - Meningkatkan sarana dan prasarana ekonomi warga desa dengan perbaikan prasarana dan sarana ekonomi.</p>\r\n<p>&nbsp; &nbsp; - Meningkatkan sarana dan prasarana pendidikan guna peningkatan sumber daya manusia Desa Senggigi.&nbsp;</p>',	1,	'2016-08-24 03:48:28',	999,	1,	'Visi dan Misi',	0,	'1472006908',	'1472006908',	'1472006908',	'',	''),
(94,	'1472782825artikel-2-1.jpg',	'<p style=\"text-align: justify;\">Gotong royong yang dulu digagas pertama kali oleh pendiri bangsa, Ir. Soekarno kian hari semakin terkikis dengan budaya individual ditengah persaingan yang begitu ketat dalam mencapai tujuan tertentu, kenyataan inilah yang membuat nilai-nilai sosial ditatanan masyarakat yang sejak dulu sudah ditanamkan oleh nenek moyang kita luntur seiring dengan perkembangan jaman. padahal untuk mencapai suatu tujuan dan cita-cita bersama seharusnya dikerjakan secara bersama-sama.&nbsp;</p>\n<p style=\"text-align: justify;\">&nbsp;</p>\n<p style=\"text-align: justify;\">Maka dengan kenyataan inilah, pemerintah desa senggigi kembali melakukan sebuah inovasi baru dalam merangkul masyarakat agar terus menanamkan kebudayaan \"Gotong Raoyong\". kegitan gotong royong dalam pembangunan jalan desa sedikitnya melibatkan hampir 95% masyarakat senggigi, kebersamaan dan ikatan persaudaraan atas kepentingan bersama menjadi satu ketika semua masyarakat desa terlibat aktif, tanpa harus melihat tatanan dan golongan yang ada. masyarakat saling bahu membahu seiring kegitan gotong royong.&nbsp;</p>\n<p style=\"text-align: justify;\">&nbsp;</p>\n<p style=\"text-align: justify;\">&nbsp;</p>',	1,	'2016-08-24 04:02:44',	1,	1,	'Membangun Desa Lewat Gotong Royong',	3,	'1472782825artikel-2-2.jpeg',	'1472007764',	'1472007764',	'',	''),
(95,	'1472782634galeri-1-1.jpg',	'<p>Desa Senggigi ikut memeriahkan perayaan 17 Agustus 2016 sebagai hari jadi Indonesia yang ke 71 melalui kegiatan Karnaval yang diselenggarakan oleh Camat Batulayar Kabupaten Lombok Barat NTB. Acara karnaval dilaksanakan pada hari Rabu, 17 Agustus 2016 dimulai pukul 15.30 s/d 17.00 wita. Masing-masing desa berkumpul disekitaran kantor Camat Batulayar, dan berjalan menuju Taman Bale Pelangi Desa Sandik sebagai pusat titik kumpul seluruh peserta karnaval.&nbsp;</p>\n<p>&nbsp;</p>\n<p>Dalam karnaval ini, Desa Senggigi melibatkan berbagai unsur masyarakat seperti tokoh masyarakat, perempuan, pemuda dan anak-anak dengan menggunakan baju adat dan berbagai macam asesoris hari kemerdekaan, kegitan tersebut adalah salah satu cara bagaimana memupuk semangat bagi setiap warga negara, khususnya kaum muda sebagai harapan bangsa, yang kian hari semakin terkikis dengan pengaruh global saat ini.</p>\n<p>&nbsp;</p>\n<p>Lewat karang taruna desa senggigi, pemupukan pemberian semangat dalam berpacu memajukan desa dan bangsa terus dilakukan, berbagai macam kegiatan tahapan dalam pelaksanaan hari kemerdekaan terus di lakukan.&nbsp;</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>',	1,	'2016-08-24 06:05:21',	1,	1,	'Perayaan Hari Kemerdekaan 2016',	3,	'1472782634galeri-1-2.jpeg',	'1472015120',	'1472015120',	'',	''),
(96,	'1472782915artikel-3-1.jpeg',	'<p>Dalam rapat pembahasan komitmen perekrutan karyawan hotel pada tanggal 24 Agustus 2016 di kantor desa sengigi telah menyepakati beberapa komitmen bersama diantaranya sebagai berikut:</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>1. Dalam perekrutan karyawan, pihak hotel harus memprioritaskan masyarakat senggigi minimal 35%</p>\n<p>2. Pihak Hotel harus mengikuti program perencanaan tenaga kerja desa senggigi sesua dengan VISI dan MISI desa</p>\n<p>3. Pihak hotel harus melakukan kordinasi dengan pemerintah desa ketika perekrutan karyawan&nbsp;</p>\n<p>4. Pihak Hotel harus melakukan pelatihan bagi calon karyawan, khususnya karyawan yang berasal dari desa sengggigi</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>Bagi rekan-rekan pemuda dan masyarakat harap melakukan kordinasi dengan pemerintah desa terkait dengan beberapa hasil pertemuan dalam membangun komitme dengan pihak hotel, jika ada hal mendesak terkait beberapa syarat ketentuan perekrutan, rekan-rekan pemuda dan masyarakat bisa menghubungi kami di kantor desa..</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>\n<p>&nbsp;</p>',	1,	'2016-08-24 06:55:10',	4,	1,	'Rapat membangun Komitmen antara Karang Taruna Desa Senggigi dengan Taruna Hotel',	3,	'1472018109IMG-20160824-WA0000.jpg',	'1472018109',	'1472018109',	'',	''),
(97,	'1472019299',	'<p>Halaman ini berisi tautan menuju informasi mengenai Basis Data Desa. Ada dua jenis data yang dimuat dalam sistem ini, yakni basis data kependudukan dan basis data sumber daya desa. Sila klik pada tautan berikut untuk mendapatkan tampilan data statistik per kategori.</p>\r\n<ol>\r\n<li>Data Wilayah Administratif&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Pendidikan&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Pekerjaan&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Golongan Darah&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Agama&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Jenis Kelamin&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Kelompok Umur&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Penerima Raskin&nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;</li>\r\n<li>Data Penerima BPJS &nbsp; &nbsp; &nbsp; &nbsp;</li>\r\n<li>Data Warga Negara &nbsp; &nbsp; &nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp;</li>\r\n</ol>\r\n<p>Data yang tampil adalah statistik yang didapatkan dari proses olah data dasar yang dilakukan secara&nbsp;<em>offline</em>&nbsp;di kantor desa secara rutin/harian. Data dasar di kantor desa diunggah ke dalam sistem&nbsp;<em>online</em>&nbsp;di website ini secara berkala. Sila hubungi kontak pemerintah desa untuk mendapatkan data dan informasi desa termutakhir.</p>',	1,	'2016-08-24 07:14:59',	999,	1,	'Data Desa',	0,	'1472019299',	'1472019299',	'1472019299',	'',	''),
(98,	'1472192894',	'<p>Wilayah desa berisi tentang penjelasan dan deskripsi letak wilayah desa. contohnya sebagai berikut :<br />Batas-batas :<br />Utara&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Kelurahan a<br />Timur &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: Desa b<br />Selatan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Desa c<br />Barat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : Kelurahan d dan Desa e<br />Luas Wilayah Desa Penglatan&nbsp;&nbsp; : 186,193 Ha<br />Letak Dan Batas Desa x<br />Desa Penglatan terletak pada posisi 115. 7.20 LS 8. 7.10 BT, dengan ketinggian kurang lebih 250 M diatas permukaan laut.</p>\r\n<p>Peta Desa:</p>\r\n<p><iframe src=\"https://www.google.co.id/maps?f=q&amp;source=s_q&amp;hl=en&amp;geocode=&amp;q=Logandu,+Karanggayam&amp;aq=0&amp;oq=logandu&amp;sll=-2.550221,118.015568&amp;sspn=52.267573,80.332031&amp;t=h&amp;ie=UTF8&amp;hq=&amp;hnear=Logandu,+Karanggayam,+Kebumen,+Central+Java&amp;z=14&amp;ll=-7.55854,109.634173&amp;output=embed\" frameborder=\"0\" marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\" width=\"600\" height=\"450\"></iframe></p>',	1,	'2016-08-26 07:28:14',	999,	1,	'Wilayah Desa',	0,	'1472192894',	'1472192894',	'1472192894',	'',	''),
(99,	'1472228892Raja Lombok 1902.jpg',	'<p style=\"text-align: justify;\" align=\"center\">Sejarah telah mencatat bahwa Pulau Lombok pernah menjadi wilayah kekuasaan Kerajaan Karang Asem Bali yang berkedudukan di Cakranegara dengan seorang raja bernama Anak Agung Gde Jelantik. Berakhirnya <strong>kekuasaan</strong> Kerajaan Karang Asem Bali di Pulau Lombok setelah datangnya Belanda pada Tahun 1891, dimana Belanda pada waktu itu ingin menguasai Pulau Lombok dengan dalih pura-pura membantu rakyat Lombok yang dianggap tertindas oleh Pemerintahan Raja Lombok yaitu Anak Agung Gede Jelantik.</p>\r\n<p style=\"text-align: justify;\">Pada masa kekuasaan Raja Lombok yaitu Anak Agung Gde Jelantik, wilayah Desa Senggigi ( Dusun Mangsit, Kerandangan, Senggigi dan Dusun Loco) masih bergabung dengan Desa Senteluk yang sekarang menjadi Desa Meninting . Sedangkan pada tahun 1962 Desa Senteluk pecah menjadi 2 (Dua) desa yaitu Desa Meninting dan Desa Batulayar dan Dusun Mangsit,Kerandangan,Senggigi dan Dusun Loco bergabung ke Desa Batulayar.&nbsp;</p>\r\n<p style=\"text-align: justify;\">Pemberian nama Desa Batulayar pada waktu itu yang lazim disebut dengan Pemusungan/Kepala Dea Batulayar berdasarkan hasil musyawarah nama Batulayar diambil dari nama tempat yang amat terkenal yaitu Makam Batulayar yang sampai saat ini banyak dikunjungi oleh masyarakat Pulau Lombok pada khususnya dan Masyarakat Nusa Tenggara Barat pada umumnya.</p>\r\n<p style=\"text-align: justify;\">Pada tahun 2001 Desa Batulayar dimekarkan menjadi 2 (dua) yaitu Desa Batulayar (sebagai Desa Induk) dan Desa Senggigi (sebagai Desa Persiapan) dengan SK.Bupati No : 30 Tahun 2001 tanggal 17 Mei 2001, yang pada waktu itu yang menjadi pejabat Kepala Desa Senggigi ialah <strong>H. ARIF RAHMAN, S.IP</strong>., dengan jumlah dusun sebanyak 3 dusun, yaitu :</p>\r\n<p>1. Dusun Senggigi</p>\r\n<p>2. Dusun Kerandangan</p>\r\n<p>3. Dusun Mangsit</p>\r\n<p>Selanjutnya pada tanggal 30 Juli 2003 Pejabat Kepala Desa Senggigi dari <strong>H. ARIF RAHMAN, S.IP</strong> diganti oleh Saudara<strong> ARIFIN</strong> dengan SK. Bupati Lombok Barat No : 409/66/pem/2003. Berhubung Desa Senggigi masih bersifat Desa Persiapan, maka berdasarkan hasil musyawarah desa, tertanggal 15 Desember 2003 , maka pada tanggal 22 Desember 2003 Desa Senggigi mengadakan Pemilihan Kepala Desa devinitif yang pertama kali dipimpin oleh&nbsp;<strong>HAJI JUNAIDI</strong>&nbsp;terpilih&nbsp;dengan SK. Bupati Lombok Barat No :01/01/Pem/2004 tertanggal 2 Januari 2004&nbsp;sampai pada tahun 2008.&nbsp;</p>\r\n<p style=\"text-align: justify;\">Selanjutnya pada tahun 2008, Desa Senggigi mengadakan pemilihan Kepala Desa Senggigi yang kedua dan dimenangkan oleh Bapak <strong>H. MUTAKIR AHMAD</strong>&nbsp;dengan&nbsp;SK. Bupati Lombok Barat No :1320/48/Pem./2008 tertanggal 23 Desember 2008, Periode 2008-2014. &nbsp;Kemudian Kepala desa terpilih Periode 2015 s/d 2021&nbsp;adalah <strong>MUHAMMAD ILHAM</strong>&nbsp;dengan SK. Bupati Lombok Barat No : 160/04/BPMPD/15 tanggal 27 Januari 2015 kini baru menjabat 2 (dua) bulan.</p>\r\n<p style=\"text-align: justify;\">Demikian selanyang pandang atau sejarah singkat Desa Senggigi yang dapat kami sampaikan kepada para pegiat Medsos, semoga dapat bermanfaat untuk kita semua, terima kasih.</p>\r\n<p style=\"text-align: justify;\" align=\"center\">&nbsp;</p>\r\n<p style=\"text-align: justify;\" align=\"center\">&nbsp;</p>',	1,	'2016-08-26 08:38:09',	999,	1,	'Sejarah Desa',	3,	'1472229325490125_20121123041539.jpg',	'1472197089',	'1472197089',	'',	''),
(100,	'1473071921',	'<p>Ini contoh teks berjalan. Isi dengan tulisan yang menampilkan suatu ciri atau kegiatan penting di desa anda.</p>',	1,	'2016-09-05 03:38:41',	22,	1,	'Contoh teks berjalan',	0,	'1473071921',	'1473071921',	'1473071921',	'',	'');

DROP TABLE IF EXISTS `config`;
CREATE TABLE `config` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `nama_desa` varchar(100) NOT NULL,
  `kode_desa` varchar(100) NOT NULL,
  `nama_kepala_desa` varchar(100) NOT NULL,
  `nip_kepala_desa` varchar(100) NOT NULL,
  `kode_pos` varchar(6) NOT NULL,
  `nama_kecamatan` varchar(100) NOT NULL,
  `kode_kecamatan` varchar(100) NOT NULL,
  `nama_kepala_camat` varchar(100) NOT NULL,
  `nip_kepala_camat` varchar(100) NOT NULL,
  `nama_kabupaten` varchar(100) NOT NULL,
  `kode_kabupaten` varchar(100) NOT NULL,
  `nama_propinsi` varchar(100) NOT NULL,
  `kode_propinsi` varchar(100) NOT NULL,
  `logo` varchar(100) NOT NULL,
  `lat` varchar(20) NOT NULL,
  `lng` varchar(20) NOT NULL,
  `zoom` tinyint(4) NOT NULL,
  `map_tipe` varchar(20) NOT NULL,
  `path` text NOT NULL,
  `alamat_kantor` varchar(200) DEFAULT NULL,
  `g_analytic` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `config` (`id`, `nama_desa`, `kode_desa`, `nama_kepala_desa`, `nip_kepala_desa`, `kode_pos`, `nama_kecamatan`, `kode_kecamatan`, `nama_kepala_camat`, `nip_kepala_camat`, `nama_kabupaten`, `kode_kabupaten`, `nama_propinsi`, `kode_propinsi`, `logo`, `lat`, `lng`, `zoom`, `map_tipe`, `path`, `alamat_kantor`, `g_analytic`) VALUES
(1,	'Senggigi ',	'05',	'Muhammad Ilham ',	'--',	'83355',	'Batulayar ',	'14',	'Bambang Budi Sanyoto, S. H',	'-',	'Lombok Barat ',	'01',	'NTB ',	'52',	'LogoSenggigi100x100.png',	'-8.488005310891758',	'116.0406072534065',	19,	'hybrid',	'(-7.8312189550359586, 110.2565517439507);(-7.8676102927000695, 110.25380516191944);(-7.843803235881495, 110.29843711992726);(-7.831899196157655, 110.36504173418507);(-7.8169336350355465, 110.32933616777882);(-7.8169336350355465, 110.29775047441944);',	'Jl. Raya Senggigi Km 10 Kerandangan ',	'gsgsdgsdgsg');

DROP TABLE IF EXISTS `data_persil`;
CREATE TABLE `data_persil` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(64) NOT NULL,
  `nama` varchar(128) NOT NULL COMMENT 'nomer persil',
  `persil_jenis_id` tinyint(2) NOT NULL,
  `id_clusterdesa` int(11) NOT NULL,
  `luas` decimal(7,2) NOT NULL,
  `no_sppt_pbb` varchar(128) NOT NULL,
  `kelas` varchar(128) DEFAULT NULL,
  `persil_peruntukan_id` tinyint(2) NOT NULL,
  `alamat_ext` varchar(100) DEFAULT NULL,
  `userID` mediumint(9) DEFAULT NULL,
  `peta` text,
  `rdate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `data_persil_jenis`;
CREATE TABLE `data_persil_jenis` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(128) NOT NULL,
  `ndesc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `data_persil_peruntukan`;
CREATE TABLE `data_persil_peruntukan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(128) NOT NULL,
  `ndesc` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP VIEW IF EXISTS `data_surat`;
CREATE TABLE `data_surat` (`id` int(11), `nama` varchar(100), `sex` varchar(15), `tempatlahir` varchar(100), `tanggallahir` date, `umur` double(17,0), `status_kawin` varchar(100), `warganegara` varchar(25), `agama` varchar(100), `pendidikan` varchar(50), `pekerjaan` varchar(100), `nik` decimal(16,0), `rt` varchar(10), `rw` varchar(10), `dusun` varchar(50), `no_kk` varchar(160), `kepala_kk` varchar(100));


DROP TABLE IF EXISTS `detail_log_penduduk`;
CREATE TABLE `detail_log_penduduk` (
  `id` int(10) NOT NULL,
  `nama` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `dokumen`;
CREATE TABLE `dokumen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `satuan` varchar(200) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `enabled` int(2) NOT NULL DEFAULT '1',
  `tgl_upload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `id_pend` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `gambar_gallery`;
CREATE TABLE `gambar_gallery` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parrent` int(4) NOT NULL DEFAULT '0',
  `gambar` varchar(200) DEFAULT NULL,
  `nama` varchar(50) NOT NULL,
  `enabled` int(2) NOT NULL DEFAULT '1',
  `tgl_upload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tipe` int(4) NOT NULL DEFAULT '0',
  `slider` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `parrent` (`parrent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `gambar_gallery` (`id`, `parrent`, `gambar`, `nama`, `enabled`, `tgl_upload`, `tipe`, `slider`) VALUES
(28,	0,	'bg5.jpg',	'Karnaval Hari Kemerdekaan ',	1,	'2016-08-26 07:53:51',	0,	0),
(29,	0,	'bg3.jpg',	'Panorama Wisata ',	1,	'2016-08-26 07:55:31',	0,	0),
(30,	28,	'IMG-20160823-WA0116.jpg',	'Karnaval baju adat',	1,	'2016-08-26 07:57:10',	2,	NULL),
(31,	28,	'galeri-1-2.jpeg',	'Kemeriahan Karnaval',	2,	'2016-08-26 07:58:16',	2,	NULL),
(32,	29,	'galeri-2-2.jpeg',	'Pantai indah',	1,	'2016-09-01 19:14:06',	2,	NULL),
(33,	29,	'galeri-2-3.jpeg',	'Kolam renang impian',	1,	'2016-09-01 19:14:28',	2,	NULL),
(34,	0,	'bg4.jpg',	'Kegiatan Kantor Desa',	1,	'2016-09-01 23:24:59',	0,	0),
(35,	28,	'',	'Tarian adat',	1,	'2016-09-02 00:32:55',	2,	NULL),
(36,	0,	'bg3.jpg',	'fdsafa',	1,	'2017-04-22 03:12:39',	0,	0),
(37,	0,	'bg5.jpg',	'safads',	1,	'2017-04-22 03:12:55',	0,	0),
(38,	0,	'bg5.jpg',	'fsaf',	1,	'2017-04-22 03:13:06',	0,	0),
(39,	0,	'bg3.jpg',	'fdsfa',	1,	'2017-04-22 03:13:18',	0,	0),
(40,	0,	'bg3.jpg',	'fsdafa',	1,	'2017-04-22 03:13:31',	0,	0),
(41,	0,	NULL,	'fsafasf',	1,	'2017-04-22 06:19:18',	0,	0);

DROP TABLE IF EXISTS `garis`;
CREATE TABLE `garis` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `path` text NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '1',
  `ref_line` int(9) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `desk` text NOT NULL,
  `id_cluster` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `gis_simbol`;
CREATE TABLE `gis_simbol` (
  `simbol` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `inbox`;
CREATE TABLE `inbox` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `ReceivingDateTime` timestamp NULL DEFAULT NULL,
  `Text` text NOT NULL,
  `SenderNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL DEFAULT '',
  `Class` int(11) NOT NULL DEFAULT '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `RecipientID` text NOT NULL,
  `Processed` enum('false','true') NOT NULL DEFAULT 'false',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `kategori`;
CREATE TABLE `kategori` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `kategori` varchar(100) NOT NULL,
  `tipe` int(4) NOT NULL DEFAULT '1',
  `urut` tinyint(4) NOT NULL,
  `enabled` tinyint(4) NOT NULL,
  `parrent` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `kategori` (`id`, `kategori`, `tipe`, `urut`, `enabled`, `parrent`) VALUES
(1,	'Berita Desa',	1,	1,	1,	0),
(2,	'Produk Desa',	1,	3,	2,	0),
(4,	'Agenda Desa',	2,	2,	1,	0),
(5,	'Peraturan Desa',	2,	5,	1,	0),
(6,	'Laporan Desa',	2,	6,	2,	0),
(8,	'Panduan Layanan Desa',	2,	3,	2,	0),
(17,	'Peraturan Kebersihan Desa',	1,	0,	2,	5),
(20,	'Berita Lokal',	1,	0,	2,	1),
(21,	'Berita Kriminal',	1,	0,	2,	1),
(22,	'teks_berjalan',	1,	0,	1,	0);

DROP TABLE IF EXISTS `kelompok`;
CREATE TABLE `kelompok` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_master` int(11) NOT NULL,
  `id_ketua` int(11) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `keterangan` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_ketua` (`id_ketua`),
  KEY `id_master` (`id_master`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `kelompok_anggota`;
CREATE TABLE `kelompok_anggota` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_kelompok` int(11) NOT NULL,
  `id_penduduk` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_kelompok` (`id_kelompok`,`id_penduduk`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `kelompok_master`;
CREATE TABLE `kelompok_master` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `kelompok` varchar(50) NOT NULL,
  `deskripsi` varchar(400) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `kelompok_master` (`id`, `kelompok`, `deskripsi`) VALUES
(1,	'Kelompok Ternak',	'<p>Kelompok yang memelihara ternak</p>');

DROP TABLE IF EXISTS `klasifikasi_analisis_keluarga`;
CREATE TABLE `klasifikasi_analisis_keluarga` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(20) NOT NULL,
  `jenis` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `komentar`;
CREATE TABLE `komentar` (
  `id` int(5) NOT NULL AUTO_INCREMENT,
  `id_artikel` int(7) NOT NULL,
  `owner` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `komentar` text NOT NULL,
  `tgl_upload` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` int(2) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `komentar` (`id`, `id_artikel`, `owner`, `email`, `komentar`, `tgl_upload`, `enabled`) VALUES
(8,	95,	'Penduduk Biasa',	'penduduk@desaku.desa.id',	'Selamat atas keberhasilan Senggigi merayakan Hari Kemerdeakaan 2016!',	'2016-09-13 23:09:16',	1),
(9,	775,	'AHMAD ALLIF RIZKI',	'5201140706966997',	'Harap alamat keluarga kami diperbaik menjadi RT 002 Dusun Mangsit. \n\nTerima kasih.',	'2016-09-14 00:44:59',	1),
(10,	775,	'DENATUL SUARTINI',	'3275014601977005',	'Saya ke kantor desa kemarin jam 12:30 siang, tetapi tidak ada orang. Anak kami akan pergi ke Yogyakarta untuk kuliah selama 4 tahun. Apakah perlu kami laporkan?',	'2016-09-14 03:49:34',	2),
(11,	775,	'DENATUL SUARTINI',	'3275014601977005',	'Laporan ini tidak relevan. Hanya berisi komentar saja.',	'2016-09-14 04:05:02',	2);

DROP TABLE IF EXISTS `kontak`;
CREATE TABLE `kontak` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pend` int(11) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `kontak_grup`;
CREATE TABLE `kontak_grup` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_grup` varchar(30) NOT NULL,
  `id_kontak` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `line`;
CREATE TABLE `line` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `simbol` varchar(50) NOT NULL,
  `color` varchar(10) NOT NULL DEFAULT 'ff0000',
  `tipe` int(4) NOT NULL,
  `parrent` int(4) DEFAULT '1',
  `enabled` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parrent` (`parrent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `line` (`id`, `nama`, `simbol`, `color`, `tipe`, `parrent`, `enabled`) VALUES
(1,	'Jalan',	'',	'FFCD42',	0,	1,	1),
(2,	'Jalan Raya',	'',	'FFCD42',	2,	66,	1),
(3,	'Jalan Kampung',	'',	'',	2,	66,	1),
(4,	'Ring Road',	'',	'',	2,	66,	1),
(5,	'Sungai',	'',	'FFFFFF',	0,	1,	1),
(6,	'Selokan',	'',	'',	2,	70,	1);

DROP TABLE IF EXISTS `log_bulanan`;
CREATE TABLE `log_bulanan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pend` int(11) NOT NULL,
  `lk` int(11) NOT NULL,
  `pr` int(11) NOT NULL,
  `kk` int(11) NOT NULL,
  `tgl` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `kk_lk` int(11) DEFAULT NULL,
  `kk_pr` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `log_bulanan` (`id`, `pend`, `lk`, `pr`, `kk`, `tgl`, `kk_lk`, `kk_pr`) VALUES
(1,	16906,	8280,	8626,	4885,	'2014-12-05 07:27:01',	NULL,	NULL),
(2,	16906,	8280,	8626,	4885,	'2016-05-24 14:00:30',	NULL,	NULL),
(3,	0,	0,	0,	4885,	'2016-06-02 04:41:53',	NULL,	NULL),
(4,	4725,	2383,	2342,	1643,	'2016-08-24 03:47:23',	NULL,	NULL),
(5,	97,	46,	51,	37,	'2016-09-25 23:13:09',	28,	9),
(6,	97,	46,	51,	37,	'2016-12-29 13:16:04',	NULL,	NULL),
(7,	97,	46,	51,	37,	'2017-02-10 21:41:46',	NULL,	NULL),
(8,	98,	47,	51,	37,	'2017-04-24 06:52:19',	28,	9),
(9,	98,	47,	51,	37,	'2017-05-01 05:55:59',	28,	9),
(10,	98,	47,	51,	37,	'2017-06-11 02:38:00',	28,	9),
(11,	98,	47,	51,	37,	'2017-07-01 05:09:01',	28,	9);

DROP TABLE IF EXISTS `log_keluarga`;
CREATE TABLE `log_keluarga` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_kk` int(11) NOT NULL,
  `kk_sex` tinyint(2) DEFAULT NULL,
  `id_peristiwa` int(4) NOT NULL,
  `tgl_peristiwa` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_kk` (`id_kk`,`id_peristiwa`,`tgl_peristiwa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `log_penduduk`;
CREATE TABLE `log_penduduk` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `id_pend` int(11) NOT NULL,
  `id_detail` int(4) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bulan` varchar(2) NOT NULL,
  `tahun` varchar(4) NOT NULL,
  `tgl_peristiwa` date NOT NULL,
  `catatan` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_pend` (`id_pend`,`id_detail`,`tgl_peristiwa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `log_penduduk` (`id`, `id_pend`, `id_detail`, `tanggal`, `bulan`, `tahun`, `tgl_peristiwa`, `catatan`) VALUES
(1,	4722,	1,	'2016-09-05 19:35:24',	'09',	'2016',	'2016-09-06',	'Kembali lagi');

DROP TABLE IF EXISTS `log_perubahan_penduduk`;
CREATE TABLE `log_perubahan_penduduk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pend` int(11) NOT NULL,
  `id_cluster` varchar(200) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `log_surat`;
CREATE TABLE `log_surat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_format_surat` int(3) NOT NULL,
  `id_pend` int(11) NOT NULL,
  `id_pamong` int(4) NOT NULL,
  `id_user` int(4) NOT NULL,
  `tanggal` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `bulan` varchar(2) DEFAULT NULL,
  `tahun` varchar(4) DEFAULT NULL,
  `no_surat` varchar(20) DEFAULT NULL,
  `nama_surat` varchar(100) DEFAULT NULL,
  `lampiran` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `log_surat` (`id`, `id_format_surat`, `id_pend`, `id_pamong`, `id_user`, `tanggal`, `bulan`, `tahun`, `no_surat`, `nama_surat`, `lampiran`) VALUES
(1,	1,	3,	14,	1,	'2016-09-12 21:05:10',	'09',	'2016',	'KET/345',	'surat_ket_pengantar_5201140301900002_2016-09-13_KET-345.pdf',	NULL),
(2,	15,	8,	14,	1,	'2016-09-12 21:06:40',	'09',	'2016',	'USA/67/123',	'surat_ket_usaha_5201141412020001_2016-09-13_USA-67-123.pdf',	NULL),
(3,	1,	18,	20,	1,	'2016-09-12 21:07:53',	'09',	'2016',	'KET/346',	'surat_ket_pengantar_5201147112930055_2016-09-13_KET-346.pdf',	NULL),
(4,	12,	9,	14,	1,	'2016-09-12 21:09:02',	'09',	'2016',	'KM/104',	'surat_ket_kurang_mampu_5201140107850071_2016-09-13_KM-104.pdf',	NULL),
(5,	14,	25,	22,	1,	'2016-09-12 21:10:26',	'09',	'2016',	'HIL/503',	'surat_ket_kehilangan_5201142210790004_2016-09-13_HIL-503.pdf',	NULL),
(6,	2,	3,	14,	1,	'2017-04-02 00:08:20',	'04',	'2017',	'23',	'surat_ket_penduduk_5201140301916995_2017-04-02_23.rtf',	''),
(8,	2,	7,	21,	1,	'2017-04-02 02:13:17',	'04',	'2017',	'24',	'surat_ket_penduduk_5201144609786995_2017-04-02_24.rtf',	''),
(9,	13,	4,	21,	1,	'2017-05-06 01:52:06',	'05',	'2017',	'fsaf3343',	'surat_izin_keramaian_5201145003976995_2017-05-06_fsaf3343.rtf',	''),
(10,	18,	2,	14,	1,	'2017-06-11 02:43:09',	'06',	'2017',	'45',	'surat_ket_kelahiran_5201140706966997_2017-06-11_45.rtf',	''),
(11,	18,	7,	14,	1,	'2017-06-14 22:46:23',	'06',	'2017',	'34',	NULL,	NULL),
(12,	18,	7,	14,	1,	'2017-06-14 22:44:09',	'06',	'2017',	'34',	'surat_ket_kelahiran_5201144609786995_2017-06-15_34.rtf',	'');

DROP TABLE IF EXISTS `lokasi`;
CREATE TABLE `lokasi` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `desk` text NOT NULL,
  `nama` varchar(50) NOT NULL,
  `enabled` int(11) NOT NULL DEFAULT '1',
  `lat` varchar(30) NOT NULL,
  `lng` varchar(30) NOT NULL,
  `ref_point` int(9) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `id_cluster` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ref_point` (`ref_point`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `media_sosial`;
CREATE TABLE `media_sosial` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gambar` text NOT NULL,
  `link` text NOT NULL,
  `nama` varchar(100) NOT NULL,
  `enabled` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `media_sosial` (`id`, `gambar`, `link`, `nama`, `enabled`) VALUES
(1,	'fb.png',	'https://www.facebook.com/groups/OpenSID/',	'Facebook',	1),
(2,	'twt.png',	'',	'Twitter',	1),
(3,	'goo.png',	'',	'Google Plus',	1),
(4,	'yb.png',	'',	'YouTube',	1);

DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `link` varchar(500) NOT NULL,
  `tipe` int(4) NOT NULL,
  `parrent` int(4) NOT NULL DEFAULT '1',
  `link_tipe` tinyint(1) NOT NULL DEFAULT '0',
  `enabled` int(11) NOT NULL DEFAULT '1',
  `urut` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `menu` (`id`, `nama`, `link`, `tipe`, `parrent`, `link_tipe`, `enabled`, `urut`) VALUES
(16,	'Profil Desa',	'artikel/32',	1,	1,	1,	1,	NULL),
(17,	'Pemerintahan Desa',	'artikel/85',	1,	1,	1,	1,	NULL),
(19,	'Lembaga Masyarakat',	'artikel/38',	1,	1,	1,	2,	NULL),
(23,	'Teras Desa',	'',	2,	1,	1,	1,	NULL),
(24,	'Data Desa',	'artikel/97',	1,	1,	0,	1,	NULL),
(31,	'Data Wilayah Administratif',	'statistik/15',	3,	24,	1,	1,	NULL),
(32,	'Data Pendidikan dalam KK',	'statistik/0',	3,	24,	1,	1,	NULL),
(33,	'Data Pendidikan Ditempuh',	'statistik/17',	3,	24,	1,	1,	NULL),
(34,	'Data Pekerjaan',	'statistik/1',	3,	24,	1,	1,	NULL),
(35,	'Data Agama',	'statistik/3',	3,	24,	1,	1,	NULL),
(36,	'Data Jenis Kelamin',	'statistik/4',	3,	24,	1,	1,	NULL),
(40,	'Data Golongan Darah',	'statistik/7',	3,	24,	1,	2,	NULL),
(51,	'Data Kelompok Umur',	'statistik/12',	3,	24,	1,	2,	NULL),
(52,	'Data Penerima Raskin',	'statistik_k/2',	3,	24,	1,	2,	NULL),
(53,	'Data Penerima Jamkesmas',	'statistik_k/3',	3,	24,	1,	2,	NULL),
(55,	'Profil Wilayah Desa',	'artikel/33',	3,	16,	1,	1,	NULL),
(56,	'Profil Masyarakat Desa',	'artikel/34',	3,	16,	1,	2,	NULL),
(57,	'Visi dan Misi',	'artikel/93',	3,	17,	0,	1,	NULL),
(58,	'Pemerintah Desa',	'artikel/92',	3,	17,	0,	1,	NULL),
(59,	'Badan Permusyawaratan Desa',	'artikel/37',	3,	17,	0,	2,	NULL),
(62,	'Berita Desa',	'',	2,	1,	1,	1,	NULL),
(63,	'Agenda Desa',	'artikel/41',	2,	1,	1,	2,	NULL),
(64,	'Peraturan Desa',	'peraturan',	2,	1,	1,	2,	NULL),
(65,	'Panduan Layanan Desa',	'#',	2,	1,	1,	1,	NULL),
(66,	'Produk Desa',	'produk',	2,	1,	1,	1,	NULL),
(68,	'Undang undang',	'artikel/42',	3,	64,	1,	2,	NULL),
(69,	'Peraturan Pemerintah',	'artikel/43',	3,	64,	1,	2,	NULL),
(70,	'Peraturan Daerah',	'',	3,	64,	1,	2,	NULL),
(71,	'Peraturan Bupati',	'',	3,	64,	1,	2,	NULL),
(72,	'Peraturan Bersama KaDes',	'',	3,	64,	1,	2,	NULL),
(73,	'Informasi Publik',	'#',	2,	1,	1,	1,	NULL),
(75,	'Rencana Kerja Anggaran',	'',	3,	73,	1,	1,	NULL),
(76,	'RAPB Desa',	'',	3,	73,	1,	1,	NULL),
(77,	'APB Desa',	'',	3,	73,	1,	1,	NULL),
(78,	'DPA',	'',	3,	73,	1,	1,	NULL),
(80,	'Profil Potensi Desa',	'artikel/59',	3,	16,	1,	2,	NULL),
(84,	'LKMD',	'artikel/62',	3,	18,	1,	1,	NULL),
(85,	'PKK',	'artikel/63',	3,	18,	1,	1,	NULL),
(86,	'Karang Taruna',	'artikel/64',	3,	18,	1,	1,	NULL),
(87,	'RT RW',	'artikel/65',	3,	18,	1,	1,	NULL),
(88,	'Linmas',	'artikel/70',	3,	18,	1,	1,	NULL),
(89,	'TKP2KDes',	'artikel/66',	3,	18,	1,	1,	NULL),
(90,	'KPAD',	'artikel/67',	3,	18,	1,	1,	NULL),
(91,	'Kelompok Ternak',	'artikel/68',	3,	18,	1,	1,	NULL),
(92,	'Kelompok Tani',	'artikel/69',	3,	18,	1,	1,	NULL),
(93,	'Kelompok Ekonomi Lainya',	'artikel/71',	3,	18,	1,	1,	NULL),
(98,	'LKPJ',	'',	3,	73,	1,	1,	NULL),
(99,	'LPPD',	'',	3,	73,	1,	1,	NULL),
(100,	'ILPPD',	'',	3,	73,	1,	1,	NULL),
(101,	'Peraturan Desa',	'artikel/44',	3,	64,	1,	2,	NULL),
(102,	'Peraturan Kepala Desa',	'artikel/45',	3,	64,	1,	2,	NULL),
(103,	'Keputusan Kepala Desa',	'artikel/46',	3,	64,	1,	2,	NULL),
(104,	'PBB',	'',	3,	73,	1,	1,	NULL),
(106,	'Data Warga Negara',	'statistik/13',	3,	24,	1,	1,	NULL),
(108,	'Data Kelas Sosial',	'statistik_k/1',	3,	24,	1,	2,	NULL),
(109,	'Kontak',	'artikel/36',	1,	1,	1,	2,	NULL),
(110,	'Peraturan Desa',	'peraturan',	3,	66,	1,	1,	NULL),
(112,	'Coba',	'coba',	2,	1,	1,	1,	NULL),
(113,	'',	'',	3,	109,	0,	1,	NULL),
(114,	'Sejarah Desa',	'artikel/99',	3,	16,	0,	1,	NULL);

DROP TABLE IF EXISTS `outbox`;
CREATE TABLE `outbox` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SendingDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SendBefore` time NOT NULL DEFAULT '23:59:59',
  `SendAfter` time NOT NULL DEFAULT '00:00:00',
  `Text` text,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text,
  `Class` int(11) DEFAULT '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `MultiPart` enum('false','true') DEFAULT 'false',
  `RelativeValidity` int(11) DEFAULT '-1',
  `SenderID` varchar(255) DEFAULT NULL,
  `SendingTimeOut` timestamp NULL DEFAULT NULL,
  `DeliveryReport` enum('default','yes','no') DEFAULT 'default',
  `CreatorID` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `outbox_date` (`SendingDateTime`,`SendingTimeOut`),
  KEY `outbox_sender` (`SenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `pertanyaan`;
CREATE TABLE `pertanyaan` (
  `1` int(2) DEFAULT NULL,
  `Pendapatan perkapita perbulan` varchar(87) DEFAULT NULL,
  `36` int(2) DEFAULT NULL,
  `15` int(2) DEFAULT NULL,
  `24` int(2) DEFAULT NULL,
  `23` int(2) DEFAULT NULL,
  `26` int(2) DEFAULT NULL,
  `28` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `point`;
CREATE TABLE `point` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `simbol` varchar(50) NOT NULL,
  `tipe` int(4) NOT NULL,
  `parrent` int(4) NOT NULL DEFAULT '1',
  `enabled` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parrent` (`parrent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `point` (`id`, `nama`, `simbol`, `tipe`, `parrent`, `enabled`) VALUES
(1,	'Sarana Pendidikan',	'face-embarrassed.png',	0,	1,	1),
(2,	'Sarana Transportasi',	'face-devilish.png',	0,	1,	1),
(3,	'Sarana Kesehatan',	'emblem-photos.png',	0,	1,	1),
(4,	'SMA',	'gateswalls.png',	2,	38,	1),
(5,	'SMP (Sekolah Menengah Pertama)',	'arch.png',	2,	38,	1),
(6,	'Masjid',	'mosque.png',	2,	54,	1),
(7,	'Tempat Ibadah',	'emblem-art.png',	0,	1,	1),
(8,	'Kuil',	'moderntower.png',	2,	54,	1),
(9,	'RS',	'accerciser.png',	2,	40,	1),
(10,	'Sarana Pendidikan',	'cabin.png',	2,	38,	1);

DROP TABLE IF EXISTS `polygon`;
CREATE TABLE `polygon` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `simbol` varchar(50) NOT NULL,
  `color` varchar(10) NOT NULL DEFAULT 'ff0000',
  `tipe` int(4) NOT NULL,
  `parrent` int(4) DEFAULT '1',
  `enabled` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parrent` (`parrent`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `polygon` (`id`, `nama`, `simbol`, `color`, `tipe`, `parrent`, `enabled`) VALUES
(1,	'rawan topan',	'',	'7C78FF',	0,	1,	1),
(2,	'jalur selokan',	'',	'F4FF59',	0,	1,	1);

DROP TABLE IF EXISTS `program`;
CREATE TABLE `program` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `sasaran` tinyint(4) DEFAULT NULL,
  `ndesc` varchar(200) DEFAULT NULL,
  `sdate` date NOT NULL,
  `edate` date NOT NULL,
  `userid` mediumint(9) NOT NULL,
  `status` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `program` (`id`, `nama`, `sasaran`, `ndesc`, `sdate`, `edate`, `userid`, `status`) VALUES
(1,	'Raskin',	2,	'',	'2015-12-13',	'2017-12-13',	0,	NULL),
(2,	'BLSM',	2,	'',	'2015-12-13',	'2017-12-13',	0,	NULL),
(3,	'PKH',	2,	'',	'2015-12-13',	'2017-12-13',	0,	NULL),
(4,	'Bedah Rumah',	2,	'',	'2015-12-13',	'2017-12-13',	0,	NULL),
(5,	'JAMKESMAS',	1,	'',	'2015-12-13',	'2017-12-13',	0,	NULL);

DROP TABLE IF EXISTS `program_peserta`;
CREATE TABLE `program_peserta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `peserta` decimal(16,0) NOT NULL,
  `program_id` int(11) NOT NULL,
  `sasaran` tinyint(4) DEFAULT NULL,
  `no_id_kartu` varchar(30) DEFAULT NULL,
  `kartu_nik` decimal(16,0) DEFAULT NULL,
  `kartu_nama` varchar(100) DEFAULT NULL,
  `kartu_tempat_lahir` varchar(100) DEFAULT NULL,
  `kartu_tanggal_lahir` date DEFAULT NULL,
  `kartu_alamat` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `program_peserta` (`id`, `peserta`, `program_id`, `sasaran`, `no_id_kartu`, `kartu_nik`, `kartu_nama`, `kartu_tempat_lahir`, `kartu_tanggal_lahir`, `kartu_alamat`) VALUES
(2,	5201140104126994,	1,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	5201140105136997,	1,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	5201140104126995,	2,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	5201140105136997,	2,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	5201140104126995,	3,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	5201140105136997,	3,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	5201140104166999,	4,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	5201140105136997,	4,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	5201142005716996,	5,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	5201140706966997,	5,	2,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `ref_kelas_sosial`;
CREATE TABLE `ref_kelas_sosial` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `ref_kelas_sosial` (`id`, `nama`) VALUES
(1,	'Tidak Miskin'),
(2,	'Sedang'),
(3,	'Miskin'),
(4,	'Sangat Miskin');

DROP TABLE IF EXISTS `sentitems`;
CREATE TABLE `sentitems` (
  `UpdatedInDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `InsertIntoDB` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SendingDateTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `DeliveryDateTime` timestamp NULL DEFAULT NULL,
  `Text` text NOT NULL,
  `DestinationNumber` varchar(20) NOT NULL DEFAULT '',
  `Coding` enum('Default_No_Compression','Unicode_No_Compression','8bit','Default_Compression','Unicode_Compression') NOT NULL DEFAULT 'Default_No_Compression',
  `UDH` text NOT NULL,
  `SMSCNumber` varchar(20) NOT NULL DEFAULT '',
  `Class` int(11) NOT NULL DEFAULT '-1',
  `TextDecoded` text NOT NULL,
  `ID` int(10) unsigned NOT NULL DEFAULT '0',
  `SenderID` varchar(255) NOT NULL,
  `SequencePosition` int(11) NOT NULL DEFAULT '1',
  `Status` enum('SendingOK','SendingOKNoReport','SendingError','DeliveryOK','DeliveryFailed','DeliveryPending','DeliveryUnknown','Error') NOT NULL DEFAULT 'SendingOK',
  `StatusError` int(11) NOT NULL DEFAULT '-1',
  `TPMR` int(11) NOT NULL DEFAULT '-1',
  `RelativeValidity` int(11) NOT NULL DEFAULT '-1',
  `CreatorID` text NOT NULL,
  PRIMARY KEY (`ID`,`SequencePosition`),
  KEY `sentitems_date` (`DeliveryDateTime`),
  KEY `sentitems_tpmr` (`TPMR`),
  KEY `sentitems_dest` (`DestinationNumber`),
  KEY `sentitems_sender` (`SenderID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `setting_aplikasi`;
CREATE TABLE `setting_aplikasi` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL,
  `value` varchar(200) DEFAULT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `jenis` varchar(30) DEFAULT NULL,
  `kategori` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `setting_aplikasi` (`id`, `key`, `value`, `keterangan`, `jenis`, `kategori`) VALUES
(1,	'sebutan_kabupaten',	'kabupaten',	'Pengganti sebutan wilayah kabupaten',	'',	''),
(2,	'sebutan_kabupaten_singkat',	'kab.',	'Pengganti sebutan singkatan wilayah kabupaten',	'',	''),
(3,	'sebutan_kecamatan',	'kecamatan',	'Pengganti sebutan wilayah kecamatan',	'',	''),
(4,	'sebutan_kecamatan_singkat',	'kec.',	'Pengganti sebutan singkatan wilayah kecamatan',	'',	''),
(5,	'sebutan_desa',	'desa',	'Pengganti sebutan wilayah desa',	'',	''),
(6,	'sebutan_dusun',	'dusun',	'Pengganti sebutan wilayah dusun',	'',	''),
(7,	'sebutan_camat',	'camat',	'Pengganti sebutan jabatan camat',	'',	''),
(8,	'website_title',	'Website Resmi',	'Judul tab browser modul web',	'',	'web'),
(9,	'login_title',	'OpenSID',	'Judul tab browser halaman login modul administrasi',	'',	''),
(10,	'admin_title',	'Sistem Informasi Desa',	'Judul tab browser modul administrasi',	'',	''),
(11,	'web_theme',	'hadakewa',	'Tema penampilan modul web',	'',	'web'),
(12,	'offline_mode',	'0',	'Apakah modul web akan ditampilkan atau tidak',	'',	''),
(13,	'enable_track',	'1',	'Apakah akan mengirimkan data statistik ke tracker',	'boolean',	''),
(14,	'dev_tracker',	'',	'Host untuk tracker pada development',	'',	'development'),
(15,	'nomor_terakhir_semua_surat',	'0',	'Gunakan nomor surat terakhir untuk seluruh surat tidak per jenis surat',	'boolean',	''),
(16,	'google_key',	'',	'Google API Key untuk Google Maps',	'',	'web'),
(17,	'libreoffice_path',	'',	'Path tempat instal libreoffice di server SID',	'',	'');

DROP TABLE IF EXISTS `setting_modul`;
CREATE TABLE `setting_modul` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modul` varchar(50) NOT NULL,
  `url` varchar(50) NOT NULL,
  `aktif` tinyint(1) NOT NULL DEFAULT '0',
  `ikon` varchar(50) NOT NULL,
  `urut` tinyint(4) NOT NULL,
  `level` tinyint(1) NOT NULL DEFAULT '2',
  `hidden` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `setting_modul` (`id`, `modul`, `url`, `aktif`, `ikon`, `urut`, `level`, `hidden`) VALUES
(1,	'SID Home',	'hom_desa',	1,	'go-home-5.png',	1,	2,	1),
(2,	'Penduduk',	'penduduk/clear',	1,	'preferences-contact-list.png',	2,	2,	0),
(3,	'Statistik',	'statistik',	1,	'statistik.png',	3,	2,	0),
(4,	'Cetak Surat',	'surat',	1,	'applications-office-5.png',	4,	2,	0),
(5,	'Analisis',	'analisis_master/clear',	1,	'analysis.png',	5,	2,	0),
(6,	'Bantuan',	'program_bantuan',	1,	'program.png',	6,	2,	0),
(7,	'Persil',	'data_persil/clear',	1,	'persil.png',	7,	2,	0),
(8,	'Plan',	'plan',	1,	'plan.png',	8,	2,	0),
(9,	'Peta',	'gis',	1,	'gis.png',	9,	2,	0),
(10,	'SMS',	'sms',	1,	'mail-send-receive.png',	10,	2,	0),
(11,	'Pengguna',	'man_user/clear',	1,	'system-users.png',	11,	1,	1),
(12,	'Database',	'database',	1,	'database.png',	12,	1,	0),
(13,	'Admin Web',	'web',	1,	'message-news.png',	13,	4,	0),
(14,	'Laporan',	'lapor',	1,	'mail-reply-all.png',	14,	2,	0);

DROP TABLE IF EXISTS `setting_sms`;
CREATE TABLE `setting_sms` (
  `autoreply_text` varchar(160) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `setting_sms` (`autoreply_text`) VALUES
('Terima kasih pesan Anda telah kami terima.');

DROP TABLE IF EXISTS `sys_traffic`;
CREATE TABLE `sys_traffic` (
  `Tanggal` date NOT NULL,
  `ipAddress` text NOT NULL,
  `Jumlah` int(10) NOT NULL,
  PRIMARY KEY (`Tanggal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `sys_traffic` (`Tanggal`, `ipAddress`, `Jumlah`) VALUES
('2014-11-15',	'::1{}',	1),
('2014-11-16',	'::1{}',	1),
('2014-11-18',	'',	3),
('2014-11-21',	'',	3),
('2014-11-26',	'::1{}',	1),
('2014-12-03',	'127.0.0.1{}',	1),
('2014-12-04',	'',	3),
('2014-12-05',	'',	5),
('2014-12-06',	'127.0.0.1{}',	1),
('2014-12-08',	'127.0.0.1{}',	1),
('2014-12-09',	'127.0.0.1{}',	1),
('2014-12-10',	'',	3),
('2016-05-25',	'',	2),
('2016-05-26',	'',	4),
('2016-05-27',	'',	2),
('2016-05-28',	'10.0.2.2{}',	1),
('2016-05-29',	'',	2),
('2016-05-30',	'10.0.2.2{}',	1),
('2016-05-31',	'',	3),
('2016-06-01',	'10.0.2.2{}',	1),
('2016-08-23',	'',	6),
('2016-08-24',	'',	7),
('2016-08-26',	'',	8),
('2016-08-27',	'192.168.1.66{}',	1),
('2016-08-28',	'',	3),
('2016-08-29',	'',	2),
('2016-08-30',	'',	3),
('2016-08-31',	'127.0.0.1{}',	1),
('2016-09-02',	'',	4),
('2016-09-03',	'',	2),
('2016-09-04',	'10.0.2.2{}',	1),
('2016-09-05',	'',	2),
('2016-09-07',	'',	2),
('2016-09-08',	'10.0.2.2{}',	1),
('2016-09-09',	'',	4),
('2016-09-10',	'',	4),
('2016-09-11',	'',	2),
('2016-09-14',	'',	4),
('2016-12-29',	'',	2),
('2017-02-11',	'',	2),
('2017-04-02',	'',	3),
('2017-04-22',	'',	3),
('2017-04-24',	'',	2),
('2017-04-30',	'127.0.0.1{}',	1),
('2017-05-01',	'127.0.0.1{}',	1),
('2017-05-06',	'',	2),
('2017-06-10',	'',	2),
('2017-06-11',	'',	4),
('2017-06-15',	'127.0.0.1{}',	1),
('2017-07-02',	'127.0.0.1{}',	1);

DROP TABLE IF EXISTS `tweb_cacat`;
CREATE TABLE `tweb_cacat` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_cacat` (`id`, `nama`) VALUES
(1,	'CACAT FISIK'),
(2,	'CACAT NETRA/BUTA'),
(3,	'CACAT RUNGU/WICARA'),
(4,	'CACAT MENTAL/JIWA'),
(5,	'CACAT FISIK DAN MENTAL'),
(6,	'CACAT LAINNYA'),
(7,	'TIDAK CACAT');

DROP TABLE IF EXISTS `tweb_cara_kb`;
CREATE TABLE `tweb_cara_kb` (
  `id` tinyint(5) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `sex` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_cara_kb` (`id`, `nama`, `sex`) VALUES
(1,	'Pil',	2),
(2,	'IUD',	2),
(3,	'Suntik',	2),
(4,	'Kondom',	1),
(5,	'Susuk KB',	2),
(6,	'Sterilisasi Wanita',	2),
(7,	'Sterilisasi Pria',	1),
(99,	'Lainnya',	3);

DROP TABLE IF EXISTS `tweb_desa_pamong`;
CREATE TABLE `tweb_desa_pamong` (
  `pamong_id` int(5) NOT NULL AUTO_INCREMENT,
  `pamong_nama` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pamong_nip` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pamong_nik` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `jabatan` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0',
  `pamong_status` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pamong_tgl_terdaftar` date DEFAULT NULL,
  `foto` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`pamong_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `tweb_desa_pamong` (`pamong_id`, `pamong_nama`, `pamong_nip`, `pamong_nik`, `jabatan`, `pamong_status`, `pamong_tgl_terdaftar`, `foto`) VALUES
(14,	'Muhammad Ilham ',	'',	'',	'Kepala Desa',	'1',	'2014-04-20',	''),
(20,	'Mustahiq S.Adm',	'197905062010011007',	'5201140506790001',	'Sekretaris Desa',	'1',	'2016-08-23',	''),
(21,	'Syafruddin ',	'-',	'5201140911720004',	'Kaur Pemerintahan ',	'1',	'2016-08-23',	''),
(22,	'Supardi Rustam ',	'-',	'5201140101710003',	'Kaur Umum ',	'1',	'2016-08-23',	''),
(23,	'Mardiana ',	'-',	'5201145203810001',	'Kaur Keuangan',	'1',	'2016-08-23',	''),
(24,	'Syafi-i. SE ',	'-',	'5201140506730002',	'Kaur Pembangunan ',	'1',	'2016-08-23',	''),
(25,	'Mahrup ',	'',	'',	'Kaur Keamanan dan Ketertiban',	'1',	'2016-08-23',	'');

DROP TABLE IF EXISTS `tweb_golongan_darah`;
CREATE TABLE `tweb_golongan_darah` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_golongan_darah` (`id`, `nama`) VALUES
(1,	'A'),
(2,	'B'),
(3,	'AB'),
(4,	'O'),
(5,	'A+'),
(6,	'A-'),
(7,	'B+'),
(8,	'B-'),
(9,	'AB+'),
(10,	'AB-'),
(11,	'O+'),
(12,	'O-'),
(13,	'TIDAK TAHU');

DROP TABLE IF EXISTS `tweb_keluarga`;
CREATE TABLE `tweb_keluarga` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `no_kk` varchar(160) DEFAULT NULL,
  `nik_kepala` varchar(200) DEFAULT NULL,
  `tgl_daftar` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `kelas_sosial` int(4) DEFAULT NULL,
  `tgl_cetak_kk` datetime DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `id_cluster` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `nik_kepala` (`nik_kepala`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_keluarga` (`id`, `no_kk`, `nik_kepala`, `tgl_daftar`, `kelas_sosial`, `tgl_cetak_kk`, `alamat`, `id_cluster`) VALUES
(1,	'5201140104126994',	'1',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	4),
(2,	'5201140104126995',	'5',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	8),
(3,	'5201140104166999',	'9',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	12),
(4,	'5201140105136997',	'12',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	16),
(5,	'5201140106166996',	'16',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	8),
(6,	'5201140106167002',	'17',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	17),
(7,	'5201140106167003',	'19',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	16),
(8,	'5201140107126996',	'21',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	18),
(9,	'5201140108146995',	'25',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	18),
(10,	'5201140109126996',	'26',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	19),
(11,	'5201140109156994',	'30',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	19),
(12,	'5201140110137011',	'32',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	20),
(13,	'5201140110137038',	'35',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	18),
(14,	'5201140110156997',	'37',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	18),
(15,	'5201140111126997',	'38',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	17),
(16,	'5201140111126999',	'39',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	21),
(17,	'5201140112107003',	'42',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	12),
(18,	'5201140112126998',	'45',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	22),
(19,	'5201140202167000',	'51',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	23),
(20,	'5201140202167002',	'52',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	24),
(21,	'5201140203136994',	'55',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	8),
(22,	'5201140203136995',	'56',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	16),
(23,	'5201140203167003',	'59',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	23),
(24,	'5201140204166994',	'61',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	25),
(25,	'5201140205156994',	'62',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	26),
(26,	'5201140205156995',	'65',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	26),
(27,	'5201140205156996',	'68',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	25),
(28,	'5201140205156997',	'71',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	25),
(29,	'5201140206157000',	'74',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	17),
(30,	'5201140206157004',	'76',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	27),
(31,	'5201140207156998',	'77',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	28),
(32,	'5201140207157000',	'80',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	29),
(33,	'5201140209156996',	'83',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	30),
(34,	'5201140210137022',	'84',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	29),
(35,	'5201140211117001',	'88',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	31),
(36,	'5201140211117002',	'91',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	31),
(37,	'5201140211117003',	'95',	'2016-09-14 06:28:03',	NULL,	NULL,	NULL,	31);

DROP TABLE IF EXISTS `tweb_penduduk`;
CREATE TABLE `tweb_penduduk` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `nik` decimal(16,0) NOT NULL,
  `id_kk` int(11) DEFAULT '0',
  `kk_level` tinyint(2) NOT NULL DEFAULT '0',
  `id_rtm` int(11) NOT NULL,
  `rtm_level` int(11) NOT NULL,
  `sex` tinyint(4) unsigned DEFAULT NULL,
  `tempatlahir` varchar(100) NOT NULL,
  `tanggallahir` date DEFAULT NULL,
  `agama_id` int(10) unsigned NOT NULL,
  `pendidikan_kk_id` int(10) unsigned NOT NULL,
  `pendidikan_id` int(10) unsigned NOT NULL,
  `pendidikan_sedang_id` int(10) unsigned NOT NULL,
  `pekerjaan_id` int(10) unsigned NOT NULL,
  `status_kawin` tinyint(4) unsigned NOT NULL,
  `warganegara_id` int(10) unsigned NOT NULL,
  `dokumen_pasport` varchar(45) DEFAULT NULL,
  `dokumen_kitas` int(10) DEFAULT NULL,
  `ayah_nik` varchar(16) NOT NULL,
  `ibu_nik` varchar(16) NOT NULL,
  `nama_ayah` varchar(100) NOT NULL,
  `nama_ibu` varchar(100) NOT NULL,
  `foto` varchar(100) NOT NULL,
  `golongan_darah_id` int(11) NOT NULL,
  `id_cluster` int(11) NOT NULL,
  `status` int(10) unsigned DEFAULT NULL,
  `alamat_sebelumnya` varchar(200) NOT NULL,
  `alamat_sekarang` varchar(200) NOT NULL,
  `status_dasar` tinyint(4) NOT NULL DEFAULT '1',
  `hamil` int(1) DEFAULT NULL,
  `cacat_id` int(11) DEFAULT NULL,
  `sakit_menahun_id` int(11) NOT NULL,
  `akta_lahir` varchar(40) NOT NULL,
  `akta_perkawinan` varchar(40) NOT NULL,
  `tanggalperkawinan` date DEFAULT NULL,
  `akta_perceraian` varchar(40) NOT NULL,
  `tanggalperceraian` date DEFAULT NULL,
  `cara_kb_id` tinyint(2) DEFAULT NULL,
  `no_kk_sebelumnya` varchar(30) DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL,
  `tanggal_akhir_paspor` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk` (`id`, `nama`, `nik`, `id_kk`, `kk_level`, `id_rtm`, `rtm_level`, `sex`, `tempatlahir`, `tanggallahir`, `agama_id`, `pendidikan_kk_id`, `pendidikan_id`, `pendidikan_sedang_id`, `pekerjaan_id`, `status_kawin`, `warganegara_id`, `dokumen_pasport`, `dokumen_kitas`, `ayah_nik`, `ibu_nik`, `nama_ayah`, `nama_ibu`, `foto`, `golongan_darah_id`, `id_cluster`, `status`, `alamat_sebelumnya`, `alamat_sekarang`, `status_dasar`, `hamil`, `cacat_id`, `sakit_menahun_id`, `akta_lahir`, `akta_perkawinan`, `tanggalperkawinan`, `akta_perceraian`, `tanggalperceraian`, `cara_kb_id`, `no_kk_sebelumnya`, `telepon`, `tanggal_akhir_paspor`) VALUES
(1,	'AHLUL',	5201142005716996,	1,	1,	0,	0,	1,	'MANGSIT',	'1970-05-20',	1,	3,	0,	18,	26,	2,	1,	'',	0,	'',	'',	'ARFAH',	'RAISAH',	'',	13,	4,	1,	'',	'',	1,	0,	0,	0,	'',	'',	NULL,	'',	NULL,	0,	NULL,	NULL,	NULL),
(2,	'AHMAD ALLIF RIZKI',	5201140706966997,	1,	4,	0,	0,	1,	'MANGSIT',	'1995-06-07',	1,	1,	0,	18,	1,	1,	1,	'',	0,	'',	'',	'AHLUL',	'RUSDAH',	'',	13,	4,	1,	'',	'',	1,	0,	0,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(3,	'AHMAD HABIB',	5201140301916995,	1,	4,	0,	0,	1,	'MANGSIT',	'1990-01-03',	1,	3,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'AHLUL',	'RUSDAH',	'',	13,	4,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(4,	'ADINI SEPTIA LISTA',	5201145003976995,	1,	4,	1,	1,	2,	'MANGSIT',	'1996-03-10',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'AHLUL',	'RUSDAH',	'',	13,	4,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(5,	'AHYAR',	5201141003666996,	2,	1,	0,	0,	1,	'JAKARTA',	'1965-03-10',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'PAIMUN',	'SUPINAH',	'',	13,	8,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(6,	'APTA MADA RIZKY ALAMSYAH',	5201141412121724,	2,	4,	0,	0,	1,	'DEPOK',	'2002-12-14',	1,	2,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'AHYAR',	'ALIYAH',	'',	13,	8,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(7,	'ALIYAH',	5201144609786995,	2,	3,	0,	0,	2,	'BEKASI',	'1977-09-06',	1,	5,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'TAGOR SIPAHUTAR',	'AMAHWATI',	'',	13,	8,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(8,	'ALPIANI',	5201144301171725,	2,	4,	0,	0,	2,	'BOGOR',	'2007-01-03',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'AHYAR',	'ALIYAH',	'',	13,	8,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(9,	'ASHARI',	5201140107867064,	3,	1,	0,	0,	1,	'KERANDANGAN',	'1985-12-30',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'H. ABDUL KARIM',	'RADIAH',	'',	13,	12,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(10,	'BACHTIAR HADI',	5201142210181724,	3,	4,	0,	0,	1,	'MATARAM',	'2008-10-22',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'ASHARI',	'ANGGUN LESTARI PRATAMA',	'',	13,	12,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(11,	'ANGGUN LESTARI PRATAMA',	5201146510916995,	3,	3,	0,	0,	2,	'SENGGIGI',	'1990-10-25',	1,	4,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'SADIRAH',	'HJ. ROHANI',	'',	13,	12,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(12,	'DAHRI',	5201143112797117,	4,	1,	0,	0,	1,	'MASBAGIK',	'1978-12-31',	1,	3,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'AMAQ SAHMINI',	'INAQ SAHMINI',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(13,	'ERLANGGA DWIKO SAPUTRO',	5201140705156994,	4,	4,	0,	0,	1,	'MENINTING',	'2014-05-07',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'DAHRI',	'ASMIATUN',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(14,	'FARIDAH',	5201141107101724,	4,	4,	0,	0,	1,	'MASBAGIK',	'2000-07-11',	1,	3,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'DAHRI',	'ASMIATUN',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(15,	'ASMIATUN',	5201147112817188,	4,	3,	0,	0,	2,	'MASBAGIK',	'1980-12-31',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'AMAQ MUJAENI',	'INAQ SAHMINI',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(16,	'BAIQ OLIVIA APRILLIANI',	5201145211486994,	5,	1,	0,	0,	2,	'SENGGIGI',	'1947-11-12',	1,	1,	0,	18,	1,	4,	1,	NULL,	NULL,	'',	'',	'AMAQ SINAREP',	'INAQ SINAREP',	'',	13,	8,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(17,	'FAUZI',	5201141210906998,	6,	1,	0,	0,	1,	'KERANDANGAN',	'1989-10-12',	1,	5,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'SABLI',	'RAOHUN',	'',	13,	17,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(18,	'DELLA MAHARANI NINGSIH',	5201147112947048,	6,	9,	0,	0,	2,	'KERANDANGAN',	'1993-12-31',	1,	4,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'SABLI',	'RAOHUN',	'',	13,	17,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(19,	'HAERUL FATONI',	5201142911936995,	7,	1,	0,	0,	1,	'SENGGIGI',	'1992-11-29',	1,	5,	0,	18,	15,	2,	1,	NULL,	NULL,	'',	'',	'ANGKASAH',	'MARJANAH',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(20,	'DENATUL SUARTINI',	3275014601977005,	7,	3,	0,	0,	2,	'JAKARTA',	'1996-01-06',	1,	5,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'G. AMIN. P',	'NGATI',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(21,	'HERI IRAWAN',	5201140607636994,	8,	1,	0,	0,	1,	'TELOKE',	'1962-07-06',	1,	3,	0,	18,	9,	2,	1,	NULL,	NULL,	'',	'',	'AMAK MAJUMI',	'INAK MIDAH',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(22,	'HERMAN',	5201140305936994,	8,	4,	0,	0,	1,	'SENGGIGI',	'1992-05-03',	1,	4,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'HERI IRAWAN',	'DEWI SAULINA',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(23,	'DEWI SAULINA',	5201144808686994,	8,	3,	0,	0,	2,	'KEKERAN',	'1967-08-08',	1,	1,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'H. ZAENUDIN',	'INAK NAH',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(24,	'ELOK KHALISA SABRINA',	5201144408886994,	8,	4,	0,	0,	2,	'SENGGIGI',	'1987-08-04',	1,	4,	0,	18,	88,	1,	1,	NULL,	NULL,	'',	'',	'SERIMAN',	'DEWI SAULINA',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(25,	'I KETUT PAHING',	5201142210806997,	9,	1,	0,	0,	1,	'MATARAM',	'1979-10-22',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	2,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(26,	'IDA BAGUS MAS BUJANA',	5201143112707040,	10,	1,	0,	0,	1,	'APIT AIK',	'1969-12-31',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'SAHMIN',	'MAOSIN',	'',	13,	19,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(27,	'JOKO PATMOTO',	5201141009146994,	10,	4,	0,	0,	1,	'MANGSIT',	'2013-09-10',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'IDA BAGUS MAS BUJANA',	'FITRIANI',	'',	13,	19,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(28,	'KOMANG SALUN',	5201143105121724,	10,	4,	0,	0,	1,	'KAYANGAN',	'2002-05-31',	1,	2,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'AMILUDIN',	'FITRIANI',	'',	13,	19,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(29,	'FITRIANI',	5201145107836994,	10,	3,	0,	0,	2,	'KAYANGAN',	'1982-07-11',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'REMBUK',	'SITIAH',	'',	13,	19,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(30,	'LALU WAWAN DININGRAT',	5201141206886994,	11,	1,	0,	0,	1,	'MANGSIT',	'1987-06-12',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'MAHSUN SUBUH',	'SARDIAH',	'',	13,	19,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(31,	'FITRIANI',	5271016801926995,	11,	3,	0,	0,	2,	'MATARAM',	'1991-01-28',	1,	5,	0,	18,	15,	2,	1,	NULL,	NULL,	'',	'',	'UMAR',	'RUMINSIH',	'',	13,	19,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(32,	'M. FA\'IZ AZAMI',	5201143112897123,	12,	1,	0,	0,	1,	'GEGELANG',	'1988-12-31',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'SAREH',	'SUTIMAH',	'',	13,	20,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(33,	'HILMIATI',	5201146402906994,	12,	3,	0,	0,	2,	'LOCO',	'1989-02-24',	1,	4,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'H. MANSYUR',	'HJ. SA\'ADAH',	'',	13,	20,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(34,	'HJ. PARIDAH',	5201144912146994,	12,	4,	0,	0,	2,	'MENINTING',	'2013-12-09',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'M. FA\'IZ AZAMI',	'HILMIATI',	'',	13,	20,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(35,	'HJ. SAMIRAH',	5201147112767266,	13,	1,	0,	0,	2,	'SENGGIGI',	'1975-12-31',	1,	3,	0,	18,	15,	3,	1,	NULL,	NULL,	'',	'',	'DAMSYAH',	'MARWIYAH',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(36,	'HUR MINAH',	5201144504131726,	13,	4,	0,	0,	2,	'SENGGIGI',	'2003-04-05',	1,	3,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'MARSINI',	'KHODIJAH',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(37,	'HUSNAH',	5201145905936994,	14,	1,	0,	0,	2,	'LOTIM',	'1992-05-19',	1,	4,	0,	18,	88,	1,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	18,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(38,	'IDA AYU OKA SUKERTI',	5201147112587053,	15,	1,	0,	0,	2,	'KERANDANGAN',	'1957-12-31',	1,	3,	0,	18,	88,	4,	1,	NULL,	NULL,	'',	'',	'ANGGRAH',	'HABIBAH',	'',	13,	17,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(39,	'M. JAYADI',	5201143112837098,	16,	1,	0,	0,	1,	'SENGGIGI',	'1982-12-31',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'IKHSAN',	'SAIDAH',	'',	13,	21,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(40,	'JARIYAH',	5201145406916994,	16,	3,	0,	0,	2,	'SENGGIGI',	'1990-06-14',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'SEGEP',	'HURNIWATI',	'',	13,	21,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(41,	'LIHAM SATUN',	5201147112116995,	16,	4,	0,	0,	2,	'MATARAM',	'2010-12-31',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'M. JAYADI',	'JARIYAH',	'',	13,	21,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(42,	'M. NUR SAHID',	5201140507916996,	17,	1,	0,	0,	1,	'KERANDANGAN',	'1990-07-05',	1,	4,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	12,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(43,	'MADE ASTAWE',	5201142503181724,	17,	4,	0,	0,	1,	'KERANDANGAN',	'2008-03-25',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'M. NUR SAHID',	'MAISAH',	'',	13,	12,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(44,	'MAISAH',	5201144605936994,	17,	3,	0,	0,	2,	'KERANDANGAN',	'1992-05-06',	4,	1,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	12,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(45,	'MARSUNIN YOGA PRATAMA',	5201143112677056,	18,	1,	0,	0,	1,	'PEJARAKAN',	'1966-12-31',	1,	3,	0,	18,	9,	2,	1,	NULL,	NULL,	'',	'',	'MISRAH',	'INAQ MISDAH',	'',	13,	22,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(46,	'MARZUKI',	5201141003966996,	18,	4,	0,	0,	1,	'LOCO',	'1995-03-10',	1,	5,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'MARSUNIN YOGA PRATAMA',	'MARLIA SAJIDA',	'',	13,	22,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(47,	'MUHAMAD HAMDI',	5201141706986996,	18,	4,	0,	0,	1,	'LOCO',	'1997-06-17',	1,	4,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'MARSUNIN YOGA PRATAMA',	'MARLIA SAJIDA',	'',	13,	22,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(48,	'MARLIA SAJIDA',	5201147112707088,	18,	3,	0,	0,	2,	'PEJARAKAN',	'1969-12-31',	1,	3,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'H. ZAINUDIN',	'INAQ NAH',	'',	13,	22,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(49,	'MIRA FANDA',	5201146704906995,	18,	4,	0,	0,	2,	'LOCO',	'1989-04-27',	1,	5,	0,	18,	88,	4,	1,	NULL,	NULL,	'',	'',	'MARSUNIN YOGA PRATAMA',	'MARLIA SAJIDA',	'',	13,	22,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(50,	'MUNAAH',	5201146304171724,	18,	4,	0,	0,	2,	'LOCO',	'2007-04-23',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'MARSUNIN YOGA PRATAMA',	'MARLIA SAJIDA',	'',	13,	22,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(51,	'MUHAMAD KABIR',	5201140107917031,	19,	1,	0,	0,	1,	'SENGGIGI',	'1985-12-31',	1,	3,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'MUNIAH',	'SALIKIN',	'',	13,	23,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(52,	'MUHAMAD SUHAD',	5201141704876995,	20,	1,	0,	0,	1,	'SENGGIGI',	'1982-12-10',	1,	5,	0,	18,	15,	2,	1,	NULL,	NULL,	'',	'',	'MUNIAH',	'HAJRIAH',	'',	13,	24,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(53,	'MUHAMMAD HAIKAL FIRMANSYAH',	5201140308151724,	20,	4,	0,	0,	1,	'LOCO',	'2005-08-03',	1,	2,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'MUHAMAD SUHAD',	'KHADIJAH',	'',	13,	24,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(54,	'MURNIAH',	5201145904846994,	20,	3,	0,	0,	2,	'SETANGI',	'1991-03-04',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'SAHABUDIN',	'SAKMAH',	'',	13,	24,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(55,	'MURNIATI SAGITA',	5201144112726996,	21,	1,	0,	0,	2,	'YOGYAKARTA',	'1971-12-01',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'UMAR SANTOSA',	'MIRANTI',	'',	1,	8,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(56,	'MUHAMMAD RIFAI',	5201143105926995,	22,	1,	0,	0,	1,	'LOCO',	'1991-05-31',	4,	4,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'I WAYAN MERTI',	'NI NYOMAN RENI',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(57,	'NADIA ROSDIANA',	5201144305936996,	22,	3,	0,	0,	2,	'MATARAM',	'1992-05-03',	4,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'I WAYAN PARTA',	'NI NENGAH SUDINI',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(58,	'NI KOMANG PONIASIH',	5201146206126994,	22,	4,	0,	0,	2,	'MATARAM',	'2011-06-22',	4,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'MURNIATI SAGITA',	'NADIA ROSDIANA',	'',	13,	16,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(59,	'MUHAMMAD WIRDA MAULANA IBRAHIM',	5201143112417056,	23,	1,	0,	0,	1,	'SENGGIGI',	'1940-12-31',	1,	1,	0,	18,	9,	2,	1,	NULL,	NULL,	'',	'',	'AMAQ SUN -ALM-',	'INAQ SUN -ALM-',	'',	13,	23,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(60,	'NI LUH NITA SARI',	5201147112466997,	23,	3,	0,	0,	2,	'SENTELUK',	'1945-12-31',	1,	1,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'AMAQ IRAH',	'INAQ IRAH',	'',	13,	23,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(61,	'NI NENGAH AYU KARSINI',	5201145505946996,	24,	1,	0,	0,	2,	'SENGGIGI',	'1993-05-15',	1,	2,	0,	18,	15,	1,	1,	NULL,	NULL,	'',	'',	'H HAMDANI',	'SANERIAH',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(62,	'MUKSAN',	5201143112957094,	25,	1,	0,	0,	1,	'MANGSIT',	'1994-12-31',	1,	4,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'MISDAH',	'RABIAH',	'',	13,	26,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(63,	'NURHAYATI',	5201145509146994,	25,	4,	0,	0,	2,	'MENINTING',	'2013-09-15',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'MUKSAN',	'NUR\'AINI',	'',	13,	26,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(64,	'MURSIDIN',	5201142204966994,	26,	4,	0,	0,	1,	'MANGSIT',	'1995-04-22',	1,	3,	0,	18,	11,	1,	1,	NULL,	NULL,	'',	'',	'RUSNAH (ALM)',	'NURHIDAYAH',	'',	13,	26,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(65,	'NURHIDAYAH',	5201144209766995,	26,	1,	0,	0,	2,	'MANGSIT',	'1975-09-02',	1,	3,	0,	18,	2,	4,	1,	NULL,	NULL,	'',	'',	'ISMAIL',	'JUMINAH',	'',	13,	26,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(66,	'NURJANAH',	5201145005101724,	26,	4,	0,	0,	2,	'MONTONG',	'2000-05-10',	1,	4,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'RUSNAH (ALM)',	'NURHIDAYAH',	'',	13,	26,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(67,	'NURUL AINUN',	5201144108121724,	26,	4,	0,	0,	2,	'MANGSIT',	'2002-08-01',	1,	2,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'RUSNAH',	'NURHIDAYAH',	'',	13,	26,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(68,	'MUSAHAB',	5201141607936996,	27,	1,	0,	0,	1,	'LOTENG',	'1992-07-16',	1,	6,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'LALU ROSIDI',	'BQ. ALISA',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(69,	'NURUL FAIZAH',	5201145003936994,	27,	3,	0,	0,	2,	'SENGGIGI',	'1992-03-10',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'SAHUR',	'SARE\'AH',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(70,	'NURUL HIDAYATI',	5201147004136996,	27,	4,	0,	0,	2,	'MATARAM',	'2012-04-30',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'MUSAHAB',	'NURUL FAIZAH',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(71,	'NAPIAH',	5201141303906995,	28,	1,	0,	0,	1,	'SENGGIGI',	'1989-03-13',	1,	4,	0,	18,	11,	2,	1,	NULL,	NULL,	'',	'',	'MUNIAH',	'HAJARIAH',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(72,	'RACHEL YULIANTI',	5201146507966995,	28,	3,	0,	0,	2,	'MELASE',	'1995-07-25',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'LUKMAN',	'MUSNAH',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(73,	'RAISHA MAULIDYA',	5201144701156995,	28,	4,	0,	0,	2,	'MENINTING',	'2014-01-07',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'NAPIAH',	'RACHEL YULIANTI',	'',	13,	25,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(74,	'PATANUL HUSNUL',	5201143112667000,	29,	1,	0,	0,	1,	'JAWA TIMUR',	'1965-12-31',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'AHMAD',	'ASIH',	'',	13,	17,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(75,	'RATNAWATY',	5201145512796995,	29,	3,	0,	0,	2,	'KERANDANGAN',	'1978-12-15',	1,	5,	0,	18,	84,	2,	1,	NULL,	NULL,	'',	'',	'JUM',	'REMAH',	'',	13,	17,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(76,	'RABITAH',	5201140312896994,	30,	1,	0,	0,	1,	'KERANDANGAN',	'1988-12-03',	4,	4,	0,	18,	88,	1,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	27,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(77,	'ROMI FAISAL',	5201141506856997,	31,	1,	0,	0,	1,	'MANGSIT',	'1984-06-15',	1,	3,	0,	18,	15,	2,	1,	NULL,	NULL,	'',	'',	'MUNTAHAR',	'MAKNAH',	'',	13,	28,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(78,	'RAUDATUL ILMI',	5201145808816994,	31,	3,	0,	0,	2,	'IRENG DAYE',	'1980-08-18',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'MUDAHIR',	'RUMISAH',	'',	13,	28,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(79,	'ROHANI',	5201144306116994,	31,	4,	0,	0,	2,	'MANGSIT',	'2010-06-03',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'ROMI FAISAL',	'RAUDATUL ILMI',	'',	13,	28,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(80,	'RUKIAH',	5201145909946994,	32,	1,	0,	0,	2,	'SERANG',	'1993-09-19',	1,	4,	0,	18,	88,	3,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	29,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(81,	'RUMALI',	5201144507886994,	32,	9,	0,	0,	2,	'JAKARTA',	'1987-07-05',	1,	4,	0,	18,	88,	1,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	29,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(82,	'RONI',	5201140301836997,	33,	4,	0,	0,	1,	'DENPASAR',	'1982-01-03',	4,	5,	0,	18,	15,	1,	1,	NULL,	NULL,	'',	'',	'IDA BAGUS PUTU WIADNYA',	'RUSMAYANTI',	'',	13,	30,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(83,	'RUSMAYANTI',	5201145003546994,	33,	1,	0,	0,	2,	'DENPASAR',	'1953-03-10',	4,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'IDA BAGUS MAS',	'IDA AYU RAKA',	'',	13,	30,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(84,	'RUSNI',	5201143112707180,	34,	1,	0,	0,	1,	'KEKERAN',	'1969-12-31',	1,	3,	0,	18,	9,	2,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	29,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(85,	'SAPIAH',	5201147011726994,	34,	3,	0,	0,	2,	'KEKERAN',	'1971-11-30',	1,	3,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'-',	'-',	'',	13,	29,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(86,	'SAPINAH',	5201145701966994,	34,	4,	0,	0,	2,	'SENGGIGI',	'1995-01-17',	1,	5,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'RUSNI',	'SAPIAH',	'',	13,	29,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(87,	'SARRA LANGELAND',	5201145111946996,	34,	4,	0,	0,	2,	'SENGGIGI',	'1993-11-11',	1,	5,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'RUSNI',	'SAPIAH',	'',	13,	29,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(88,	'SAHRONI',	5201143112617096,	35,	1,	0,	0,	1,	'MEDAS',	'1960-12-31',	1,	4,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'SADIYAH',	'INAQ SADIAH',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(89,	'SERIMAN',	5201141012846995,	35,	4,	0,	0,	1,	'SENGGIGI',	'1983-12-10',	1,	5,	0,	18,	15,	1,	1,	NULL,	NULL,	'',	'',	'SAHRONI',	'NURLAELA',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(90,	'SUNYOTOH',	5201143112817139,	35,	4,	0,	0,	1,	'MEDAS',	'1980-12-31',	1,	5,	0,	18,	15,	1,	1,	NULL,	NULL,	'',	'',	'SAHRONI',	'NURLAELA',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(91,	'SYARIFUL KALAM',	5201141707776994,	36,	1,	0,	0,	1,	'SENGGIGI',	'1976-07-17',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'H. ABDURAHMAN',	'NAFISAH',	'',	1,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(92,	'SITI AISYAH',	5201146210776994,	36,	3,	0,	0,	2,	'SUKARAJA',	'1976-10-22',	1,	4,	0,	18,	2,	2,	1,	NULL,	NULL,	'',	'',	'AMINALLOH',	'RAEHAN',	'',	2,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(93,	'SITI PAOZIAH',	5201146312161724,	36,	4,	0,	0,	2,	'SENGGIGI',	'2006-12-23',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'SYARIFUL KALAM',	'SITI AISYAH',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(94,	'SUKMA UTAMI',	5201144607996998,	36,	4,	0,	0,	2,	'SENGGIGI',	'1998-07-06',	1,	4,	0,	18,	3,	1,	1,	NULL,	NULL,	'',	'',	'SYARIFUL KALAM',	'SITI AISYAH',	'',	5,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(95,	'WAHID ALIAS H. MAHSUN',	5201141212816996,	37,	1,	0,	0,	1,	'SENGGIGI',	'1980-12-12',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'H. ABDURRAHMAN',	'NAFISAH',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(96,	'WAYAN EKA PRAWATA',	5201142003136994,	37,	4,	0,	0,	1,	'GUNUNG SARI',	'2012-03-20',	1,	1,	0,	18,	1,	1,	1,	NULL,	NULL,	'',	'',	'WAHID ALIAS H. MAHSUN',	'ULFA WIDIAWATI',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(97,	'ULFA WIDIAWATI',	5201145203896994,	37,	3,	0,	0,	2,	'JOHAR PELITA',	'1988-03-12',	1,	5,	0,	18,	88,	2,	1,	NULL,	NULL,	'',	'',	'ZAMHARIN',	'SITIYAH',	'',	13,	31,	1,	'',	'',	1,	NULL,	NULL,	0,	'',	'',	NULL,	'',	NULL,	NULL,	NULL,	NULL,	NULL),
(98,	'ahmad afandi',	1234567890123456,	0,	11,	1,	1,	1,	'gresik',	'1985-04-25',	1,	6,	1,	9,	4,	2,	2,	'1',	1,	'1',	'1',	'1',	'1',	'fd',	4,	4,	1,	'1',	'',	1,	0,	NULL,	1,	'1',	'',	NULL,	'1',	NULL,	1,	'1',	'1',	NULL);

DROP TABLE IF EXISTS `tweb_penduduk_agama`;
CREATE TABLE `tweb_penduduk_agama` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_agama` (`id`, `nama`) VALUES
(1,	'ISLAM'),
(2,	'KRISTEN'),
(3,	'KATHOLIK'),
(4,	'HINDU'),
(5,	'BUDHA'),
(6,	'KHONGHUCU'),
(7,	'Kepercayaan Terhadap Tuhan YME / Lainnya');

DROP TABLE IF EXISTS `tweb_penduduk_hubungan`;
CREATE TABLE `tweb_penduduk_hubungan` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_hubungan` (`id`, `nama`) VALUES
(1,	'KEPALA KELUARGA'),
(2,	'SUAMI'),
(3,	'ISTRI'),
(4,	'ANAK'),
(5,	'MENANTU'),
(6,	'CUCU'),
(7,	'ORANGTUA'),
(8,	'MERTUA'),
(9,	'FAMILI LAIN'),
(10,	'PEMBANTU'),
(11,	'LAINNYA');

DROP TABLE IF EXISTS `tweb_penduduk_kawin`;
CREATE TABLE `tweb_penduduk_kawin` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_kawin` (`id`, `nama`) VALUES
(1,	'BELUM KAWIN'),
(2,	'KAWIN'),
(3,	'CERAI HIDUP'),
(4,	'CERAI MATI');

DROP TABLE IF EXISTS `tweb_penduduk_mandiri`;
CREATE TABLE `tweb_penduduk_mandiri` (
  `nik` decimal(16,0) NOT NULL,
  `pin` char(32) NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `tanggal_buat` datetime DEFAULT NULL,
  PRIMARY KEY (`nik`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tweb_penduduk_mandiri` (`nik`, `pin`, `last_login`, `tanggal_buat`) VALUES
(3275014601977005,	'10a8163a0f614095c8c30ffadee85deb',	'2016-09-14 12:51:53',	'2016-09-14 10:10:47'),
(5201140706966997,	'3645e735f033e8482be0c7993fcba946',	'2016-09-14 12:53:47',	'2016-09-14 06:06:32');

DROP TABLE IF EXISTS `tweb_penduduk_map`;
CREATE TABLE `tweb_penduduk_map` (
  `id` int(11) NOT NULL,
  `lat` varchar(24) NOT NULL,
  `lng` varchar(24) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

INSERT INTO `tweb_penduduk_map` (`id`, `lat`, `lng`) VALUES
(7,	'-7.980601700336039',	'110.22508726486967'),
(3,	'-7.931639102143979',	'110.21375761399077');

DROP TABLE IF EXISTS `tweb_penduduk_pekerjaan`;
CREATE TABLE `tweb_penduduk_pekerjaan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_pekerjaan` (`id`, `nama`) VALUES
(1,	'BELUM/TIDAK BEKERJA'),
(2,	'MENGURUS RUMAH TANGGA'),
(3,	'PELAJAR/MAHASISWA'),
(4,	'PENSIUNAN'),
(5,	'PEGAWAI NEGERI SIPIL (PNS)'),
(6,	'TENTARA NASIONAL INDONESIA (TNI)'),
(7,	'KEPOLISIAN RI (POLRI)'),
(8,	'PERDAGANGAN'),
(9,	'PETANI/PERKEBUNAN'),
(10,	'PETERNAK'),
(11,	'NELAYAN/PERIKANAN'),
(12,	'INDUSTRI'),
(13,	'KONSTRUKSI'),
(14,	'TRANSPORTASI'),
(15,	'KARYAWAN SWASTA'),
(16,	'KARYAWAN BUMN'),
(17,	'KARYAWAN BUMD'),
(18,	'KARYAWAN HONORER'),
(19,	'BURUH HARIAN LEPAS'),
(20,	'BURUH TANI/PERKEBUNAN'),
(21,	'BURUH NELAYAN/PERIKANAN'),
(22,	'BURUH PETERNAKAN'),
(23,	'PEMBANTU RUMAH TANGGA'),
(24,	'TUKANG CUKUR'),
(25,	'TUKANG LISTRIK'),
(26,	'TUKANG BATU'),
(27,	'TUKANG KAYU'),
(28,	'TUKANG SOL SEPATU'),
(29,	'TUKANG LAS/PANDAI BESI'),
(30,	'TUKANG JAHIT'),
(31,	'TUKANG GIGI'),
(32,	'PENATA RIAS'),
(33,	'PENATA BUSANA'),
(34,	'PENATA RAMBUT'),
(35,	'MEKANIK'),
(36,	'SENIMAN'),
(37,	'TABIB'),
(38,	'PARAJI'),
(39,	'PERANCANG BUSANA'),
(40,	'PENTERJEMAH'),
(41,	'IMAM MASJID'),
(42,	'PENDETA'),
(43,	'PASTOR'),
(44,	'WARTAWAN'),
(45,	'USTADZ/MUBALIGH'),
(46,	'JURU MASAK'),
(47,	'PROMOTOR ACARA'),
(48,	'ANGGOTA DPR-RI'),
(49,	'ANGGOTA DPD'),
(50,	'ANGGOTA BPK'),
(51,	'PRESIDEN'),
(52,	'WAKIL PRESIDEN'),
(53,	'ANGGOTA MAHKAMAH KONSTITUSI'),
(54,	'ANGGOTA KABINET KEMENTERIAN'),
(55,	'DUTA BESAR'),
(56,	'GUBERNUR'),
(57,	'WAKIL GUBERNUR'),
(58,	'BUPATI'),
(59,	'WAKIL BUPATI'),
(60,	'WALIKOTA'),
(61,	'WAKIL WALIKOTA'),
(62,	'ANGGOTA DPRD PROVINSI'),
(63,	'ANGGOTA DPRD KABUPATEN/KOTA'),
(64,	'DOSEN'),
(65,	'GURU'),
(66,	'PILOT'),
(67,	'PENGACARA'),
(68,	'NOTARIS'),
(69,	'ARSITEK'),
(70,	'AKUNTAN'),
(71,	'KONSULTAN'),
(72,	'DOKTER'),
(73,	'BIDAN'),
(74,	'PERAWAT'),
(75,	'APOTEKER'),
(76,	'PSIKIATER/PSIKOLOG'),
(77,	'PENYIAR TELEVISI'),
(78,	'PENYIAR RADIO'),
(79,	'PELAUT'),
(80,	'PENELITI'),
(81,	'SOPIR'),
(82,	'PIALANG'),
(83,	'PARANORMAL'),
(84,	'PEDAGANG'),
(85,	'PERANGKAT DESA'),
(86,	'KEPALA DESA'),
(87,	'BIARAWATI'),
(88,	'WIRASWASTA'),
(89,	'LAINNYA');

DROP TABLE IF EXISTS `tweb_penduduk_pendidikan`;
CREATE TABLE `tweb_penduduk_pendidikan` (
  `id` tinyint(3) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_pendidikan` (`id`, `nama`) VALUES
(1,	'BELUM MASUK TK/KELOMPOK BERMAIN'),
(2,	'SEDANG TK/KELOMPOK BERMAIN'),
(3,	'TIDAK PERNAH SEKOLAH'),
(4,	'SEDANG SD/SEDERAJAT'),
(5,	'TIDAK TAMAT SD/SEDERAJAT'),
(6,	'SEDANG SLTP/SEDERAJAT'),
(7,	'SEDANG SLTA/SEDERAJAT'),
(8,	'SEDANG  D-1/SEDERAJAT'),
(9,	'SEDANG D-2/SEDERAJAT'),
(10,	'SEDANG D-3/SEDERAJAT'),
(11,	'SEDANG  S-1/SEDERAJAT'),
(12,	'SEDANG S-2/SEDERAJAT'),
(13,	'SEDANG S-3/SEDERAJAT'),
(14,	'SEDANG SLB A/SEDERAJAT'),
(15,	'SEDANG SLB B/SEDERAJAT'),
(16,	'SEDANG SLB C/SEDERAJAT'),
(17,	'TIDAK DAPAT MEMBACA DAN MENULIS HURUF LATIN/ARAB'),
(18,	'TIDAK SEDANG SEKOLAH');

DROP TABLE IF EXISTS `tweb_penduduk_pendidikan_kk`;
CREATE TABLE `tweb_penduduk_pendidikan_kk` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_pendidikan_kk` (`id`, `nama`) VALUES
(1,	'TIDAK / BELUM SEKOLAH'),
(2,	'BELUM TAMAT SD/SEDERAJAT'),
(3,	'TAMAT SD / SEDERAJAT'),
(4,	'SLTP/SEDERAJAT'),
(5,	'SLTA / SEDERAJAT'),
(6,	'DIPLOMA I / II'),
(7,	'AKADEMI/ DIPLOMA III/S. MUDA'),
(8,	'DIPLOMA IV/ STRATA I'),
(9,	'STRATA II'),
(10,	'STRATA III');

DROP TABLE IF EXISTS `tweb_penduduk_sex`;
CREATE TABLE `tweb_penduduk_sex` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

INSERT INTO `tweb_penduduk_sex` (`id`, `nama`) VALUES
(1,	'LAKI-LAKI'),
(2,	'PEREMPUAN');

DROP TABLE IF EXISTS `tweb_penduduk_status`;
CREATE TABLE `tweb_penduduk_status` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_penduduk_status` (`id`, `nama`) VALUES
(1,	'TETAP'),
(2,	'TIDAK AKTIF'),
(3,	'PENDATANG');

DROP TABLE IF EXISTS `tweb_penduduk_umur`;
CREATE TABLE `tweb_penduduk_umur` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(25) DEFAULT NULL,
  `dari` int(11) DEFAULT NULL,
  `sampai` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_penduduk_umur` (`id`, `nama`, `dari`, `sampai`, `status`) VALUES
(1,	'BALITA',	0,	5,	NULL),
(2,	'ANAK-ANAK',	6,	17,	NULL),
(3,	'DEWASA',	18,	30,	NULL),
(4,	'TUA',	31,	120,	NULL),
(6,	'Bayi ( < 1 ) Tahun',	0,	1,	1),
(9,	'Balita ( 2 > 4 ) Tahun',	2,	4,	1),
(12,	'Anak-anak ( 5 > 9 ) Tahun',	5,	9,	1),
(13,	'Anak-anak ( 10 > 14 ) Tah',	10,	14,	1),
(14,	'Remaja ( 15 > 19 ) Tahun',	15,	19,	1),
(15,	'Remaja ( 20 > 24 ) Tahun',	20,	24,	1),
(16,	'Dewasa ( 25 > 29 ) Tahun',	25,	29,	1),
(17,	'Dewasa ( 30 > 34 ) Tahun',	30,	34,	1),
(18,	'Dewasa ( 35 > 39 ) Tahun ',	35,	39,	1),
(19,	'Dewasa ( 40 > 44 ) Tahun',	40,	44,	1),
(20,	'Tua ( 45 > 49 ) Tahun',	45,	49,	1),
(21,	'Tua ( 50 > 54 ) Tahun',	50,	54,	1),
(22,	'Tua ( 55 > 59 ) Tahun',	55,	59,	1),
(23,	'Tua ( 60 > 64 ) Tahun',	60,	64,	1),
(24,	'Tua ( 65 > 69 ) Tahun',	65,	69,	1),
(25,	'Tua ( 70 > 74 ) Tahun',	70,	74,	1),
(26,	'Lansia ( > 75 ) Tahun',	75,	130,	1);

DROP TABLE IF EXISTS `tweb_penduduk_warganegara`;
CREATE TABLE `tweb_penduduk_warganegara` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_penduduk_warganegara` (`id`, `nama`) VALUES
(1,	'WNI'),
(2,	'WNA'),
(3,	'DUA KEWARGANEGARAAN');

DROP TABLE IF EXISTS `tweb_rtm`;
CREATE TABLE `tweb_rtm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik_kepala` int(11) NOT NULL,
  `no_kk` varchar(20) NOT NULL,
  `tgl_daftar` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `kelas_sosial` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_rtm` (`id`, `nik_kepala`, `no_kk`, `tgl_daftar`, `kelas_sosial`) VALUES
(1,	4,	'01140500001',	'2017-04-22 06:45:34',	NULL);

DROP TABLE IF EXISTS `tweb_rtm_hubungan`;
CREATE TABLE `tweb_rtm_hubungan` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nama` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_rtm_hubungan` (`id`, `nama`) VALUES
(1,	'Kepala Rumah Tangga'),
(2,	'Anggota');

DROP TABLE IF EXISTS `tweb_sakit_menahun`;
CREATE TABLE `tweb_sakit_menahun` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_sakit_menahun` (`id`, `nama`) VALUES
(1,	'JANTUNG'),
(2,	'LEVER'),
(3,	'PARU-PARU'),
(4,	'KANKER'),
(5,	'STROKE'),
(6,	'DIABETES MELITUS'),
(7,	'GINJAL'),
(8,	'MALARIA'),
(9,	'LEPRA/KUSTA'),
(10,	'HIV/AIDS'),
(11,	'GILA/STRESS'),
(12,	'TBC'),
(13,	'ASTHMA'),
(14,	'TIDAK ADA/TIDAK SAKIT');

DROP TABLE IF EXISTS `tweb_status_dasar`;
CREATE TABLE `tweb_status_dasar` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_status_dasar` (`id`, `nama`) VALUES
(1,	'HIDUP'),
(2,	'MATI'),
(3,	'PINDAH'),
(4,	'HILANG');

DROP TABLE IF EXISTS `tweb_surat_atribut`;
CREATE TABLE `tweb_surat_atribut` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_surat` int(11) NOT NULL,
  `id_tipe` tinyint(4) NOT NULL,
  `nama` varchar(40) NOT NULL,
  `long` tinyint(4) NOT NULL,
  `kode` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `tweb_surat_format`;
CREATE TABLE `tweb_surat_format` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `url_surat` varchar(100) NOT NULL,
  `kode_surat` varchar(10) NOT NULL,
  `lampiran` varchar(100) DEFAULT NULL,
  `kunci` tinyint(1) NOT NULL DEFAULT '0',
  `favorit` tinyint(1) NOT NULL DEFAULT '0',
  `jenis` tinyint(2) NOT NULL DEFAULT '2',
  PRIMARY KEY (`id`),
  UNIQUE KEY `url_surat` (`url_surat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `tweb_surat_format` (`id`, `nama`, `url_surat`, `kode_surat`, `lampiran`, `kunci`, `favorit`, `jenis`) VALUES
(1,	'Keterangan Pengantar',	'surat_ket_pengantar',	'S-01',	NULL,	0,	0,	1),
(2,	'Keterangan Penduduk',	'surat_ket_penduduk',	'S-02',	NULL,	0,	0,	1),
(3,	'Biodata Penduduk',	'surat_bio_penduduk',	'S-03',	'f-1.01.php',	0,	0,	1),
(5,	'Keterangan Pindah Penduduk',	'surat_ket_pindah_penduduk',	'S-04',	'f-1.08.php,f-1.25.php',	0,	0,	1),
(6,	'Keterangan Jual Beli',	'surat_ket_jual_beli',	'S-05',	NULL,	0,	0,	1),
(7,	'Pengantar Pindah Antar Kabupaten/ Provinsi',	'surat_pindah_antar_kab_prov',	'S-06',	NULL,	0,	0,	1),
(8,	'Pengantar Surat Keterangan Catatan Kepolisian',	'surat_ket_catatan_kriminal',	'S-07',	NULL,	0,	0,	1),
(9,	'Keterangan KTP dalam Proses',	'surat_ket_ktp_dalam_proses',	'S-08',	NULL,	0,	0,	1),
(10,	'Keterangan Beda Identitas',	'surat_ket_beda_nama',	'S-09',	NULL,	0,	0,	1),
(11,	'Keterangan Bepergian / Jalan',	'surat_jalan',	'S-10',	NULL,	0,	0,	1),
(12,	'Keterangan Kurang Mampu',	'surat_ket_kurang_mampu',	'S-11',	NULL,	0,	0,	1),
(13,	'Pengantar Izin Keramaian',	'surat_izin_keramaian',	'S-12',	NULL,	0,	0,	1),
(14,	'Pengantar Laporan Kehilangan',	'surat_ket_kehilangan',	'S-13',	NULL,	0,	0,	1),
(15,	'Keterangan Usaha',	'surat_ket_usaha',	'S-14',	NULL,	0,	0,	1),
(16,	'Keterangan JAMKESOS',	'surat_ket_jamkesos',	'S-15',	NULL,	0,	0,	1),
(17,	'Keterangan Domisili Usaha',	'surat_ket_domisili_usaha',	'S-16',	NULL,	0,	0,	1),
(18,	'Keterangan Kelahiran',	'surat_ket_kelahiran',	'S-17',	NULL,	0,	0,	1),
(20,	'Permohonan Akta Lahir',	'surat_permohonan_akta',	'S-18',	NULL,	0,	0,	1),
(21,	'Pernyataan Belum Memiliki Akta Lahir',	'surat_pernyataan_akta',	'S-19',	NULL,	0,	0,	1),
(22,	'Permohonan Duplikat Kelahiran',	'surat_permohonan_duplikat_kelahiran',	'S-20',	NULL,	0,	0,	1),
(24,	'Keterangan Kematian',	'surat_ket_kematian',	'S-21',	NULL,	0,	0,	1),
(25,	'Keterangan Lahir Mati',	'surat_ket_lahir_mati',	'S-22',	NULL,	0,	0,	1),
(26,	'Keterangan Untuk Nikah (N-1)',	'surat_ket_nikah',	'S-23',	NULL,	0,	0,	1),
(27,	'Keterangan Asal Usul (N-2)',	'surat_ket_asalusul',	'S-24',	NULL,	0,	0,	1),
(28,	'Persetujuan Mempelai (N-3)',	'surat_persetujuan_mempelai',	'S-25',	NULL,	0,	0,	1),
(29,	'Keterangan Tentang Orang Tua (N-4)',	'surat_ket_orangtua',	'S-26',	NULL,	0,	0,	1),
(30,	'Keterangan Izin Orang Tua(N-5)',	'surat_izin_orangtua',	'S-27',	NULL,	0,	0,	1),
(31,	'Keterangan Kematian Suami/Istri(N-6)',	'surat_ket_kematian_suami_istri',	'S-28',	NULL,	0,	0,	1),
(32,	'Pemberitahuan Kehendak Nikah (N-7)',	'surat_kehendak_nikah',	'S-29',	NULL,	0,	0,	1),
(33,	'Keterangan Pergi Kawin',	'surat_ket_pergi_kawin',	'S-30',	NULL,	0,	0,	1),
(34,	'Keterangan Wali',	'surat_ket_wali',	'S-31',	NULL,	0,	0,	1),
(35,	'Keterangan Wali Hakim',	'surat_ket_wali_hakim',	'S-32',	NULL,	0,	0,	1),
(36,	'Permohonan Duplikat Surat Nikah',	'surat_permohonan_duplikat_surat_nikah',	'S-33',	NULL,	0,	0,	1),
(37,	'Permohonan Cerai',	'surat_permohonan_cerai',	'S-34',	NULL,	0,	0,	1),
(38,	'Keterangan Pengantar Rujuk/Cerai',	'surat_ket_rujuk_cerai',	'S-35',	NULL,	0,	0,	1),
(44,	'Ubah Sesuaikan',	'surat_ubah_sesuaikan',	'S-36',	NULL,	0,	0,	2),
(45,	'Permohonan Kartu Keluarga',	'surat_permohonan_kartu_keluarga',	'S-36',	'f-1.15.php',	0,	0,	1);

DROP TABLE IF EXISTS `tweb_wil_clusterdesa`;
CREATE TABLE `tweb_wil_clusterdesa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rt` varchar(10) NOT NULL DEFAULT '0',
  `rw` varchar(10) NOT NULL DEFAULT '0',
  `dusun` varchar(50) NOT NULL DEFAULT '0',
  `id_kepala` int(11) NOT NULL,
  `lat` varchar(20) DEFAULT NULL,
  `lng` varchar(20) DEFAULT NULL,
  `zoom` int(5) DEFAULT NULL,
  `path` text,
  `map_tipe` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rt` (`rt`,`rw`,`dusun`),
  KEY `id_kepala` (`id_kepala`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `tweb_wil_clusterdesa` (`id`, `rt`, `rw`, `dusun`, `id_kepala`, `lat`, `lng`, `zoom`, `path`, `map_tipe`) VALUES
(1,	'0',	'0',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(2,	'0',	'-',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(3,	'-',	'-',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(4,	'004',	'-',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(5,	'0',	'0',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(6,	'0',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(7,	'-',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(8,	'001',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(9,	'0',	'0',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(10,	'0',	'-',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(11,	'-',	'-',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(12,	'002',	'-',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(13,	'0',	'0',	'LOCO',	0,	'',	'',	0,	'',	''),
(14,	'0',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(15,	'-',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(16,	'003',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(17,	'001',	'-',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(18,	'005',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(19,	'005',	'-',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(20,	'005',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(21,	'003',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(22,	'002',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(23,	'004',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(24,	'004',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(25,	'001',	'-',	'LOCO',	0,	'',	'',	0,	'',	''),
(26,	'002',	'-',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(27,	'004',	'-',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(28,	'003',	'-',	'MANGSIT',	0,	'',	'',	0,	'',	''),
(29,	'006',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(30,	'006',	'-',	'KERANDANGAN',	0,	'',	'',	0,	'',	''),
(31,	'002',	'-',	'SENGGIGI',	0,	'',	'',	0,	'',	''),
(32,	'0',	'1',	'MANGSIT',	4,	NULL,	NULL,	NULL,	NULL,	NULL),
(33,	'-',	'1',	'MANGSIT',	4,	NULL,	NULL,	NULL,	NULL,	NULL);

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `id_grup` int(5) NOT NULL,
  `email` varchar(100) NOT NULL,
  `last_login` datetime NOT NULL,
  `active` tinyint(1) unsigned DEFAULT '0',
  `nama` varchar(50) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `foto` varchar(100) NOT NULL,
  `session` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user` (`id`, `username`, `password`, `id_grup`, `email`, `last_login`, `active`, `nama`, `company`, `phone`, `foto`, `session`) VALUES
(1,	'admin',	'21232f297a57a5a743894a0e4a801fc3',	1,	'admin@combine.or.id',	'2017-05-01 13:04:01',	1,	'Administrator',	'ADMIN',	'321',	'favicon.png',	'a8d4080245664ed2049c1b2ded7cac30'),
(56,	'redaksi',	'd8578edf8458ce06fbc5bb76a58c5ca4',	3,	'',	'2014-10-24 20:15:38',	1,	'Redaksi',	NULL,	'',	'',	'39b3cc1ca3f8b095a171b19b1f307358'),
(57,	'operator',	'd8578edf8458ce06fbc5bb76a58c5ca4',	2,	'',	'2014-10-24 20:17:42',	1,	'Operator Desa',	NULL,	'',	'',	'9304194147916440da8be6d8f26f62f0');

DROP TABLE IF EXISTS `user_grup`;
CREATE TABLE `user_grup` (
  `id` tinyint(4) NOT NULL,
  `nama` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `user_grup` (`id`, `nama`) VALUES
(1,	'Administrator'),
(2,	'Operator'),
(3,	'Redaksi'),
(4,	'Kontributor');

DROP TABLE IF EXISTS `widget`;
CREATE TABLE `widget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `isi` text,
  `enabled` int(2) DEFAULT NULL,
  `judul` varchar(100) DEFAULT NULL,
  `jenis_widget` tinyint(2) NOT NULL DEFAULT '3',
  `urut` int(5) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `widget` (`id`, `isi`, `enabled`, `judul`, `jenis_widget`, `urut`) VALUES
(1,	'<p><iframe src=\"https://www.google.co.id/maps?f=q&source=s_q&hl=en&geocode=&q=Logandu,+Karanggayam&aq=0&oq=logan&sll=-2.550221,118.015568&sspn=52.267573,80.332031&t=h&ie=UTF8&hq=&hnear=Logandu,+Karanggayam,+Kebumen,+Central+Java&ll=-7.55854,109.634173&spn=0.052497,0.078449&z=14&output=embed\" frameborder=\"0\" marginwidth=\"0\" marginheight=\"0\" scrolling=\"no\" width=\"100%\"></iframe></p> ',	1,	'Peta Desa',	3,	NULL),
(2,	'layanan_mandiri.php',	1,	'Layanan Mandiri',	1,	1),
(3,	'agenda.php',	1,	'Agenda',	1,	2),
(4,	'galeri.php',	1,	'Galeri',	1,	3),
(5,	'statistik.php',	1,	'Statistik',	1,	4),
(6,	'komentar.php',	1,	'Komentar',	1,	5),
(7,	'media_sosial.php',	1,	'Media Sosial',	1,	6),
(8,	'peta_lokasi_kantor.php',	1,	'Peta Lokasi Kantor',	1,	7),
(9,	'statistik_pengunjung.php',	1,	'Statistik Pengunjung',	1,	8),
(10,	'arsip_artikel.php',	1,	'Arsip Artikel',	1,	9),
(11,	'aparatur_desa.php',	1,	'Aparatur Desa',	1,	1);


-- 2017-07-10 03:05:43

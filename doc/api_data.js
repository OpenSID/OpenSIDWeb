define({ "api": [
  {
    "type": "get",
    "url": "/artikel/headline",
    "title": "Mengambil artikel yang dijadikan sebagai headline",
    "name": "GetHeadline",
    "group": "Artikel",
    "success": {
      "fields": {
        "Success 200": [
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "firstname",
            "description": "<p>Firstname of the User.</p>"
          },
          {
            "group": "Success 200",
            "type": "String",
            "optional": false,
            "field": "lastname",
            "description": "<p>Lastname of the User.</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": [\n     {\n       \"id\": \"99\",\n     \"gambar\": \"1472228892Raja Lombok 1902.jpg\",\n     \"isi\": \"<p style=\\\"text-align: justify;\\\" align=\\\"center\\\">Sejarah telah mencatat bahwa Pulau Lombok pernah menjadi wilayah kekuasaan Kerajaan Karang Asem Bali yang berkedudukan di Cakranegara dengan seorang raja bernama Anak Agung Gde Jelantik. Berakhirnya <strong>kekuasaan</strong>\n     \"enabled\": \"1\",\n     \"tgl_upload\": \"2016-08-26 15:38:09\",\n     \"id_kategori\": \"999\",\n     \"id_user\": \"1\",\n     \"judul\": \"Sejarah Desa\",\n     \"headline\": \"1\",\n     \"gambar1\": \"1472229325490125_20121123041539.jpg\",\n     \"gambar2\": \"1472197089\",\n     \"gambar3\": \"1472197089\",\n     \"dokumen\": \"\",\n     \"link_dokumen\": \"\",\n     \"urut\": \"0\",\n     \"author\": {\n       \"id\": \"1\",\n       \"id_grup\": \"1\",\n       \"email\": \"admin@combine.or.id\",\n       \"last_login\": \"2017-05-01 13:04:01\",\n       \"active\": \"1\",\n       \"nama\": \"Administrator\",\n       \"company\": \"ADMIN\",\n       \"phone\": \"321\",\n       \"foto\": \"favicon.png\"\n     }\n   },\n    {\n      headline yang lain\n   }\n ]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "headline",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Artikel.php",
    "groupTitle": "Artikel"
  },
  {
    "type": "get",
    "url": "/komentar/list/{limit}/{10}",
    "title": "Mengambil daftar komentar",
    "name": "GetKomentar",
    "group": "Artikel",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n\"content\": [\n{\n   \"id\": \"11\",\n   \"id_artikel\": \"775\",\n   \"owner\": \"DENATUL SUARTINI\",\n   \"email\": \"3275014601977005\",\n   \"komentar\": \"Laporan ini tidak relevan. Hanya berisi komentar saja.\",\n   \"tgl_upload\": \"2016-09-14 11:05:02\",\n   \"enabled\": \"2\"\n  },\n{\n   \"id\": \"10\",\n   \"id_artikel\": \"775\",\n   \"owner\": \"DENATUL SUARTINI\",\n   \"email\": \"3275014601977005\",\n   \"komentar\": \"Saya ke kantor desa kemarin jam 12:30 siang, tetapi tidak ada orang. Anak kami akan pergi ke Yogyakarta untuk kuliah selama 4 tahun. Apakah perlu kami laporkan?\",\n   \"tgl_upload\": \"2016-09-14 10:49:34\",\n   \"enabled\": \"2\"\n  },\n{\n   \"id\": \"9\",\n   \"id_artikel\": \"775\",\n   \"owner\": \"AHMAD ALLIF RIZKI\",\n   \"email\": \"5201140706966997\",\n   \"komentar\": \"Harap alamat keluarga kami diperbaik menjadi RT 002 Dusun Mangsit. \\n\\nTerima kasih.\",\n   \"tgl_upload\": \"2016-09-14 07:44:59\",\n   \"enabled\": \"1\"\n  },\n{\n   \"id\": \"8\",\n   \"id_artikel\": \"95\",\n   \"owner\": \"Penduduk Biasa\",\n   \"email\": \"penduduk@desaku.desa.id\",\n   \"komentar\": \"Selamat atas keberhasilan Senggigi merayakan Hari Kemerdeakaan 2016!\",\n   \"tgl_upload\": \"2016-09-14 06:09:16\",\n   \"enabled\": \"1\"\n  }\n]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "komentar",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : null\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Komentar.php",
    "groupTitle": "Artikel"
  },
  {
    "type": "get",
    "url": "/komentar/artikel/id_artikel/{id_artikel}/{limit}/{10}",
    "title": "Mengambil daftar komentar berdasarkan artikel tertentu",
    "name": "GetKomentarArtikel",
    "group": "Artikel",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n\"content\": [\n  {\n   \"id\": \"8\",\n   \"id_artikel\": \"95\",\n   \"owner\": \"Penduduk Biasa\",\n   \"email\": \"penduduk@desaku.desa.id\",\n   \"komentar\": \"Selamat atas keberhasilan Senggigi merayakan Hari Kemerdeakaan 2016!\",\n   \"tgl_upload\": \"2016-09-14 06:09:16\",\n   \"enabled\": \"1\"\n  }\n]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "komentar",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : null\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Komentar.php",
    "groupTitle": "Artikel"
  },
  {
    "type": "get",
    "url": "/artikel/detail/{id}/96",
    "title": "Mengambil detail artikel berdasarkan id artikel",
    "name": "GetList",
    "group": "Artikel",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": {\n  \"id\": \"96\",\n  \"gambar\": \"1472782915artikel-3-1.jpeg\",\n  \"isi\": \"<p>Dalam rapat pembahasan komitmen perekrutan karyawan hotel pada tanggal </p>\",\n  \"enabled\": \"1\",\n  \"tgl_upload\": \"2016-08-24 13:55:10\",\n  \"id_kategori\": \"4\",\n  \"id_user\": \"1\",\n  \"judul\": \"Rapat membangun Komitmen antara Karang Taruna Desa Senggigi dengan Taruna Hotel\",\n  \"headline\": \"3\",\n  \"gambar1\": \"1472018109IMG-20160824-WA0000.jpg\",\n  \"gambar2\": \"1472018109\",\n  \"gambar3\": \"1472018109\",\n  \"dokumen\": \"\",\n  \"link_dokumen\": \"\",\n  \"urut\": \"0\",\n  \"author\": {\n   \"id\": \"1\",\n   \"id_grup\": \"1\",\n   \"email\": \"admin@combine.or.id\",\n   \"last_login\": \"2017-05-01 13:04:01\",\n   \"active\": \"1\",\n   \"nama\": \"Administrator\",\n   \"company\": \"ADMIN\",\n   \"phone\": \"321\",\n   \"foto\": \"favicon.png\"\n  },\n  \"kategori\": {\n   \"id\": \"1\",\n   \"kategori\": \"Berita Desa\",\n   \"tipe\": \"1\",\n   \"urut\": \"1\",\n   \"enabled\": \"1\",\n   \"parrent\": \"0\"\n  }\n   }\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "detail",
            "description": "<p>artikel tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : null\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Artikel.php",
    "groupTitle": "Artikel"
  },
  {
    "type": "get",
    "url": "/artikel/list/{page}/1/{limit}/10",
    "title": "Mengambil semua artikel",
    "name": "GetList",
    "group": "Artikel",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": [\n {\n  \"id\": \"96\",\n  \"gambar\": \"1472782915artikel-3-1.jpeg\",\n  \"isi\": \"<p>Dalam rapat pembahasan komitmen perekrutan karyawan hotel pada tanggal </p>\",\n  \"enabled\": \"1\",\n  \"tgl_upload\": \"2016-08-24 13:55:10\",\n  \"id_kategori\": \"4\",\n  \"id_user\": \"1\",\n  \"judul\": \"Rapat membangun Komitmen antara Karang Taruna Desa Senggigi dengan Taruna Hotel\",\n  \"headline\": \"3\",\n  \"gambar1\": \"1472018109IMG-20160824-WA0000.jpg\",\n  \"gambar2\": \"1472018109\",\n  \"gambar3\": \"1472018109\",\n  \"dokumen\": \"\",\n  \"link_dokumen\": \"\",\n  \"urut\": \"0\"\n   },\n   {\n  \"id\": \"95\",\n  \"gambar\": \"1472782634galeri-1-1.jpg\",\n  \"isi\": \"<p>Desa Senggigi ikut memeriahkan perayaan 17 Agustus 2016 sebagai hari jadi Indonesia yang ke 71 melalui kegiatan </p>\",\n  \"enabled\": \"1\",\n  \"tgl_upload\": \"2016-08-24 13:05:21\",\n  \"id_kategori\": \"1\",\n  \"id_user\": \"1\",\n  \"judul\": \"Perayaan Hari Kemerdekaan 2016\",\n  \"headline\": \"3\",\n  \"gambar1\": \"1472782634galeri-1-2.jpeg\",\n  \"gambar2\": \"1472015120\",\n  \"gambar3\": \"1472015120\",\n  \"dokumen\": \"\",\n  \"link_dokumen\": \"\",\n  \"urut\": \"0\"\n    }\n   ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "artikel",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Artikel.php",
    "groupTitle": "Artikel"
  },
  {
    "type": "get",
    "url": "/artikel/teks_berjalan",
    "title": "Mengambil artikel yang kategorinya adalah teks_berjalan",
    "name": "GetTeksBerjalan",
    "group": "Artikel",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": [\n {\n   \"id\": \"22\",\n   \"kategori\": \"teks_berjalan\",\n   \"tipe\": \"1\",\n   \"urut\": \"0\",\n   \"enabled\": \"1\",\n   \"parrent\": \"0\",\n   \"artikel\": [\n  {\n    \"id\": \"100\",\n    \"gambar\": \"1473071921\",\n    \"isi\": \"<p>Ini contoh teks berjalan. Isi dengan tulisan yang menampilkan suatu ciri atau kegiatan penting di desa anda.</p>\",\n    \"enabled\": \"1\",\n    \"tgl_upload\": \"2016-09-05 10:38:41\",\n    \"id_kategori\": \"22\",\n    \"id_user\": \"1\",\n    \"judul\": \"Contoh teks berjalan\",\n    \"headline\": \"0\",\n    \"gambar1\": \"1473071921\",\n    \"gambar2\": \"1473071921\",\n    \"gambar3\": \"1473071921\",\n    \"dokumen\": \"\",\n    \"link_dokumen\": \"\",\n    \"urut\": \"0\"\n  }\n   ]\n }\n]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "teks",
            "description": "<p>berjalan tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Artikel.php",
    "groupTitle": "Artikel"
  },
  {
    "type": "get",
    "url": "/auth/tokenMandiri",
    "title": "Mendapatkan token yang akan digunakan untuk mengakses data yang bersifat rahasia",
    "name": "GetToken",
    "group": "Authentication",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "nik",
            "description": "<p>nik warga unique ID.</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "pin",
            "description": "<p>pin warga, diperoleh setelah melakukan registrasi pada layanan mandiri.</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": \t\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1MDMyNzk2MDMsImlzcyI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDgwXC9lZHNhLW9wZW5zaWR3ZWJcLyIsIm5iZiI6MTUwMzI3OTYwNiwiZXhwIjoxNTAzMjgzMjAzLCJkYXRhIjp7Im5payI6IjMyNzUwMTQ2MDE5NzcwMDUiLCJpc0xvZ2luIjoxfX0.vv-HTaHDVDHpVkgFccfl4-wqMzL080SlZIgHC-5qbmw\"\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "notFound",
            "description": "<p>nik tidak ditemukan atau pin salah</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Auth.php",
    "groupTitle": "Authentication"
  },
  {
    "type": "post",
    "url": "/auth/tokenSiteman",
    "title": "Mendapatkan token yang akan digunakan untuk mengakses data yang bersifat rahasia sebagai admin opensid",
    "name": "PostToken",
    "group": "Authentication",
    "parameter": {
      "fields": {
        "Parameter": [
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "username",
            "description": "<p>username .</p>"
          },
          {
            "group": "Parameter",
            "type": "String",
            "optional": false,
            "field": "password",
            "description": "<p>password .</p>"
          }
        ]
      }
    },
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": \t\"eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpYXQiOjE1MDMyODIwMDcsImlzcyI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDgwXC9lZHNhLW9wZW5zaWR3ZWJcLyIsIm5iZiI6MTUwMzI4MjAxMCwiZXhwIjoxNTAzMjg1NjA3LCJkYXRhIjp7InNpdGVtYW4iOjEsInNlc2kiOiJhOGQ0MDgwMjQ1NjY0ZWQyMDQ5YzFiMmRlZDdjYWMzMCIsInVzZXIiOiIxIiwiZ3J1cCI6IjEiLCJpc0xvZ2luIjoxfX0.fPryREYUrtlZR8IoeywkynJZXqNke8_S1JM4CChlQKk\"\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "notFound",
            "description": "<p>username tidak ditemukan atau password salah</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Auth.php",
    "groupTitle": "Authentication"
  },
  {
    "type": "get",
    "url": "/config/list",
    "title": "Mengambil konfigurasi untuk opensid",
    "name": "GetList",
    "group": "Config",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "    HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": [\n     {\n     \"id\": \"1\",\n     \"nama_desa\": \"Senggigi \",\n     \"kode_desa\": \"05\",\n     \"nama_kepala_desa\": \"Muhammad Ilham \",\n     \"nip_kepala_desa\": \"--\",\n     \"kode_pos\": \"83355\",\n     \"nama_kecamatan\": \"Batulayar \",\n     \"kode_kecamatan\": \"14\",\n     \"nama_kepala_camat\": \"Bambang Budi Sanyoto, S. H\",\n     \"nip_kepala_camat\": \"-\",\n     \"nama_kabupaten\": \"Lombok Barat \",\n     \"kode_kabupaten\": \"01\",\n     \"nama_propinsi\": \"NTB \",\n     \"kode_propinsi\": \"52\",\n     \"logo\": \"LogoSenggigi100x100.png\",\n     \"lat\": \"-8.488005310891758\",\n     \"lng\": \"116.0406072534065\",\n     \"zoom\": \"19\",\n     \"map_tipe\": \"hybrid\",\n     \"path\": \"(-7.8312189550359586, 110.2565517439507);(-7.8676102927000695, 110.25380516191944);(-7.843803235881495, 110.29843711992726);(-7.831899196157655, 110.36504173418507);(-7.8169336350355465, 110.32933616777882);(-7.8169336350355465, 110.29775047441944);\",\n     \"alamat_kantor\": \"Jl. Raya Senggigi Km 10 Kerandangan \",\n     \"g_analytic\": \"gsgsdgsdgsg\"\n      }\n   ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "config",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Config.php",
    "groupTitle": "Config"
  },
  {
    "type": "get",
    "url": "/kategori/list",
    "title": "Mengambil kategori untuk dijadikan sebagai menu di sidebar kiri, konversi dari list_menu_kiri",
    "name": "GetKategori",
    "group": "Kategori",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n \"content\": [\n{\n  \"id\": \"1\",\n  \"kategori\": \"Berita Desa\",\n  \"tipe\": \"1\",\n  \"urut\": \"1\",\n  \"enabled\": \"1\",\n  \"parrent\": \"0\",\n  \"menu_kiri\": [\n    {\n      \"id\": \"20\",\n      \"kategori\": \"Berita Lokal\",\n      \"tipe\": \"1\",\n      \"urut\": \"0\",\n      \"enabled\": \"2\",\n      \"parrent\": \"1\"\n    },\n    {\n      \"id\": \"21\",\n      \"kategori\": \"Berita Kriminal\",\n      \"tipe\": \"1\",\n      \"urut\": \"0\",\n      \"enabled\": \"2\",\n      \"parrent\": \"1\"\n    }\n  ]\n },\n {\n  \"id\": \"4\",\n  \"kategori\": \"Agenda Desa\",\n  \"tipe\": \"2\",\n  \"urut\": \"2\",\n  \"enabled\": \"1\",\n  \"parrent\": \"0\",\n  \"menu_kiri\": []\n  },\n  {\n  \"id\": \"5\",\n  \"kategori\": \"Peraturan Desa\",\n  \"tipe\": \"2\",\n  \"urut\": \"5\",\n  \"enabled\": \"1\",\n  \"parrent\": \"0\",\n  \"menu_kiri\": [\n    {\n      \"id\": \"17\",\n      \"kategori\": \"Peraturan Kebersihan Desa\",\n      \"tipe\": \"1\",\n      \"urut\": \"0\",\n      \"enabled\": \"2\",\n      \"parrent\": \"5\"\n    }\n  ]\n }\n ]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "sidebar",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Kategori.php",
    "groupTitle": "Kategori"
  },
  {
    "type": "get",
    "url": "/kategori/list",
    "title": "Mengambil semua kategori",
    "name": "GetKategori",
    "group": "Kategori",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n  \"status\": 1,\n  \"content\": [\n {\n   \"id\": \"1\",\n   \"kategori\": \"Berita Desa\",\n   \"tipe\": \"1\",\n   \"urut\": \"1\",\n   \"enabled\": \"1\",\n   \"parrent\": \"0\"\n },\n {\n   \"id\": \"2\",\n   \"kategori\": \"Produk Desa\",\n   \"tipe\": \"1\",\n   \"urut\": \"3\",\n   \"enabled\": \"2\",\n   \"parrent\": \"0\"\n },\n {\n   \"id\": \"22\",\n   \"kategori\": \"teks_berjalan\",\n   \"tipe\": \"1\",\n   \"urut\": \"0\",\n   \"enabled\": \"1\",\n   \"parrent\": \"0\"\n }\n  ]\n}",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "kategori",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : []\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Kategori.php",
    "groupTitle": "Kategori"
  },
  {
    "type": "get",
    "url": "/media_sosial/list",
    "title": "Mengambil daftar media sosial",
    "name": "GetMediaSosial",
    "group": "MediaSosial",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n\"content\": [\n{\n  \"id\": \"1\",\n  \"gambar\": \"fb.png\",\n  \"link\": \"https://www.facebook.com/groups/OpenSID/\",\n  \"nama\": \"Facebook\",\n  \"enabled\": \"1\"\n},\n{\n  \"id\": \"2\",\n  \"gambar\": \"twt.png\",\n  \"link\": \"\",\n  \"nama\": \"Twitter\",\n  \"enabled\": \"1\"\n},\n{\n  \"id\": \"3\",\n  \"gambar\": \"goo.png\",\n  \"link\": \"\",\n  \"nama\": \"Google Plus\",\n  \"enabled\": \"1\"\n}\n]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "media",
            "description": "<p>sosial tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : null\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Media_sosial.php",
    "groupTitle": "MediaSosial"
  },
  {
    "type": "get",
    "url": "/menu/list",
    "title": "Mengambil daftar menu",
    "name": "GetMenu",
    "group": "Menu",
    "success": {
      "examples": [
        {
          "title": "Success-Response:",
          "content": "HTTP/1.1 200 OK\n{\n \"status\": 1,\n\"content\": [\n    {\n      \"id\": \"16\",\n      \"nama\": \"Profil Desa\",\n      \"link\": \"artikel/32\",\n      \"tipe\": \"1\",\n      \"parrent\": \"1\",\n      \"link_tipe\": \"1\",\n      \"enabled\": \"1\",\n      \"urut\": null,\n      \"sub_menu\": [\n        {\n      \"id\": \"55\",\n      \"nama\": \"Profil Wilayah Desa\",\n      \"link\": \"artikel/33\",\n      \"tipe\": \"3\",\n      \"parrent\": \"16\",\n      \"link_tipe\": \"1\",\n      \"enabled\": \"1\",\n      \"urut\": null\n        },\n        {\n      \"id\": \"114\",\n      \"nama\": \"Sejarah Desa\",\n      \"link\": \"artikel/99\",\n      \"tipe\": \"3\",\n      \"parrent\": \"16\",\n      \"link_tipe\": \"0\",\n      \"enabled\": \"1\",\n      \"urut\": null\n        }\n      ]\n    },\n    {\n      \"id\": \"17\",\n      \"nama\": \"Pemerintahan Desa\",\n      \"link\": \"artikel/85\",\n      \"tipe\": \"1\",\n      \"parrent\": \"1\",\n      \"link_tipe\": \"1\",\n      \"enabled\": \"1\",\n      \"urut\": null,\n      \"sub_menu\": [\n        {\n      \"id\": \"57\",\n      \"nama\": \"Visi dan Misi\",\n      \"link\": \"artikel/93\",\n      \"tipe\": \"3\",\n      \"parrent\": \"17\",\n      \"link_tipe\": \"0\",\n      \"enabled\": \"1\",\n      \"urut\": null\n        },\n        {\n      \"id\": \"58\",\n      \"nama\": \"Pemerintah Desa\",\n      \"link\": \"artikel/92\",\n      \"tipe\": \"3\",\n      \"parrent\": \"17\",\n      \"link_tipe\": \"0\",\n      \"enabled\": \"1\",\n      \"urut\": null\n        }\n      ]\n    }\n  ]\n }",
          "type": "json"
        }
      ]
    },
    "error": {
      "fields": {
        "Error 4xx": [
          {
            "group": "Error 4xx",
            "optional": false,
            "field": "menu",
            "description": "<p>tidak ditemukan</p>"
          }
        ]
      },
      "examples": [
        {
          "title": "Error-Response:",
          "content": "HTTP/1.1 404 Not Found\n{\n  \"status\": \"0\",\n  \"content\" : null\n}",
          "type": "json"
        }
      ]
    },
    "version": "0.0.0",
    "filename": "application/controllers/api/Menu.php",
    "groupTitle": "Menu"
  }
] });

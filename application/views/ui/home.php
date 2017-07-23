<!DOCTYPE html>
<html lang="en" class="no-js">
    <!-- Begin Head -->
    <head>
        <!-- Basic -->
        <meta charset="utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>OpenSID Web</title>
        <meta name="keywords" content="HTML5 Theme" />
        <meta name="description" content="openSID Web">
        <meta name="author" content="ezioalzeusi - openSID Web">

        <!-- Web Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Lato:300,400,400i|Montserrat:400,700" rel="stylesheet">

        <!-- Vendor Styles -->
        <link href="<?php echo site_url('assets/vendor/bootstrap/css/bootstrap.min.css') ?>" rel="stylesheet" type="text/css"/>
        <link href="<?php echo site_url('assets/css/animate.css') ?>" rel="stylesheet" type="text/css"/>
        <link href="<?php echo site_url('assets/vendor/themify/themify.css') ?>" rel="stylesheet" type="text/css"/>
        <link href="<?php echo site_url('assets/vendor/scrollbar/scrollbar.min.css') ?>" rel="stylesheet" type="text/css"/>
        <link href="<?php echo site_url('assets/vendor/swiper/swiper.min.css') ?>" rel="stylesheet" type="text/css"/>
        <link href="<?php echo site_url('assets/vendor/cubeportfolio/css/cubeportfolio.min.css') ?>" rel="stylesheet" type="text/css"/>

        <!-- Theme Styles -->
        <link href="<?php echo site_url('assets/css/style.css') ?>" rel="stylesheet" type="text/css"/>
        <link href="<?php echo site_url('assets/css/global/global.css') ?>" rel="stylesheet" type="text/css"/>
        <!-- Theme Skins -->
        <link href="<?php echo site_url('assets/css/theme/red.css') ?>" rel="stylesheet" type="text/css"/>

        <link rel="icon" type="image/png" href="<?php echo site_url('assets/img/logodaerah.png') ?>">
        <!-- Favicon -->
        <link rel="shortcut icon" href="<?php echo site_url('assets/img/logodaerah.png') ?>" type="image/png">
        <link rel="apple-touch-icon" href="<?php echo site_url('assets/img/logodaerah.png') ?>">
    </head>
    <!-- End Head -->
    <body>
        <!--========== HEADER ==========-->
        <header class="navbar-fixed-top s-header js__header-sticky js__header-overlay">
            <!-- Navbar -->
            <nav class="s-header-v2__navbar">
                <div class="container g-display-table--lg">
                    <!-- Navbar Row -->
                    <div class="s-header-v2__navbar-row">
                        <!-- Brand and toggle get grouped for better mobile display -->
                        <div class="s-header-v2__navbar-col">
                            <button type="button" class="collapsed s-header-v2__toggle" data-toggle="collapse" data-target="#nav-collapse" aria-expanded="false">
                                <span class="s-header-v2__toggle-icon-bar"></span>
                            </button>
                        </div>

                        <div class="s-header__navbar-row-col">
                            <!-- Logo -->

                            <div class="s-header__logo">
                                <a href="" class="s-header__logo-link">
                                 Desa <?php echo $configDesa->nama_desa ?>
                                </a>
                            </div>
                            <!-- End Logo -->
                        </div>

                        <div class="s-header-v2__navbar-col s-header-v2__navbar-col--right">
                            <!-- Collect the nav links, forms, and other content for toggling -->
                            <div class="collapse navbar-collapse s-header-v2__navbar-collapse" id="nav-collapse">
                                <ul class="s-header-v2__nav">
                                    <?php
                                      if(!empty($menu)){
                                        foreach($menu as $_m){
                                          if(!empty($_m->sub_menu)){
                                            echo '<li class="dropdown s-header-v2__nav-item s-header-v2__dropdown-on-hover">';
                                            echo '<a href="javascript:void(0);" class="dropdown-toggle s-header-v2__nav-link" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">'.$_m->nama.' <span class="g-font-size-10--xs g-margin-l-5--xs ti-angle-down"></span></a>';
                                            echo  '<ul class="dropdown-menu s-header-v2__dropdown-menu">';
                                            foreach($_m->sub_menu as $_sm){
                                                echo '<li class="s-header-v2__dropdown-menu-link"><a href="'.site_url($_sm->link).'" class="s-header-v2__nav-link">'.$_sm->nama.'</a></li>';
                                            }
                                            echo '</ul>';
                                            echo '</li>';
                                          }else{
                                            echo '<li class="s-header-v2__nav-item"><a href="'.site_url($_sm->link).'" class="s-header-v2__nav-link">'.$_m->nama.'</a></li>';
                                          }
                                        }
                                      }
                                    ?>
                                </ul>
                            </div>
                            <!-- End Nav Menu -->
                        </div>
                    </div>
                    <!-- End Navbar Row -->
                </div>
            </nav>
            <!-- End Navbar -->
        </header>

         <!--========== END HEADER ==========-->

        <!--========== PROMO BLOCK ==========-->
        <div class="g-bg-position--center js__parallax-window" style="background: url(img/back2.jpg) 50% 0 no-repeat fixed;">
            <div class="g-container--md g-text-center--xs g-padding-y-150--xs">
                <p class="text-uppercase g-font-size-14--xs g-font-weight--700 g-color--white-opacity g-letter-spacing--2 g-margin-b-25--xs">17 Agustus 2017</p>
                <h1 class="g-font-size-40--xs g-font-size-50--sm g-font-size-60--md g-color--white g-letter-spacing--1">Perayaan Hari Kemerdekaan 2016</h1>
            </div>
        </div>
        <!--========== END PROMO BLOCK ==========-->
          <div class="g-padding-y-50--xs g-padding-y-80--sm">
            <div class="g-container--sm">
                <article>
                <div class="g-text-center--xs g-margin-b-80--xs">
                    <h2 class="g-font-size-25--xs g-font-size-35--sm  g-margin-b-40--xs"><?php echo $artikel->judul ?></h2>
                    <p class="g-font-size-14--md"> <?php echo $artikel->tgl_upload ?> oleh <?php echo $artikel->author->nama ?></p>
                    <p class="g-font-size-14--md"><?php echo $artikel->isi ?></p>
                </div>
                </article>
<div id="comments" class="comments-area">
    <h2 class="comments-title">Komentar</h2>
        <ol class="comment-list">
            <li class="comment even thread-even depth-1">
            <article class="comment-body">
                <footer class="comment-meta">
                    <div class="comment-author vcard">
                        <b class="fn">
                        <a>Penduduk Biasa</a>
                        </b>
                        <span class="says">mengatakan:</span>
                    </div>
                    <div class="comment-metadata">
                        <a href="http://localhost/wordpress/2017/05/01/hello-world/#comment-1">
                        <time datetime="2017-05-01T11:19:10+00:00">
                        May 1, 2017 at 11:19 am
                        </time>
                        </a>
                    </div>
                 </footer>

                <div class="comment-content">
                    <p>Selamat atas keberhasilan Senggigi merayakan Hari Kemerdeakaan 2016!</p>
                </div>
            </article>
            </li>
        </ol>
        <div id="respond" class="comment-respond">
        </div><!-- #respond -->

                    <div class="col-md-12 js__form-eqaul-height-v1">
                        <div class="g-padding-x-40--xs g-padding-y-50--xs">
                            <h2 class="g-font-size-24--xs g-color--primary g-margin-b-50--xs">Beri Komentar</h2>
                            <form>
                                <div class="row g-margin-b-30--xs g-margin-b-50--md">
                                    <div class="g-margin-b-30--xs g-margin-b-0--md">
                                        <input type="text" class="form-control s-form-v4__input g-padding-l-0--xs" placeholder="* Nama">
                                    </div>
                                </div>
                                <div class="row g-margin-b-50--xs g-margin-b-50--md">
                                    <div class="-margin-b-30--xs g-margin-b-0--md">
                                        <input type="email" class="form-control s-form-v4__input g-padding-l-0--xs" placeholder="* Email">
                                    </div>
                                </div>
                                <div class="row g-margin-b-50--xs g-margin-b-50--md">
                                    <textarea class="form-control s-form-v4__input g-padding-l-0--xs" rows="5" placeholder="* Komentar"></textarea>
                                </div>
                                <div class="g-text-center--xs">
                                    <button type="submit" class="text-uppercase s-btn s-btn--md s-btn--primary-bg g-radius--50 g-padding-x-70--xs g-margin-b-20--xs">Komen</button>
                                </div>
                            </form>
                        </div>
                    </div>
        </div><!-- #comments -->
        </div>
        </div>
                <!--========== FOOTER ==========-->
        <footer class="g-bg-color--dark">
            <!-- Links -->
            <div class="g-hor-divider__dashed--white-opacity-lightest">
                <div class="container g-padding-y-80--xs">
                    <div class="row">
                        <div class="col-sm-2 g-margin-b-20--xs g-margin-b-0--md">
                            <ul class="list-unstyled g-ul-li-tb-5--xs g-margin-b-0--xs">
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Beranda</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Profil</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Berita</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Data</a></li>
                            </ul>
                        </div>
                        <div class="col-sm-2 g-margin-b-20--xs g-margin-b-0--md">
                            <ul class="list-unstyled g-ul-li-tb-5--xs g-margin-b-0--xs">
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Twitter</a></li>
                                <li><a class="g-font-size-15--xs g-color--white-opacity" href="">Facebook</a></li>
                            </ul>
                        </div>
                        <div class="col-md-4 col-md-offset-2 col-sm-5 col-sm-offset-1 s-footer__logo g-padding-y-50--xs g-padding-y-0--md">
                            <h3 class="g-font-size-18--xs g-color--white">OpenSID Web</h3>
                            <p class="g-color--white-opacity">© 2006-2017 Aplikasi Sistem Informasi Desa (SID) Web yang digunakan dalam situs ini adalah OpenSID Web beta 0.1 </p>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Links -->

            <!-- Copyright -->
            <div class="container g-padding-y-50--xs">
                <div class="row">
                    <div class="col-xs-6">
                        <a href="index.html">
                            DESA BOJONG WETAN
                        </a>
                    </div>
                    <div class="col-xs-6 g-text-right--xs">
                        <p class="g-font-size-14--xs g-margin-b-0--xs g-color--white-opacity-light">Bojong Wetan Powered by <a href="#">openSID Web</a></p>
                    </div>
                </div>
            </div>
            <!-- End Copyright -->
        </footer>
        <!--========== END FOOTER ==========-->
        <a href="javascript:void(0);" class="s-back-to-top js__back-to-top"></a>

        <!--========== JAVASCRIPTS (Load javascripts at bottom, this will reduce page load time) ==========-->
        <!-- Vendor -->
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/jquery.min.js') ?> "></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/jquery.migrate.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/bootstrap/js/bootstrap.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/jquery.smooth-scroll.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/jquery.back-to-top.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/scrollbar/jquery.scrollbar.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/jquery.parallax.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/vendor/jquery.wow.min.js') ?>"></script>

        <!-- General Components and Settings -->
        <script type="text/javascript" src="<?php echo site_url('assets/js/global.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/js/components/header-sticky.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/js/components/scrollbar.min.js') ?>"></script>
        <script type="text/javascript" src="<?php echo site_url('assets/js/components/wow.min.js') ?>"></script>
        <!--========== END JAVASCRIPTS ==========-->

    </body>
    <!-- End Body -->
</html>

<?php

class AUTHORIZATION
{
    public static function validateToken($token,$alg = array('HS256'))
    {
        $CI =& get_instance();
        return JWT::decode($token, $CI->config->item('jwt_key'),$alg);
    }

    public static function generateToken($data)
    {
        $CI =& get_instance();
        return JWT::encode($data, $CI->config->item('jwt_key'));
    }

}

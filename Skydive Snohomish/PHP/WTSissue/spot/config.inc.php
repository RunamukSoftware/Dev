<?php

/*
Spotter - Calculates skydive jump run and exit points
Copyright (C) 2010  Matthew C. Veno <matt@flyingchipmunk.com>
Version 1.2.1

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
Also add information on how to contact you by electronic and paper mail.
*/

$CONFIG = array(

// Browser title
'pageTitle' => 'What&rsquo;s the Spot',

// Map width & height in pixels
'mapWidth' => '689',
'mapHeight' => '500',

// Set to true the concentric circles you want displayed around LZ
'mapDrawQuarter' => false,
'mapDrawHalf' => true,
'mapDraw3Quarters' => false,
'mapDrawMile' => true,

// Google Maps API Key
// This api needs to be registered to the domain or the map will not display
//   http://code.google.com/apis/maps/
//'googleApi' => 'ABQIAAAA6wVZX83BR8UdtgCzPRkNzRTbqZO1nf91bbCArl2s-RUhlUIcphRsHYsccs5CmPNavw-LNNp6TA-3Ew',
'googleApi' => 'ABQIAAAA6wVZX83BR8UdtgCzPRkNzRTbqZO1nf91bbCArl2s-RUhlUIcphRsHYsccs5CmPNavw-LNNp6TA-3Ew',

// Path to the data cache directory, should not be directly
//   web accessible.
'dataDir' => $_SERVER['DOCUMENT_ROOT'].'\\PHP\\WTSissue\\',

// The specific 3 digit airport identifier in the forecast.
// Visit this page and click on your region on the map to see a list of
//   available airport identifiers:
//		http://aviationweather.gov/products/nws/winds/
'airportId' => 'SEA',

// Latitude and Longitude of the center of the landing zone
//'lzLat' => '47.909425', // north
//'lzLon' => '-122.070956', // west
//'lzLat' => '47.897807', // north
//'lzLon' => '-122.0798171', // west
// New landing zone as of 12-10-2015 - TG
'lzLat' => '47.906116', // north
'lzLon' => '-122.101357', // west

// Declination offset used to calculate magnetic north, this value changes
//   over time, see following URL to retrieve value using the lat/lon
//   of the center of the landing zone.
//     http://www.ngdc.noaa.gov/geomagmodels/Declination.jsp
//
//   >>> Last Updated: March 2010 <<<
'lzDeclination' => 16,

// Set this to true to show the clickable "[D]" in output
// Set this to false to hide the clickable "[D]" links and ignore 'debug' param
'allowDebug' => false,

// Default airspeed used for separation calculation
'defaultAirspeed' => '80',

// Default desired horizontal separation for groups. REF: SIM 5-7 C (1000 ft)
'defaultSeparation' => '1000',

// This is the base URL for retrieving the raw forecast data,
//   don't change unless you know what you are doing!
'baseUrl' => "http://aviationweather.gov/products/nws/all",

);

?>

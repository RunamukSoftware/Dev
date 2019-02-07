<?php





/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://codex.wordpress.org/Editing_wp-config.php
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define('WP_CACHE', true);
define( 'WPCACHEHOME', '/data/57/4/147/91/4473906/user/5305344/htdocs/snohomishflying/wp-content/plugins/wp-super-cache/' );
define('DB_NAME', '1_03d61b6_3');

/** MySQL database username */
define('DB_USER', '1_03d61b6_3');

/** MySQL database password */
define('DB_PASSWORD', 'PTn99GNSsP');

/** MySQL hostname */
define('DB_HOST', 'mysqlcluster21');

/** Database Charset to use in creating database tables. */
define('DB_CHARSET', 'utf8');

/** The Database Collate type. Don't change this if in doubt. */
define('DB_COLLATE', '');

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '7AotVUGzfK6hXJikZVz08NTCw239fkbAjLydiklqkHynzPq5rBjb37bCxrmyK6Ck');
define('SECURE_AUTH_KEY',  'TG7DbDUftOVE9MqxZnPgew8365VVTnwXJz3k5zKp7UnEd0laLvSeWLFWxKQrSwCL');
define('LOGGED_IN_KEY',    'Wvj0xwHB938H3LpRiZgtWTVD4QZu9hN60lWJbFH33SiDpDAfWVYQQbVOmtoDWpRy');
define('NONCE_KEY',        '5Sx77CgMMB6a3HlbuuzQrVhzpClyIYeahn4QmuJghS4u6cHOR5Sb8VTJlusngeek');
define('AUTH_SALT',        'LPwwZQyNwjUSBR3vwRvpLFtyTzkKqmK1cIu4kCo0MudvvyebbRNBs0StdivRFgaW');
define('SECURE_AUTH_SALT', 's1wgjS55Xl4uUN1CLFnmK4YCyKimjFg53oeWGcnaB41YAjJ3awAmz41bBRC11hzS');
define('LOGGED_IN_SALT',   'rBmDE6p1eyaka36usOkbXsG7jVLnVsJs3bdRhjyKEFeYTPEEPZZAb7IuGnTJCxLi');
define('NONCE_SALT',       '0BiYwcHiNRO86trAe0QaFqUSp9C1vW5Z9EJwBBWVN5cX7JH76UCXGUthmHun5rz5');

/**
 * Other customizations.
 */
define('FS_METHOD','direct');define('FS_CHMOD_DIR',0755);define('FS_CHMOD_FILE',0644);
define('WP_TEMP_DIR',dirname(__FILE__).'/wp-content/uploads');

/**
 * Turn off automatic updates since these are managed upstream.
 */
define('AUTOMATIC_UPDATER_DISABLED', true);


/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix  = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* That's all, stop editing! Happy blogging. */

/** Absolute path to the WordPress directory. */
if ( !defined('ABSPATH') )
	define('ABSPATH', dirname(__FILE__) . '/');

/** Sets up WordPress vars and included files. */
require_once(ABSPATH . 'wp-settings.php');

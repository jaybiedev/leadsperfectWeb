<?php
/**
 * This is the bootstrap
 */

$config_file = __DIR__ . "/config/config.ini";

if (!is_file($config_file)) {
    echo "Config file not found. " . $config_file;
    return false;
}

// Get the minimum config information so that the code base knows how to run
$config =  parse_ini_file($config_file, false);

if (php_sapi_name() == 'cli' && $config['cli_down']) {
    echo 'Site Disabled';
    return;
}
elseif (php_sapi_name() != 'cli' && $config['web_down']) {
    return render_system_down("System is currently offline.");
}

$code_base = $config['code_base'];
if (empty($code_base)) {
    return render_system_down("Code base not defined. Check configuration file.");
}

// Set up the base environment

// Change to current directory so that command line execs work like the apache ones
chdir(dirname(__FILE__));

// This is to the base htdocs folder that is where apache serves from
$root_path = realpath(__DIR__ . '/../');
// $root_path = $_SERVER["DOCUMENT_ROOT"];
$web_path = __DIR__;

$base_url = $config['base_url'];

/*
if (empty($base_url))
{
    $base_url = $_SERVER['SCRIPT_URI'];
}
if (empty($base_url)) {

    $path_parts = preg_split("/[\\/]+/", $_SERVER['PHP_SELF'], -1, PREG_SPLIT_NO_EMPTY);
    $web = key($path_parts);
    array_splice($path_parts, $web +1);
    $base_subfolder = implode('/', $path_parts);
    $base_url = $_SERVER['REQUEST_SCHEME'] . '://' . $_SERVER['HTTP_HOST'] . '/' . $base_subfolder;

}
*/

$code_path  =  $root_path . '/' . $code_base;
$system_controller_class_file = $code_path . "/index.php";
$asset_path = $code_path . "/assets";

if (false == is_dir($code_path) || false == is_file($system_controller_class_file))
{
    return render_system_down('Checked Release Codebase: ' . basename($code_base));
}

define ('WEB_PATH', $web_path);
define('WEB_URL', $base_url);


if (realpath("assets") != realpath($asset_path)) {
    @unlink("assets");
    symlink($asset_path, "assets");
}

chdir(dirname($system_controller_class_file));

require_once($system_controller_class_file);


function render_system_down($msg)
{
    $down_html_file = "<h1>{$msg}</h1>";

    echo $down_html_file;
    return;
}

daemonize = false;
allow_registration = false;
admins = {
};
-- you can set the system user to use:
-- prosody_user = "";
pidfile = "./prosody.pid";
plugin_paths = {
  -- set here the folder where you want to search for plugins
};
data_path = "./samples/data/";
storage = "internal";
modules_enabled = {
  "roster";
  "saslauth";
  "carbons";
  "version";
  "uptime";
  "ping";
  "bosh";
  "posix";
  "disco";
  "s2s";
  "tls";
};
modules_disabled = {
};
consider_bosh_secure = true;
consider_websocket_secure = true;
-- certificates = "";
c2s_require_encryption = false;
interfaces = {
  "127.0.0.1";
  "::1";
};
c2s_ports = {
};
c2s_interfaces = {
  "127.0.0.1";
  "::1";
};
s2s_ports = {
  "5269";
};
s2s_interfaces = {
  "*";
  "::";
};
http_ports = {
  "5280";
};
http_interfaces = {
  "127.0.0.1";
  "::1";
};
https_ports = {
};
https_interfaces = {
  "127.0.0.1";
  "::1";
};
trusted_proxies = {
  "127.0.0.1";
  "::1";
};

VirtualHost "localhost"

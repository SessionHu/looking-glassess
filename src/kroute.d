import std.process : execv;
import std.stdio : stdout;


void kroute(string dst, string ipv) {
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  version (linux) version (Android) {
    auto cmd = ["ip"];
    if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
    cmd ~= ["route"];
    if (dst.length > 0) cmd ~= ["get", dst];
    execv("/usr/bin/ip", cmd);
  } else {
    auto cmd = ["route"];
    if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
    if (dst.length > 0) cmd ~= ["get", dst];
    execv("/sbin/route", cmd);
  }
}

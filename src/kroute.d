import std.process : execv;
import std.stdio : stdout;
import std.system : OS, os;

void kroute(string dst, string ipv) {
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  static if (os == OS.linux || os == OS.android) {
    auto cmd = ["ip"];
    if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
    cmd ~= ["route"];
    if (dst.length > 0) cmd ~= ["get", dst];
    execv("/sbin/ip", cmd);
  } else {
    auto cmd = ["route"];
    if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
    if (dst.length > 0) cmd ~= ["get", dst];
    execv("/sbin/route", cmd);
  }
}

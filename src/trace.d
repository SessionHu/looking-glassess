import std.process : execv;
import std.stdio : stdout;
import std.system : OS, os;

void trace(string hst, string ipv, string proto) {
  auto cmd = ["traceroute"];
  if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
  if (proto == "icmp") cmd ~= "-I";
  cmd ~= ["--", hst];
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  static if (os == OS.android) {
    execv("/data/data/com.termux/files/usr/bin/traceroute", cmd);
  } else {
    execv("/usr/sbin/traceroute", cmd);
  }
}

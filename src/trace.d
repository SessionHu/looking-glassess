import std.process : execv;
import std.stdio : stdout;
import std.string : indexOf;
import std.system : OS, os;

void trace(string hst, string ipv, string proto) {
  string[] cmd = [];
  static if (os == OS.android) {
    cmd ~= ["/data/data/com.termux/files/usr/bin/traceroute"];
  } else {
    cmd ~= ["/usr/sbin/traceroute"];
  }
  static if (os == OS.freeBSD) {
    if (ipv == "6" || indexOf(hst, ":") > -1) cmd[0] ~= "6";
  } else {
    if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
  }
  if (proto == "icmp") cmd ~= "-I";
  cmd ~= ["--", hst];
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  execv("/bin/timeout", ["timeout", "-k10", "-sINT", "60s"] ~ cmd);
}

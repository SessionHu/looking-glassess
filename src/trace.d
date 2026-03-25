import std.process : execv;
import std.stdio : stdout;

void trace(string hst, string ipv, string proto) {
  auto cmd = ["traceroute"];
  if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
  if (proto == "icmp") cmd ~= "-I";
  cmd ~= ["--", hst];
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  execv("/usr/bin/traceroute", cmd);
}

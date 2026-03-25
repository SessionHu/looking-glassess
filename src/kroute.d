import std.process : execv;
import std.stdio : stdout;

void kroute(string dst, string ipv) {
  auto cmd = ["ip"];
  if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
  cmd ~= ["route"];
  if (dst.length > 0) cmd ~= ["get", dst];
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  execv("/usr/bin/ip", cmd);
}

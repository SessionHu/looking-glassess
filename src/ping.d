import std.process : execv;
import std.stdio : stdout;
import std.system : OS, os;

void ping(string dst, string ipv) {
  auto cmd = ["ping", "-c4"];
  if (ipv == "4" || ipv == "6") cmd ~= ["-" ~ ipv];
  cmd ~= ["--", dst];
  stdout.write("content-type: text/plain\r\n");
  stdout.write("\r\n");
  stdout.flush();
  if (os == OS.linux || os == OS.android) {
    execv("/bin/ping", cmd);
  } else {
    execv("/sbin/ping", cmd);
  }
}

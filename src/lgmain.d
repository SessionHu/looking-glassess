import core.sys.posix.unistd : dup2;
import std.algorithm : filter, map;
import std.array : assocArray;
import std.process : environment;
import std.string : indexOf, split;
import std.stdio : stdout;
import std.typecons : Tuple, tuple;
import std.uri : decodeComponent;

import broute : broute;
import dig : dig;
import kroute : kroute;
import ping : ping;
import proto : proto;
import trace : trace;

string[string] getQueries() {
   return environment.get("QUERY_STRING").split("&").map!((string s) {
    auto i = s.indexOf("=");
    if (i < 0) try {
      return tuple(decodeComponent(s), "");
    } catch (Exception) {
    	return tuple(s, "");
    }
    auto k = s[0..i];
    auto v = s[i+1..$];
    try {
      return tuple(decodeComponent(k), decodeComponent(v));
    } catch (Exception) {
    	return tuple(k, v);
    }
  }).filter!((t) => t[0].length > 0).assocArray;
}

int main() {
  dup2(1, 2);
  auto queries = getQueries();
  switch (queries.get("action", "")) {
    case "ping":
      ping(queries.get("target", ""), queries.get("ipv", ""));
      break;
    case "trace":
      trace(queries.get("target", ""), queries.get("ipv", ""), queries.get("proto", ""));
      break;
    case "kroute":
      kroute(queries.get("target", ""), queries.get("ipv", ""));
      break;
    case "proto":
      proto(queries.get("all", "") == "true", queries.get("target", ""));
      break;
    case "broute":
      broute(queries.get("all", "") == "true", queries.get("target", ""));
      break;
    case "dig":
      dig(queries.get("target", ""));
      break;
    default:
      stdout.write("Status: 404 Not Found\r\n");
      stdout.write("Content-Type: text/plain\r\n\r\n");
      stdout.writeln("action not found");
  }
  return 0;
}

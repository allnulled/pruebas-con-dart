import 'dart:io';
import 'dart:convert';

class SimpleServer {

  static Future start(Map config) async {
    String host = config["host"] ?? "0.0.0.0";
    int port = config["port"] ?? 3000;

    HttpServer server = await HttpServer.bind(host, port);
    print("Listening on http://$host:$port");

    await for (HttpRequest req in server) {
      await handleRequest(req);
    }
  }

  static Future handleRequest(HttpRequest req) async {

    String method = req.method;
    Uri uri = req.uri;

    String path = uri.path;

    Map query = {};
    Map queryRaw = uri.queryParameters;

    List qkeys = queryRaw.keys.toList();
    for(int i=0;i<qkeys.length;i++){
      String k = qkeys[i];
      query[k] = queryRaw[k];
    }

    Object body = await parseBody(req);

    Map request = {
      "method": method,
      "path": path,
      "query": query,
      "body": body
    };

    print(request);

    req.response.headers.contentType = ContentType.json;

    Map response = {
      "ok": true,
      "request": request
    };

    req.response.write(jsonEncode(response));
    await req.response.close();
  }

  static Future parseBody(HttpRequest req) async {

    if(req.method == "GET" || req.method == "HEAD"){
      return null;
    }

    String raw = await utf8.decoder.bind(req).join();

    if(raw.isEmpty){
      return null;
    }

    String contentType = req.headers.contentType?.mimeType ?? "";

    if(contentType == "application/json"){
      try {
        return jsonDecode(raw);
      } catch(e) {
        return raw;
      }
    }

    return raw;
  }

}

Future main(List<String> args) async {
  await SimpleServer.start({
    "host": "0.0.0.0",
    "port": 3000
  });
}
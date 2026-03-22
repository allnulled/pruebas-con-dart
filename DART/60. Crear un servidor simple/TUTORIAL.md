Para crear un servidor HTTP simple con Dart, primero hay que definir simple.

Un servidor HTTP simple sería uno que:

- parsea parámetros de la URL
   - los del path
   - los del query
- parsea parámetros del body
   - solo tipo JSON
- permite definir el handler de peticiones

Con esta abstracción, ya podemos abarcar los casos de HTTP más simples.

```dart
#!/usr/bin/env dart

import 'dart:io';
import 'dart:convert' show jsonDecode, jsonEncode, utf8;

class SimpleServer {

  final Future handler;

  SimpleServer(this.handler);

  static Future start(Map config) async {
    String host = config["host"] ?? "0.0.0.0";
    int port = config["port"] ?? 3000;
    HttpServer server = await HttpServer.bind(host, port);
    print("[*] Listening on http://$host:$port");
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
    Object? body = await parseBody(req);
    Map action = {
      "method": method,
      "path": path.split("/").where((String part) => part != "").toList(),
      "query": query,
      "body": body
    };
    print(action);
    req.response.headers.contentType = ContentType.json;
    Map answer = {
      "status": "ok",
      "in": action,
      "out": null,
    };
    String jsonAnswer = jsonEncode(answer);
    req.response.write(jsonAnswer);
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
```
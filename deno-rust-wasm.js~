// deno run -A deno-rust-wasm.js
// deno run -A -r https://raw.githubusercontent.com/bohachu/deno-rust-wasm/main/deno-rust-wasm.js

console.log("Install rust and wasm hello world template. 2020-12-04 by cbh@cameo.tw");
import {exec} from "https://deno.land/x/exec/mod.ts";

//系統要記得先安裝 wasm-pack: curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

Deno.writeTextFile("./install.sh", `
wasm-pack new hello-wasm
cd hello-wasm
wasm-pack build --target web
`);
await exec(`bash install.sh`);

Deno.writeTextFile("./hello-wasm/index.html", `
<html>
  <head>
    <meta charset="utf-8" />
  </head>
  <body>
    <script type="module">
      import { default as wasm, greet } from "./pkg/hello_wasm.js";
      wasm().then((module) => {
        greet();
      });
    </script>
  </body>
</html>
`);

await exec(`open http://localhost:8000`);

console.log("python server run at localhost:8000")
Deno.writeTextFile("./web-server.sh", `
cd hello-wasm
python3 -m http.server 8000
`);
await exec(`bash web-server.sh`);





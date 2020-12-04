// blog https://blog.logrocket.com/getting-started-with-webassembly-and-rust/

//// run remote js
// deno cache https://raw.githubusercontent.com/bohachu/deno-rust-wasm/main/deno-rust-wasm.js --reload
// deno run -A https://raw.githubusercontent.com/bohachu/deno-rust-wasm/main/deno-rust-wasm.js

//// run local js
// deno run -A deno-rust-wasm.js

console.log("v3 Install rust and wasm hello world template. 2020-12-04 by cbh@cameo.tw");
import {exec} from "https://deno.land/x/exec/mod.ts";

//要先安裝 curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
//要先安裝 curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh

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

// await exec(`open http://localhost:8866`);

console.log("python server run at port 8866")
Deno.writeTextFile("./web-server.sh", `
cd hello-wasm
python3 -m http.server 8866
`);
await exec(`bash web-server.sh`);


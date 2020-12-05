echo '全自動創建 rust and wasm 編譯模板程式碼，方便後續編輯 by cbh@cameo.tw 2020-12-05'
echo 'time curl https://raw.githubusercontent.com/bohachu/deno-rust-wasm/main/go.sh | sh'

if ! [[ "$(rustup --version)" == *"rustup"* ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ! [[ "$(wasm-pack --version)" == *"wasm-pack"* ]]; then
  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
fi

#hello-wasm
wasm-pack new hello-wasm
cd hello-wasm
wasm-pack build --target web

echo '<html>
  <head>
    <meta charset="utf-8" />
  </head>
  <body>
    This is rust + wasm 🐲！
    <script type="module">
      import { default as wasm, greet } from "./pkg/hello_wasm.js";
      wasm().then((module) => {
        greet();
      });
    </script>
  </body>
</html>' > ./hello-wasm/index.html

echo 請運用瀏覽器 http://localhost:8866/ 來測試hello-wasm
open http://localhost:8866/
cd hello-wasm
nohup python3 -m http.server 8866 &


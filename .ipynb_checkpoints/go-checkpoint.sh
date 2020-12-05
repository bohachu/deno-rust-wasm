echo '全自動創建 rust and wasm 編譯模板程式碼，方便後續編輯 by cbh@cameo.tw 2020-12-05'
echo 'time curl https://raw.githubusercontent.com/bohachu/deno-rust-wasm/main/go.sh | bash'
if ! [[ "$(rustup --version)" == *"rustup"* ]]; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi
if ! [[ "$(wasm-pack --version)" == *"wasm-pack"* ]]; then
  curl https://rustwasm.github.io/wasm-pack/installer/init.sh -sSf | sh
fi
if ! [[ "$(cc --version)" == *"c"* ]]; then
  sudo apt -y install build-essential
fi
wasm-pack new hello-wasm
cd hello-wasm
wasm-pack build --target web
echo '<meta charset="utf-8" />
  This is rust + wasm 🐲！
  <script type="module">
      import { default as wasm, greet } from "./pkg/hello_wasm.js";
      wasm().then((module) => {
        greet();
      });
  </script>' > index.html
echo '請運用瀏覽器測試 http://public_ip:8866/index.html'
if ! [[ "$(uname -a)" == *"Debian"* ]]; then
  open http://localhost:8866/
fi
nohup python3 -m http.server 8866 &

vim.keymap.set('n', '`<cr>', ':RunCode<CR>', { noremap = true, silent = true })

require('code_runner').setup({
  -- mode = 'toggleterm',
  mode = 'tab',
  float = {
    border = 'rounded',
    height = 1,
    width = 1,
  },
  startinsert = false,
  -- put here the commands by filetype
  filetype = {
    java = 'cd $dir && javac $fileName && java $fileNameWithoutExt',
    python = 'cd $dir && python3 $dir/$fileName',
    r = 'Rscript $dir/$fileName',
    typescript = 'deno run',
    julia = 'julia $dir/$fileName',
    rust = 'cd $dir && rustc $fileName && $dir/$fileNameWithoutExt',
    cpp = 'cd $dir && mkdir -p build && g++ -fsanitize=address -std=c++17 -Wall -Wextra -Wshadow -O2 -o ./build/$fileNameWithoutExt $fileName && ./build/$fileNameWithoutExt',
    c = 'cd $dir && mkdir -p build && gcc -fsanitize=address -Wall -Wextra -Wshadow -O2 -o ./build/$fileNameWithoutExt $fileName && ./build/$fileNameWithoutExt',
    swift = 'swift $dir/$fileName',
  },
})

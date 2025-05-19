return {
  cmd = { 'tailwindcss-language-server', '--stdio' },
  filetypes = { 
    'html', 
    'css', 
    'scss', 
    'javascript', 
    'javascriptreact', 
    'typescript', 
    'typescriptreact',
    'vue',
    'svelte',
  },
  root_markers = { 
    'tailwind.config.js',
    'tailwind.config.cjs',
    'tailwind.config.mjs',
    'tailwind.config.ts',
    'postcss.config.js',
    'postcss.config.cjs',
    'postcss.config.mjs',
    'postcss.config.ts',
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      validate = true,
    },
  },
}
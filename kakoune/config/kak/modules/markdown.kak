define-command -docstring 'preview markdown' preview-markdown %{
  evaluate-commands %sh{
    dir="/tmp/www"
    html=$(mktemp -u -p '').html
    path="$dir/$html"

    mkdir -p "$dir"

    if darkhttpd "$dir" --daemon --port 3000 >/dev/null 2>&1; then
      echo "echo darkhttpd server started on port 3000"
    fi

    printf '<!doctype html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1">
      <style>
        body,
        html {
          background: black;
          margin: 0;
        }
        .markdown-body {
          box-sizing: border-box;
          min-width: 200px;
          max-width: 980px;
          margin: 0 auto;
          padding: 45px;
        }
      </style>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.2.0/github-markdown.min.css">
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/styles/github-dark.min.css">
      <script src="https://cdnjs.cloudflare.com/ajax/libs/highlight.js/11.7.0/highlight.min.js"></script>
    </head>
    <body>
      <div class="markdown-body">%s</div>
      <script>hljs.highlightAll()</script>
    </body>
    </html>' "$(markdown -f fencedcode "$kak_buffile")" >> "$path"

    echo "echo http://localhost:3000${html}"
  }
}

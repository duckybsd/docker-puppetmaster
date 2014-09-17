# Define filebucket 'main':
filebucket { 'main':
  server => '<YOUR SERVER HERE>',
  path   => false,
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

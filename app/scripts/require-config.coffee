requirejs.config
    baseUrl: '.'
    paths:
      # Local
      zt: 'assets/scripts/namespace.js'      
      eventemitter2: '../vendor/eventemitter2.js'
      # External
      react: 'https://cdnjs.cloudflare.com/ajax/libs/react/0.13.2/react.min.js'
    name: 'main'
    out: 'main.js'
exports.config = {
  // See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
      joinTo: "js/app.js",
      order: {
        before: ["vendor/js/jquery-3.2.1.min.js", "vendor/js/bootstrap.min.js"]
      }

      // To use a separate vendor.js bundle, specify two files path
      // http://brunch.io/docs/config#-files-
      // joinTo: {
      //   "js/app.js": /^js/,
      //   "js/vendor.js": /^(?!js)/
      // }
      //
      // To change the order of concatenation of files, explicitly mention here
      // order: {
      //   before: [
      //     "vendor/js/jquery-2.1.1.js",
      //     "vendor/js/bootstrap.min.js"
      //   ]
      // }
    },
    templates: {
      joinTo: "js/app.js"
    },
    stylesheets: {
      joinTo: "css/app.css",
      // in the files.stylesheets section
      order: {
        after: ["priv/static/css/app.scss"] // concat app.css last
      }
    }
  },

  conventions: {
    // This option sets where we should place non-css and non-js assets in.
    // By default, we set this to "/assets/static". Files in this directory
    // will be copied to `paths.public`, which is "priv/static" by default.
    assets: /^(static)/
  },

  // Phoenix paths configuration
  paths: {
    // Dependencies and current project directories to watch
    watched: ["static", "css", "js", "vendor", "scss", "fonts"],
    // Where to compile files to
    public: "../priv/static"
  },

  // Configure your plugins
  plugins: {
    Popper: ["popper.js", "default"],
    babel: {
      // Do not use ES6 compiler in vendor code
      ignore: [/vendor/]
    },
    // in the plugins section
    sass: {
      options: {
        includePaths: [
          "node_modules/font-awesome/scss",
          "node_modules/bootstrap/scss"
        ], // tell sass-brunch where to look for files to @import
        precision: 8 // minimum precision required by bootstrap
      }
    },
    copycat: {
      fonts: ["static/fonts", "node_modules/font-awesome/fonts"],
      verbose: false, //shows each file that is copied to the destination directory
      onlyChanged: true //only copy a file if it's modified time has changed (only effective when using brunch watch)
    }
  },

  modules: {
    autoRequire: {
      "js/app.js": ["js/app"]
    }
  },

  npm: {
    enabled: true,
    // in the npm section
    globals: {
      // Bootstrap JavaScript requires both '$', 'jQuery', and Tether in global scope
      $: "jquery",
      jQuery: "jquery",
      Popper: "popper.js",
      bootstrap: "bootstrap" // require Bootstrap JavaScript globally too
    }
  }
};

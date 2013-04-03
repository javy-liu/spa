/*
 * grunt-init-spa
 * https://gruntjs.com/
 *
 * Copyright (c) 2012 excalibur "刘真源" faith, contributors
 * Licensed under the MIT license.
 */

'use strict';

// Basic template description.
exports.description = 'Create a single page application project, including QUnit unit tests and some high-usage libraries.';

// Template-specific notes to be displayed before question prompts.
exports.notes = '';

// Template-specific notes to be displayed after question prompts.
exports.after = 'You should now install project dependencies with _npm ' +
  'install_. After that, you may execute project tasks with _grunt_. For ' +
  'more information about installing and configuring Grunt, please see ' +
  'the Getting Started guide:' +
  '\n\n' +
  'http://gruntjs.com/getting-started';

// Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = '*';

// The actual init template.
exports.template = function(grunt, init, done) {

  init.process({type: 'jquery'}, [
    // Prompt for these values.
    init.prompt('name'),
    init.prompt('title', function(value, data, done) {
      // 
      done(null, value);
    }),
    init.prompt('description', 'The best single page application project ever.'),
    init.prompt('version'),
    init.prompt('repository'),
    init.prompt('homepage'),
    init.prompt('bugs'),
    init.prompt('licenses', 'MIT'),
    init.prompt('author_name',init.defaults.author_name),
    init.prompt('author_email'),
    init.prompt('author_url'),
    init.prompt('jquery_version')
  ], function(err, props) {
    // A few additional properties.
    props.jqueryjson = props.name + '.spa.json';
    props.dependencies = {jquery: props.jquery_version || '>= 1'};

    props.keywords = [];

    // Files to copy (and process).
    var files = init.filesToCopy(props);

    // Add properly-named license files.
    init.addLicenseFiles(files, props.licenses);

    // Actually copy (and process) files.
    init.copyAndProcess(files, props, {noProcess: ['build/**','assets/**']});

    // Generate package.json file, used by npm and grunt.
    init.writePackageJSON('package.json', {
      name: 'jquery-plugin',
      version: '0.0.0-ignored',
      npm_test: 'grunt qunit',
      // TODO: pull from grunt's package.json
      node_version: '>= 0.8.0',
      devDependencies: {
        'grunt-contrib-jshint': '~0.1.1',
        'grunt-contrib-qunit': '~0.1.1',
        'grunt-contrib-concat': '~0.1.2',
        'grunt-contrib-uglify': '~0.1.1',
        'grunt-contrib-watch': '~0.2.0',
        'grunt-contrib-clean': '~0.4.0',
        'grunt-contrib-coffee': '~0.6.4',
        'grunt-contrib-less': '~0.5.0',
        "grunt-contrib-copy": "~0.4.1",
        "grunt-contrib-connect": "~0.2.0",
        "grunt-contrib-htmlmin": "~0.1.1",
        "grunt-contrib-handlebars": "~0.5.8"
      },
    });

    // Generate jquery.json file.
    init.writePackageJSON(props.jqueryjson, props, function(pkg, props) {
      // The jQuery site needs the "bugs" value as a string.
      if ('bugs' in props) { pkg.bugs = props.bugs; }
      return pkg;
    });

    // All done!
    done();
  });

};

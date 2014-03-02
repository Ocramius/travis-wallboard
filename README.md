# Travis Wallboard

Keep eye on your [Travis](https://travis-ci.org/) builds on wall display.


## Usage

Go to [Travis Wallboard](http://keboola.github.io/travis-wallboard/#/) and configure your wallboard.

Displayed repositories are filtered either by Github member name or owner name.


## Development

 * Clone the repo
 * Instal global dependencies `npm install -g grunt-cli bower`
 * Install local dependencies `npm install && bower install --dev`
 * Server, watch and test with live reload `grunt serve`


## Build dist package

* `grunt` builds app into `dist` directory
* You can test it locally `grunt server:dist`
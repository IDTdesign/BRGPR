# Boss Revolution Prepaid Master Card

## First run

1. Clone this perository to any folder you want
2. In that folder run in console one after another:  
    ```
    npm install
    bower install
    ```
    
3. To start project locally run in colsole
    ```
    docpad run
    ```

4. Open in browser [http://localhost:9778](http://localhost:9778)

## Development

`docpad run` — to start locally

`docpad run --env static` — to preview optimized version

`docpad deploy-ghpages --env prod` — publish to http://IDTdesign.github.io/BRGPR

### About Docpad Environments

There are 3 environments in the project:

1. **Development** — default environment. No minification or concatenation on styles and scripts. Default Modernizr.js. 
2. **Static** — optimized for faster loading. All styles merged one file and minified. Same with scripts, output script uses custom Modernizr build. HTML minified and GZIPped.
3. **Prod** — same as static but generated site uses direct urls for http://IDTdesign.github.io/BRGPR

## Publishing

Before first publishing run this command in GIT console  
`git remote add deploy https://login:password@github.com/IDTdesign/BRGPR.git` 

Where *login* and *password* is your Github credentials.

Then run `docpad deploy-ghpages --env prod` — publish to http://IDTdesign.github.io/BRGPR

More info http://paulradzkov.com/2014/deploy_docpad_site_to_github_pages/

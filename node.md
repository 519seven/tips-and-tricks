Node Cheat Sheet
=
```bash
node
mkdir new-project
cd new-project
npm init -y
npm install <...>
touch index.js Dockerfile .dockerignore docker-compose.yml
echo 'node_modules\n.DS_Store\npackage-lock.json' > .gitignore
# Populate index.js
vi index.js and fill it with stuff!
# Run it 
node index.js OR npm start
```

Check version

    node -v || node --version

List installed versions of node (via `nvm`)
    
    nvm ls

Install specific version of node

    nvm install 8.0.0

Set default version of node

    nvm alias default 8.0.0

Switch version of node

    nvm use 8.0.0

If `.nvmrc` exists just use

    nvm use

Switch to a specific version

    nvm use <node_version_or_alias>

Switch to the latest LTS Node version

    nvm use --lts

To list available remote versions of node (via `nvm`)

    nvm ls-remote

 Run app.js using node 6.10.3

    nvm run 6.10.3 app.js

 Run `node app.js` with `PATH` pointing to node 4.8.3

    nvm exec 4.8.3 node app.js

 Set default node version on a shell

    nvm alias default 8.1.0

Always default to the latest available node version on a shell

    nvm alias default node 

Install the latest available version

    nvm install node

Use the latest version

    nvm use node

Install the latest LTS version

    nvm install --lts

Install latest NPM release only

    nvm install-latest-npm

Use the latest LTS version

    nvm use --lts

Set text colors to cyan, green, bold yellow, magenta, and white

    nvm set-colors cgYmW

Remove, delete, or uninstall `nvm` - just remove the `$NVM_DIR` folder (usually `~/.nvm`)

    rm ~/.nvm

List Available Node Releases

    nvm ls-remote
    nvm ls-remote | grep -i "latest"        
    nvm ls-remote | grep -i "<node_version>"

List Installed Nodes

    nvm list node                   // Lists installed Node versions

Lists installed Node versions with additional release info

    nvm list (or) nvm ls

Switch To Another Node Version

    nvm use node                      // Switch to the latest available Node version

Verifying Node Version

    node -v  (or)  node --version
    npm -v   (or)  npm --version
    nvm -v   (or)  nvm --version

Set Alias - always defaults to the latest available node version on a shell

    nvm alias default node

Set default node version on a shell

    nvm alias default <node_version>

Set user-defined alias to Node versions

    nvm alias <alias_name> <node_version> 

Deletes the alias named `<alias_name>`

    nvm unalias <alias_name>

Path to the executable where a specific Node version is installed

    nvm which <installed_node_version>

Uninstall Specific Node Version

    nvm uninstall <node_version>
    
Uninstall the latest LTS release of Node

    nvm uninstall --lts

Uninstall latest (Current) release of Node

    nvm uninstall node

## Getting Started ##
```bash
# Run the following sequence using package-lock.json in a new directory (/tmp/pakey/ntest) or your project's directory (/app/data/project):
$ npm init -y
# accepts all defaults; creates an empty package.json with the defaults
$ npm ci
$ rm package.json
$ npm init -y
# accepts all defaults; creates a package.json with all needed modules added as deps
$ npm list
```

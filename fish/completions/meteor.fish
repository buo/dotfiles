function __fish_meteor_needs_command
  set cmd (commandline -opc)
  if [ (count $cmd) -eq 1 ]
    return 0
  end
  return 1
end

function __fish_meteor_using_command
  set cmd (commandline -opc)
  if [ (count $cmd) -gt 1 ]
    if [ $argv[1] = $cmd[2] ]
      return 0
    end
  end
  return 1
end

# run
complete -c meteor -n '__fish_meteor_needs_command' -a run -d "[default] Run this project in local development mode."
complete -c meteor -n '__fish_meteor_using_command run' -a android        -d "Run on the Android emulator."
complete -c meteor -n '__fish_meteor_using_command run' -a android-device -d "Run on a connected Android device."
complete -c meteor -n '__fish_meteor_using_command run' -a ios            -d "Run on the iOS simulator."
complete -c meteor -n '__fish_meteor_using_command run' -a ios-device     -d "Open Xcode with the iOS project for this app, where you can run your app on a connected iOS device."
complete -c meteor -n '__fish_meteor_using_command run' -s p -l port                      -d "Port to listen on (instead of the default 3000)."
complete -c meteor -n '__fish_meteor_using_command run'      -l debug-port                -d "Specify a port to enable server-side debugging."
complete -c meteor -n '__fish_meteor_using_command run'      -l mobile-server             -d "Location where mobile builds connect to the Meteor server."
complete -c meteor -n '__fish_meteor_using_command run'      -l production                -d "Simulate production mode."
complete -c meteor -n '__fish_meteor_using_command run'      -l raw-logs                  -d "Run without parsing logs from stdout and stderr."
complete -c meteor -n '__fish_meteor_using_command run'      -l settings                  -d "Set optional data for Meteor.settings on the server."
complete -c meteor -n '__fish_meteor_using_command run'      -l release                   -d "Specify the release of Meteor to use."
complete -c meteor -n '__fish_meteor_using_command run'      -l verbose                   -d "Print all output from builds logs."
complete -c meteor -n '__fish_meteor_using_command run'      -l no-lint                   -d "Don't run linters used by the app on every rebuild."
complete -c meteor -n '__fish_meteor_using_command run'      -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."
complete -c meteor -n '__fish_meteor_using_command run'      -l test                      -d "[Experimental] Run Velocity tests using phantomjs and exit."

# debug
complete -c meteor -n '__fish_meteor_needs_command' -a debug -d "Run the project, but suspend the server process for debugging."
complete -c meteor -n '__fish_meteor_using_command debug' -s p -l port                      -d "Port to listen on (instead of the default 3000)."
complete -c meteor -n '__fish_meteor_using_command debug'      -l debug-port                -d "Specify a port to enable server-side debugging."
complete -c meteor -n '__fish_meteor_using_command debug'      -l mobile-server             -d "Location where mobile builds connect to the Meteor server."
complete -c meteor -n '__fish_meteor_using_command debug'      -l production                -d "Simulate production mode."
complete -c meteor -n '__fish_meteor_using_command debug'      -l raw-logs                  -d "Run without parsing logs from stdout and stderr."
complete -c meteor -n '__fish_meteor_using_command debug'      -l settings                  -d "Set optional data for Meteor.settings on the server."
complete -c meteor -n '__fish_meteor_using_command debug'      -l release                   -d "Specify the release of Meteor to use."
complete -c meteor -n '__fish_meteor_using_command debug'      -l verbose                   -d "Print all output from builds logs."
complete -c meteor -n '__fish_meteor_using_command debug'      -l no-lint                   -d "Don't run linters used by the app on every rebuild."
complete -c meteor -n '__fish_meteor_using_command debug'      -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."
complete -c meteor -n '__fish_meteor_using_command debug'      -l test                      -d "[Experimental] Run Velocity tests using phantomjs and exit."

# create
complete -c meteor -n '__fish_meteor_needs_command' -a create -d "Create a new project."
complete -c meteor -n '__fish_meteor_using_command create' -l package -d "Create a new meteor package instead of an app."
complete -c meteor -n '__fish_meteor_using_command create' -l example -d "Example template to use."
complete -c meteor -n '__fish_meteor_using_command create' -l list    -d "Show list of available examples."
complete -c meteor -n '__fish_meteor_using_command create' -l release -d "Specify the release of Meteor to use."

# update
complete -c meteor -n '__fish_meteor_needs_command' -a update -d "Upgrade this project's dependencies to their latest versions."
complete -c meteor -n '__fish_meteor_using_command update' -l packages-only             -d "Update the package versions only. Do not update the release."
complete -c meteor -n '__fish_meteor_using_command update' -l patch                     -d "Update the release to a patch release only."
complete -c meteor -n '__fish_meteor_using_command update' -l release                   -d "Update to a specific release of meteor."
complete -c meteor -n '__fish_meteor_using_command update' -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."

# add
complete -c meteor -n '__fish_meteor_needs_command' -a add -d "Add a package to this project."
complete -c meteor -n '__fish_meteor_using_command add' -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."

# remove
complete -c meteor -n '__fish_meteor_needs_command' -a remove -d "Remove a package from this project."
complete -c meteor -n '__fish_meteor_using_command remove' -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."
# TODO list of the installed packages

# list
complete -c meteor -n '__fish_meteor_needs_command' -a list -d "List the packages explicitly used by your project."

# add-platform
complete -c meteor -n '__fish_meteor_needs_command' -a add-platform -d "Add a platform to this project."
complete -c meteor -n '__fish_meteor_using_command add-platform' -f -a 'server browser android ios'

# remove-platform
complete -c meteor -n '__fish_meteor_needs_command' -a remove-platform -d "Remove a platform from this project."
# TODO list of the added platforms

# list-platforms
complete -c meteor -n '__fish_meteor_needs_command' -a list-platforms -d "List the platforms added to your project."

# build
complete -c meteor -n '__fish_meteor_needs_command' -a build -d "Build this project for all platforms."
complete -c meteor -n '__fish_meteor_using_command build' -l debug                     -d "Build in debug mode (don't minify, etc)."
complete -c meteor -n '__fish_meteor_using_command build' -l directory                 -d "Output a directory (rather than a tarball) for the application server bundle. If the output location exists, it will be recursively deleted first."
complete -c meteor -n '__fish_meteor_using_command build' -l mobile-settings           -d "Set optional data for the initial value of Meteor.settings in your mobile application."
complete -c meteor -n '__fish_meteor_using_command build' -l server                    -d "Location where mobile builds connect to the Meteor server."
complete -c meteor -n '__fish_meteor_using_command build' -l architecture -xa 'os.osx.x86_64 os.linux.x86_64 os.linux.x86_32' -d "Builds the server for a different architecture than your developer machine's architecture."
complete -c meteor -n '__fish_meteor_using_command build' -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."

# lint
complete -c meteor -n '__fish_meteor_needs_command' -a lint -d "Build this project and run the linters printing all errors and warnings."
complete -c meteor -n '__fish_meteor_using_command lint' -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."

# shell
complete -c meteor -n '__fish_meteor_needs_command' -a shell -d "Launch a Node REPL for interactively evaluating server-side code."

# mongo
complete -c meteor -n '__fish_meteor_needs_command' -a mongo -d "Connect to the Mongo database for the specified site."
complete -c meteor -n '__fish_meteor_using_command mongo' -s U -l url -d "Return a URL suitable for an external program to connect to the database."

# reset
complete -c meteor -n '__fish_meteor_needs_command' -a reset -d "Reset the project state. Erases the local database."

# deploy
complete -c meteor -n '__fish_meteor_needs_command' -a deploy -d "Deploy this project to Meteor."
complete -c meteor -n '__fish_meteor_using_command deploy' -s D -l delete                    -d "Permanently delete this deployment"
complete -c meteor -n '__fish_meteor_using_command deploy'      -l debug                     -d "Deploy in debug mode (don't minify, etc)"
complete -c meteor -n '__fish_meteor_using_command deploy'      -l settings                  -d "Set optional data for Meteor.settings"
complete -c meteor -n '__fish_meteor_using_command deploy'      -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."

# logs
complete -c meteor -n '__fish_meteor_needs_command' -a logs -d "Show logs for specified site."

# authorized
complete -c meteor -n '__fish_meteor_needs_command' -a authorized -d "View or change authorized users and organizations for a site."
complete -c meteor -n '__fish_meteor_using_command authorized' -l add    -d "Add an authorized user or organization"
complete -c meteor -n '__fish_meteor_using_command authorized' -l remove -d "Remove an authorized user or organization"
complete -c meteor -n '__fish_meteor_using_command authorized' -l list   -d "List authorized users and organizations (the default)"

# claim
complete -c meteor -n '__fish_meteor_needs_command' -a claim -d "Claim a site deployed with an old Meteor version."

# login
complete -c meteor -n '__fish_meteor_needs_command' -a login -d "Log in to your Meteor developer account."
complete -c meteor -n '__fish_meteor_using_command login' -l email -d "Log in by email address rather than by username"

# logout
complete -c meteor -n '__fish_meteor_needs_command' -a logout -d "Log out of your Meteor developer account."

# whoami
complete -c meteor -n '__fish_meteor_needs_command' -a whoami -d "Prints the username of your Meteor developer account."

# test-packages
complete -c meteor -n '__fish_meteor_needs_command' -a test-packages -d "Test one or more packages."
complete -c meteor -n '__fish_meteor_using_command test-packages' -s p -l port                      -d "Port to listen on (instead of the default 3000)."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l debug-port                -d "Specify a port to enable server-side debugging."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l mobile-server             -d "Location where mobile builds connect to the Meteor server."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l deploy                    -d "Optionally, specify a domain to deploy to, rather than running locally."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l production                -d "Simulate production mode."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l settings                  -d "Set optional data for Meteor.settings on the server."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l android                   -d "Run tests on the Android emulator."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l android-device            -d "Run tests on a connected Android device."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l ios                       -d "Run tests on the iOS simulator."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l ios-device                -d "Run tests on a connected iOS device."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l raw-logs                  -d "Run without parsing logs from stdout and stderr."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l settings                  -d "Set optional data for Meteor.settings on the server."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l test-app-path             -d "Set the directory in which to create a temporary app used for tests."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l velocity                  -d "[Experimental] Execute tests using phantomjs and exit."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l verbose                   -d "Print all output from builds logs."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l no-lint                   -d "Don't run linters used by the app on every rebuild."
complete -c meteor -n '__fish_meteor_using_command test-packages'      -l release                   -d "Specify the release of Meteor to use."

# admin
complete -c meteor -n '__fish_meteor_needs_command' -a admin -d "Administrative commands."
complete -c meteor -n '__fish_meteor_using_command admin' -f -a 'maintainers recommend-release change-homepage list-organizations members get-machine'
# TODO admin sub-command options

# list-sites
complete -c meteor -n '__fish_meteor_needs_command' -a list-sites -d "List sites for which you are authorized."

# publish-release
complete -c meteor -n '__fish_meteor_needs_command' -a publish-release -d "Publish a new meteor release to the package server."
complete -c meteor -n '__fish_meteor_using_command publish-release' -l create-track -d "Publish a new release track."

# publish
complete -c meteor -n '__fish_meteor_needs_command' -a publish -d "Publish a new version of a package to the package server."
complete -c meteor -n '__fish_meteor_using_command publish' -l create                    -d "Publish a new package."
complete -c meteor -n '__fish_meteor_using_command publish' -l update                    -d "Change the metadata of a previously published version."
complete -c meteor -n '__fish_meteor_using_command publish' -l allow-incompatible-update -d "Allow packages in your project to be upgraded or downgraded to versions that are potentially incompatible with the current versions, if required to satisfy all package version constraints."
complete -c meteor -n '__fish_meteor_using_command publish' -l no-lint                   -d "Don't run linters on the published package and its local dependencies before publishing."

# publish-for-arch
complete -c meteor -n '__fish_meteor_needs_command' -a publish-for-arch -d "Builds an already-published package for a new platform."

# search
complete -c meteor -n '__fish_meteor_needs_command' -a search -d "Search through the package server database."
complete -c meteor -n '__fish_meteor_using_command search' -l maintainer -d "filter by authorized maintainer"
complete -c meteor -n '__fish_meteor_using_command search' -l show-all   -d "show all matches, even prereleases"
complete -c meteor -n '__fish_meteor_using_command search' -l ejson      -d "show more detailed output in EJSON format"

# show
complete -c meteor -n '__fish_meteor_needs_command' -a show -d "Show detailed information about a release or package."
complete -c meteor -n '__fish_meteor_using_command show' -l ejson      -d "show more detailed output in EJSON format"
complete -c meteor -n '__fish_meteor_using_command show' -l show-all   -d "show hidden versions of packages and releases"

# help
complete -c meteor -n '__fish_meteor_needs_command' -a help -d "Display help"
complete -c meteor -n '__fish_meteor_using_command help' -f -a 'run debug create update add remove list add-platform remove-platform list-platforms build lint shell mongo reset deploy logs authorized claim login logout whoami test-packages admin list-sites publish-release publish publish-for-arch search show'

# other options
complete -c meteor -l version -d "Show the version number"
complete -c meteor -l arch    -d "Show the architecture"

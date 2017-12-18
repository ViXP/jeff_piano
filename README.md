# Jeff Piano
Sample project for **SD Solutions**

## Instructions
This project requires Ruby *bundler*, several Ruby gems (listed in `Gemfile`),
*PostgreSQL* for database and *NodeJS, YARN* (version specified in 
`package.json`) for frontend compiling. If YARN and bundler are installed, the 
other dependencies can be installed with `bundle` and `yarn` terminal commands.

The initial data for DB (specified in technical task) can be seeded with 
`rails db:seed` command (be sure to run `rails db:create` and 
`rails db:migrate` first ;)

Local web + app servers, and webpack dev server can be run with these commands
inside the base project directory:
`rails s -p 3000`
`./bin/webpack-dev-server`
Or you can use *foreman* utility for simply running all the servers with the 
single command: `foreman start`

## Notes
Please, use this project with local domain (ex. localhost instead of 127.0.0.1)
for 'api.' subdomain support which is required for JSON API!

The *streamio-ffmpeg* which is used for defining the video duration requires 
the newest version of ffmpeg (can be installed with `brew install ffmpeg` on
MacOS)

## Todos
React component and partial for errors output, videos preloading functionality,
unit, functional, integration tests, caching implementation, 
internationalization, etc. 
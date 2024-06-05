# NGINX Image for SPA | SSG | Files

Mostly used for React, Vue, Next (SSG/Files), Gatsby

## Caching Headers

Static files extensions: css, js, jsx, htc, cur, svg, gif, jp?g, png, ico, otf, ttf, eot, woff, woff2, xls, doc, exe, tgx, sng

Responses with these file extensions return HTTP headers that allow caching content indefinitely in the browser, CDN (e.g., Cloudflare), and proxy servers.
This is not a problem because most framework builders generate unique filenames with a hash of their content.
In case a file changes, its name will change too.

All other responses return HTTP headers that forbid caching at all levels.
This is needed to prevent caching pages with static URLs like index.html or other static HTML pages with SSG. 

## Environment variables

### APP_TYPE

Possible values:
 - **spa** - for single-page applications, returns index.htm(l) if the file is not found
 - **ssg** - for server-side generated applications, returns HTML pages without caching
 - **files** - for static files that return with cache HTTP headers

### DISALLOW_ROBOTS
 - 1 - returns /robot.txt with Disallow for all robots
 - 0 - do nothing

## Usage

### Build

Multistage build for React/Vue SPA app closed from robots.

Dockerfile
```
ARG NODE_VERSION="22.2.0"

FROM node:${NODE_VERSION} as dependencies
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm i

FROM node:${NODE_VERSION} as build
WORKDIR /app
COPY ./ ./
COPY --from=dependencies /app/node_modules ./node_modules
RUN npm run build

FROM malevichstudio/nginx:1.27.0
ENV APP_TYPE=spa
ENV DISALLOW_ROBOTS=1
COPY --from=build /app/public /usr/share/nginx/html
```
```
$ docker build -t my-static-app .
```

### Docker

```
$ docker run -p 8080:80 -v ./public:/usr/share/nginx/html -e APP_TYPE=ssg malevichstudio/nginx
```

### Docker Compose

```
services:

  files:
    image: malevichstudio/nginx:1.27.0
    ports:
      - 8081:80
    volumes:
      - ./files:/usr/share/nginx/html
    environment:
      APP_TYPE: files

  dashboard:
    image: my-static-app
    ports:
      - 8080:80
    environment:
      DISALLOW_ROBOTS: 1
```

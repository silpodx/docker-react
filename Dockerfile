# will have two stages/images built here -> mark 1st as builder
# .1. install deps +
FROM  node:alpine as builder
WORKDIR  /app
COPY  package.json  .
RUN npm install
COPY  . .
RUN npm run build
# this was the whole purpose of 1st step, next is to bring nginx. No more adj
# so no volumes or other tricks. Recall the folder in which al resides above
# is:
#   /app/build

# .2. the run phase [ FROM indicates end of previous block: builder ]
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html
# this is the place where nginx needs files [ from github about nginx... ]

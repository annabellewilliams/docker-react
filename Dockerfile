FROM node:16-alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# FROM statement will stop the previous step
FROM nginx
#EXPOSE 80 # apparently not needed, Elastic Beanstalk will use this instruction to map to a port
COPY --from=builder /app/build /usr/share/nginx/html
# default NGINX command will serve the static files

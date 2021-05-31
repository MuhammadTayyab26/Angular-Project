# Step 1: Build the app in image 'builder'
FROM node:12.8-alpine AS builder

WORKDIR /usr
COPY ["Source/Microservices/Microservice1", "src/app/"]
##COPY . .
WORKDIR "/usr/src/app"
RUN yarn && yarn build

# Step 2: Use build output from 'builder'
FROM nginx:stable-alpine
LABEL version="1.0"

#COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /usr/src/app/nginx.conf /etc/nginx/nginx.conf
WORKDIR /usr/share/nginx/html
COPY --from=builder /usr/src/app/dist/my-angular-app/ .
EXPOSE 80

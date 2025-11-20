# Multi-stage build
FROM node:18-alpine AS builder

WORKDIR /app
COPY app/package*.json ./
RUN npm ci --only=production

COPY app/ .
RUN npm run build

# Production stage
FROM nginx:alpine
COPY --from=builder /app/build /usr/share/nginx/html
COPY docker/nginx.conf /etc/nginx/nginx.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

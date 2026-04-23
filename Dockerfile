# Stage 1 - Builder
FROM node:18 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY index.js ./

# Stage 2 - Production
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/index.js ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./
EXPOSE 3000
CMD ["node", "index.js"]

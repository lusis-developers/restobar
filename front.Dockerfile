FROM node:16 as builder
WORKDIR /app
RUN npm i pnpm --global --force
COPY ./frontend/package*.json ./
COPY ./frontend .
RUN pnpm install
RUN pnpm run build

FROM node:14 as runner
WORKDIR /
RUN npm i serve --global --force 
COPY --from=builder ./app/build ./app/build
CMD ["serve", "-s", "./app/build"]
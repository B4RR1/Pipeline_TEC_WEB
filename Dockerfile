
# Paso1: Build
FROM node:18-alpine AS build
WORKDIR /app

# Copiar package.json y package-lock.json y instalar dependencias
COPY package*.json ./
RUN npm install

# Copiar el resto del codigo y compilar la app
COPY . .
RUN npm run build

# Paso2: Produccion
FROM nginx:stable-alpine
# Copiar los archivos compilados al servidor Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exponer puerto 80
EXPOSE 80

# Arrancar Nginx
CMD ["nginx", "-g", "daemon off;"]

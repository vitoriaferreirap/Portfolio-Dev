# Use uma imagem Node.js como base
FROM node:18

# Defina o diretório de trabalho para a aplicação
WORKDIR /usr/src/app

# Copie o package.json e package-lock.json para instalar as dependências principais (concurrently)
COPY package*.json ./
RUN npm install

# Copie o backend e o frontend para dentro do container
COPY Backend /usr/src/app/Backend
COPY Frontend /usr/src/app/Frontend

# Instale as dependências do backend
WORKDIR /usr/src/app/Backend
COPY Backend/package*.json ./
RUN npm install

# Instale as dependências do frontend
WORKDIR /usr/src/app/Frontend
COPY Frontend/package*.json ./
RUN npm install

# Volte para o diretório principal para iniciar ambos os servidores
WORKDIR /usr/src/app

# Exponha a porta do backend
EXPOSE 8080

# Comando para iniciar ambos os servidores com concurrently
CMD ["npm", "start"]

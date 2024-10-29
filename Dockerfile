# Use uma imagem Node.js como base
FROM node:18

# Defina o diretório de trabalho para a aplicação
WORKDIR /usr/src/app

# Copie o package.json e package-lock.json para instalar as dependências
COPY package*.json ./

# Instale as dependências principais (concurrently)
RUN npm install

# Copie o backend e o frontend para dentro do container
COPY Backend /usr/src/app/Backend
COPY Frontend /usr/src/app/Frontend

# Instale as dependências do backend
WORKDIR /usr/src/app/Backend
RUN npm install

# Instale as dependências do frontend
WORKDIR /usr/src/app/Frontend
RUN npm install

# Volte para o diretório principal para iniciar ambos os servidores
WORKDIR /usr/src/app

# Porta do backend e frontend
EXPOSE 8080 5000

# Comando para iniciar ambos os servidores com concurrently
CMD ["npm", "start"]

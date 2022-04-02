Proceso
======

- Para docker:
  ```sh
  #Construir la imagen
  docker build -t devops-challenge:v1 .
  #Ejecutar contenedor en segundo plano
  docker run --rm -p 3000:3000 -d localhost/devops-challenge:v1
  ```

- Probar endpoints:
  ```sh
  curl -X GET localhost:3000/
  curl -X GET localhost:3000/cheers
  curl -X GET localhost:3000/private
  ```

- Para Jenkins:
  1. Configurar Jenkins con plugins de pipeline, clue ocean y docker
  2. Configurar credenciales de GitHU
  3. COnfigurar credenciales de DockerHub

- Para terraform:
  ```sh
  cd infra
  #Actualizar el archivo cred.tf con las credenciales correctas
  terraform init
  terraform apply
  ```
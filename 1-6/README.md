Docker Image

   1.Log to  Dockerhub 
   2. Create image -  docker build -t user_dockerhub/nginx_hw_otus:1.0 .
   3. push to the regestry - docker push user_dockerhub/nginx_hw_otus:1.0
   4. check you image - docker run -d --rm -p 80:80 user_dockerhub/nginx_hw_otus:1.0
    
	 <code>curl localhost:80 </code>
	 
    <title>Welcome to nginx!</title> <style> body { width: 35em; margin: 0 auto; font-family: Tahoma, Verdana, Arial, sans-serif; } </style>

    <i>Welcome to nginx!

    If you see this page, the nginx web server is successfully installed and working. Further configuration is required.

    For online documentation and support please refer to nginx.org.
    Commercial support is available at nginx.com.

    Thank you for using nginx.</i>

 



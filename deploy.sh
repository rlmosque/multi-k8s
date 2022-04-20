docker build -t lizmoscre/multi-client:latest -t lizmoscre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lizmoscre/multi-server:latest -t lizmoscre/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lizmoscre/multi-worker:latest -t lizmoscre/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lizmoscre/multi-client:latest
docker push lizmoscre/multi-server:latest
docker push lizmoscre/multi-worker:latest

docker push lizmoscre/multi-client:$SHA
docker push lizmoscre/multi-server:$SHA
docker push lizmoscre/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server lizmoscre/multi-server:$SHA
kubectl set image deployments/client-deployment client lizmoscre/multi-client:$SHA
kubectl set image deployments/worker-deployment worker lizmoscre/multi-worker:$SHA
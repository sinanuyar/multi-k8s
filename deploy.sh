docker build -t sinanuyar/multi-client:latest -t sinanuyar/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sinanuyar/multi-server:latest -t sinanuyar/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sinanuyar/multi-worker:latest -t sinanuyar/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sinanuyar/multi-client:latest
docker push sinanuyar/multi-server:latest
docker push sinanuyar/multi-worker:latest

docker push sinanuyar/multi-client:$SHA
docker push sinanuyar/multi-server:$SHA
docker push sinanuyar/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sinanuyar/multi-server:$SHA
kubectl set image deployments/client-deployment client=sinanuyar/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sinanuyar/multi-worker:$SHA
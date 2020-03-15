docker build -t paclflst/multi-client:latest -t paclflst/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t paclflst/multi-server:latest -t paclflst/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t paclflst/multi-worker:latest -t paclflst/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push paclflst/multi-client:latest
docker push paclflst/multi-server:latest
docker push paclflst/multi-worker:latest

docker push paclflst/multi-client:$SHA
docker push paclflst/multi-server:$SHA
docker push paclflst/multi-worker:$SHA


kubectl apply -f k8s
kubectl set image deployments/client-deployment client=paclflst/multi-client:$SHA
kubectl set image deployments/server-deployment server=paclflst/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=paclflst/multi-worker:$SHA
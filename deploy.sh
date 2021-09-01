docker build -t tonyduong1112/multi-client:latest -t tonyduong1112/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tonyduong1112/multi-server:latest -t tonyduong1112/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tonyduong1112/multi-worker:latest -t tonyduong1112/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tonyduong1112/multi-client:latest
docker push tonyduong1112/multi-server:latest
docker push tonyduong1112/multi-worker:latest

docker push tonyduong1112/multi-client:$SHA
docker push tonyduong1112/multi-server:$SHA
docker push tonyduong1112/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tonyduong1112/multi-server:$SHA
kubectl set image deployments/client-deployment client=tonyduong1112/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tonyduong1112/multi-worker:$SHA

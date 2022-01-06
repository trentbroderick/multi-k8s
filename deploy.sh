docker build -t trentbroderick/multi-client:latest -t trentbroderick/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t trentbroderick/multi-server:latest -t trentbroderick/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t trentbroderick/multi-worker:latest -t trentbroderick/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push trentbroderick/multi-client:latest
docker push trentbroderick/multi-server:latest
docker push trentbroderick/multi-worker:latest
docker push trentbroderick/multi-client:$SHA
docker push trentbroderick/multi-server:$SHA
docker push trentbroderick/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=trentbroderick/multi-server:$SHA
kubectl set image deployments/client-deployment client=trentbroderick/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=trentbroderick/multi-worker:$SHA


#### Minikube
```
$ brew install minikube
$ minikube start --cni=cilium --memory=4096
```

#### Deploy
```
$ kubectl create ns grpc-api
$ kubectl -n grpc-api apply -f cluster/.
```

### Tunnel
```
$ minikube service gateway -n grpc-api
```

### Delete
```
kubectl delete ns grpc-api
```

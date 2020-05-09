#### Deploy
```
$ kubectl --kubeconfig kubeconfig.yml apply -f cluster/.
```

### Delete
```
kubectl --kubeconfig kubeconfig.yml delete service,deployment,networkpolicy,pods
```

echo-k8s-sample-app
===================

実行時は環境変数 `APPNAME` を設定してください。

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: echo-a-deployment
  labels:
    app: echo-a
spec:
  replicas: 2
  selector:
    matchLabels:
      app: echo-a
  template:
    metadata:
      labels:
        app: echo-a
    spec:
      containers:
      - name: echo-a
        image: mtada/echo-k8s-sample-app:latest
        ports:
        - containerPort: 80
        env:
          - name: APPNAME
            value: A
```

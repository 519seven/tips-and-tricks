# Kubernetes

## Entrypoints

### Shell

    ...
    spec:
        containers:
        - name: vue-gui-1
          image: ${DOCKER_REGISTRY}:${PORT}/${NAMESPACE}/${IMAGE_NAME}
          imagePullPolicy: Always
          # override ENTRYPOINT
          command:
            - sleep
          args:
            - infinity
    ...

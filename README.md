# MTL Assignment

### Instruction of how to deploy the ArgoCD application with CLI.

1. Install ArgoCD CLI [https://github.com/argoproj/argo-cd/releases](https://github.com/argoproj/argo-cd/releases).

2. Connect to ArgoCD Server.
   ```sh
   argocd login <ARGOCD_SERVER> --username <USERNAME> --password <PASSWORD>
   ```
3. List the application managed by ArgoCD to verify that your application is already exist or not.
   ```sh
   argocd app list
   ```
4. If your application is not already exist, create a new ArgoCD deployment.
   ```sh
   argocd app create <APPLICATION_NAME> \
            --project <PROJECT_NAME>
            --repo <GIT_REPO_URL> \
            --path <PATH_TO_APPLICATION_YAML> \
            --dest-server https://kubernetes.default.svc \
            --dest-namespace <DEST_NAMESPACE> \
   ```
   **argo app create with variables:**
   ```sh
   argocd app create mtl-assignment-app \
            --project default
            --repo https://github.com/anuchit17219/mtl-assaignment-ops.git \
            --path ./manifest \
            --dest-namespace default \
            --dest-server https://kubernetes.default.svc
   ```
5. Another option to create application is by writing a YAML file and use kubectl apply to deploy ArgoCD application.
    
    ```sh
   kubectl apply -f <ARGOCD_APPLICATION.YAML>
   ```
   **ArgoCD application example:**
   _For example, please refer to the [ArgoCD Helm chart](https://github.com/anuchit17219/mtl-assignment/tree/main/helm/argocd-app)_.
   ```yaml
   apiVersion: argoproj.io/v1alpha1
    kind: Application
    metadata:
      name: mtl-assignment-app
      namespace: argocd
      finalizers:
      - resources-finalizer.argocd.argoproj.io
    spec:
      project: default
      destination:
        namespace: default
        server: https://kubernetes.default.svc
      source:
        path: ./manifest
        repoURL: 'https://github.com/anuchit17219/mtl-assaignment-ops.git'
        targetRevision: HEAD
      syncPolicy:
        automated:
          prune: true
          selfHeal: true
   ```